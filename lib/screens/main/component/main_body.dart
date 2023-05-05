import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_money/screens/main/view_model/main_view_model.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../../../data/company.dart';

const List<String> timeList = ["1D", "1W", "1M", "6M", "1Y"];

class MainBody extends ConsumerStatefulWidget {
  const MainBody({super.key});

  @override
  ConsumerState<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends ConsumerState<MainBody>
    with TickerProviderStateMixin {
  @override
  void dispose() {
    // _firstScrollController.dispose();
    // _secondScrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final mainViewModel = ref.watch(mainViewModelProvider);
      initStateFun(mainViewModel);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double? height = MediaQuery.of(context).size.height;
    double? width = MediaQuery.of(context).size.width;
    final mainViewModel = ref.watch(mainViewModelProvider);
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            firstWidget(mainViewModel.height),
            secondWidget(width, height, mainViewModel),
            listViews(mainViewModel.showListView, mainViewModel),
          ],
        ),
        dismissableDilog(width, mainViewModel),
      ],
    );
  }

  void initStateFun(MainViewModel mainViewModel) {
    mainViewModel.firstScrollController =
        ScrollController(initialScrollOffset: 140.0);
    mainViewModel.secondScrollController =
        ScrollController(initialScrollOffset: 140.0);
    mainViewModel.dialogController = AnimationController(
      duration: const Duration(milliseconds: 1100),
      vsync: this,
    );
    mainViewModel.controller = AnimationController(
      duration: const Duration(milliseconds: 180),
      vsync: this,
    );

    mainViewModel.dialogScaleController = AnimationController(
      duration: const Duration(milliseconds: 1100),
      vsync: this,
    );

    mainViewModel.animation =
        Tween(begin: 1.0, end: 0.8).animate(mainViewModel.controller);
    mainViewModel.defaultAnimation =
        Tween(begin: 1.0, end: 1.0).animate(mainViewModel.controller);
    mainViewModel.firstRightToLeftAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    mainViewModel.boxesController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );
    mainViewModel.rightToLeftListviewController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    mainViewModel.firstRightToLeftAnim = Tween(
      begin: const Offset(2, 0),
      end: const Offset(-1, 0),
    ).animate(CurvedAnimation(
        parent: mainViewModel.firstRightToLeftAnimController,
        curve: Curves.easeOut));

    mainViewModel.secondRightToLeftAnim = Tween(
      begin: const Offset(-2, 0),
      end: const Offset(1, 0),
    ).animate(CurvedAnimation(
        parent: mainViewModel.firstRightToLeftAnimController,
        curve: Curves.easeOut));

    mainViewModel.rightBoxAnim = Tween(
      begin: const Offset(8, 0),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
        parent: mainViewModel.boxesController, curve: Curves.easeOut));

    mainViewModel.leftBoxAnim = Tween(
      begin: const Offset(-2, 0),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
        parent: mainViewModel.boxesController, curve: Curves.easeOut));

    mainViewModel.rightToLeftListviewAnim = Tween(
      begin: const Offset(2, 0),
      end: const Offset(0, 0),
    ).animate(mainViewModel.rightToLeftListviewController);

    mainViewModel.dialogAnim = Tween(
      begin: const Offset(1.0, 1.0),
      end: mainViewModel.currentItemPostion,
    ).animate(mainViewModel.dialogController);

    Future.delayed(const Duration(microseconds: 0)).then((value) async {
      setState(() {
        mainViewModel.height = 300;
      });
      await Future.delayed(
        const Duration(milliseconds: 700),
      );
      mainViewModel.boxesController.forward();
    });

    mainViewModel.boxesController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        mainViewModel.rightToLeftListviewController.forward();
      }
    });
    mainViewModel.rightToLeftListviewController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        mainViewModel.firstRightToLeftAnimController.forward();
      }
    });

    mainViewModel.firstRightToLeftAnimController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          mainViewModel.showListView = true;
        });
      }
    });
  }

  Widget firstWidget(double height) {
    return AnimatedContainer(
      height: height,
      duration: const Duration(milliseconds: 1500),
      margin: const EdgeInsets.only(right: 3, left: 3),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF1edee4),
              Color(0xFF1edee4),
              Color(0xFF1799d7),
              Color(0xFF1786db),
              Color(0xFF051ed9),
            ],
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 23, left: 12),
                child: Column(
                  children: const [
                    Text(
                      "Hello, Amir!",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Let's invest together!",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w200),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 16, top: 12),
                width: 60,
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    "assets/images/user_prof.jpeg",
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "\$25 800",
                  style: TextStyle(
                      fontSize: 50,
                      color: Colors.white.withOpacity(0.8),
                      fontWeight: FontWeight.w400),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  width: 80,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white.withOpacity(0.4),
                  ),
                  child: Center(
                    child: Text(
                      "+\$620",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.9), fontSize: 18),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget secondWidget(
      double width, double height, MainViewModel mainViewModel) {
    return SlideTransition(
      position: mainViewModel.leftBoxAnim,
      child: Container(
        margin: const EdgeInsets.only(right: 5, left: 5, top: 12),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            width: width / 2 - 10,
            height: height * .18,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: const Color(0xFF0a0720)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Top Up",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Container(
                  width: 10,
                ),
                RotatedBox(
                  quarterTurns: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1.5),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(3),
                      child: const Icon(
                        Icons.arrow_outward,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SlideTransition(
            position: mainViewModel.rightBoxAnim,
            child: InkWell(
              onTap: () {
                setState(() {
                  mainViewModel.height = height / 2 - 120;
                });
              },
              child: Container(
                width: width / 2 - 10,
                height: height * .18,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: const Color(0xFF0a0720)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Withdraw",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Container(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1.5),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(3),
                        child: const Icon(
                          Icons.arrow_outward,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget listViews(bool showListView, MainViewModel mainViewModel) {
    return Column(
      children: [
        SlideTransition(
          position: mainViewModel.rightToLeftListviewAnim,
          child: Container(
            height: 80,
            margin: const EdgeInsets.only(top: 20),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: companyList.length,
              itemBuilder: (context, index) {
                return companyItem(0, index, mainViewModel);
              },
            ),
          ),
        ),
        showListView
            ? Container(
                height: 80,
                margin: const EdgeInsets.only(top: 20),
                child: ListView.builder(
                  shrinkWrap: true,
                  controller: mainViewModel.firstScrollController,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      companyList.where((e) => e.hasBenefit).toList().length,
                  itemBuilder: (context, index) {
                    return companyItem(1, index, mainViewModel);
                  },
                ),
              )
            : SlideTransition(
                position: mainViewModel.firstRightToLeftAnim,
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: 215,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.topLeft,
                      colors: [
                        Color(0xFF3fdcd6),
                        Color(0xFF48eace),
                        Color(0xFF90e6cf)
                      ],
                    ),
                  ),
                ),
              ),
        showListView
            ? Container(
                height: 80,
                margin: const EdgeInsets.only(top: 15),
                child: ListView.builder(
                  controller: mainViewModel.secondScrollController,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: companyList.where((e) => !e.hasBenefit).length,
                  itemBuilder: (context, index) {
                    return companyItem(2, index, mainViewModel);
                  },
                ),
              )
            : SlideTransition(
                position: mainViewModel.secondRightToLeftAnim,
                child: Container(
                  margin: const EdgeInsets.only(top: 15),
                  width: 215,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF5810df),
                        Color(0xFF4f0cdc),
                        Color(0xFF3d06db),
                        Color(0xFF0e07ca)
                      ],
                    ),
                  ),
                ),
              )
      ],
    );
  }

  Widget companyItem(
      int listViewIndex, int index, MainViewModel mainViewModel) {
    Company company = listViewIndex == 0
        ? companyList[index]
        : listViewIndex == 1
            ? companyList.where((e) => e.hasBenefit).toList()[index]
            : companyList.where((e) => !e.hasBenefit).toList()[index];

    return company.name != ""
        ? ScaleTransition(
            scale: mainViewModel.selectedCompanyIndex == index
                ? mainViewModel.animation
                : mainViewModel.defaultAnimation,
            child: Center(
              child: Container(
                width: 215,
                height: 80,
                margin: EdgeInsets.only(right: 15, left: index == 0 ? 30 : 0),
                decoration: BoxDecoration(
                  color: const Color(0xFF0a0720),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Listener(
                  onPointerDown: (details) async {
                    // print(details.localPosition);
                    // _dialogScaleController.forward();
                    mainViewModel.timer = Timer(
                      const Duration(milliseconds: 1000), () {},
                      // onLongerPress
                    );
                    setState(() {
                      mainViewModel.currentItemPostion = details.localPosition;
                      mainViewModel.dialogMode = listViewIndex;
                      mainViewModel.selectedCompanyMode = listViewIndex;
                      mainViewModel.controller.forward();
                      mainViewModel.color = Colors.white;
                      mainViewModel.selectedCompanyIndex = index;
                    });

                    // dialogAnim = Tween(
                    //   begin: const Offset(0, 1),
                    //   end: const Offset(0, 0),
                    // ).animate(CurvedAnimation(
                    //     parent: _dialogController,
                    //     curve: Curves.fastOutSlowIn));
                    // _dialogController.forward();
                  },
                  onPointerUp: (details) {
                    // _dialogScaleController.reverse();
                    // _dialogController.reverse();

                    mainViewModel.timer.cancel();
                    mainViewModel.controller.reverse();
                    setState(() {
                      mainViewModel.color = Colors.white.withOpacity(0.7);
                    });
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 12),
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: const Color(0xFF1b193d),
                          ),
                          child: Center(
                              child: AnimatedContainer(
                            width: 27,
                            height: 27,
                            duration: const Duration(milliseconds: 400),
                            child: Image.asset(
                              company.companyLogo,
                              color: mainViewModel.selectedCompanyIndex == index
                                  ? mainViewModel.color
                                  : Colors.white.withOpacity(0.8),
                            ),
                          )),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 12, left: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                company.name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF47417d),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      "\$${company.price.toString()}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white.withOpacity(0.8),
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 8),
                                      child: Text(
                                        company.hasBenefit
                                            ? "+${company.changePercent}%"
                                            : "-${company.changePercent}%",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: company.hasBenefit
                                                ? Colors.green.withOpacity(0.7)
                                                : Colors.red.withOpacity(0.7),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        : listViewIndex == 0
            ? Container()
            : Container(
                height: 80,
                margin: const EdgeInsets.only(left: 5),
                width: 215,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.topLeft,
                    colors: [
                      listViewIndex == 1
                          ? const Color(0xFF3fdcd6)
                          : const Color(0xFF5810df),
                      listViewIndex == 1
                          ? const Color(0xFF48eace)
                          : const Color(0xFF4f0cdc),
                      listViewIndex == 1
                          ? const Color(0xFF90e6cf)
                          : const Color(0xFF0e07ca)
                    ],
                  ),
                ),
                child: Row(
                  children: const [],
                ),
              );
  }

  SlideTransition dismissableDilog(double width, MainViewModel mainViewModel) {
    Company selectedUnBenefitedCompany = mainViewModel.dialogMode == 0
        ? companyList[mainViewModel.selectedCompanyIndex]
        : companyList
            .where((e) =>
                mainViewModel.dialogMode == 1 ? e.hasBenefit : !e.hasBenefit)
            .toList()[mainViewModel.selectedCompanyIndex];
    return SlideTransition(
      position: mainViewModel.dialogAnim,
      child: ScaleTransition(
        scale: mainViewModel.dialogScaleController,
        child: GestureDetector(
          onLongPress: () {
            setState(() {
              mainViewModel.showDialogMonth = true;
              mainViewModel.dialogHeight = 480;
            });
          },
          child: AnimatedContainer(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(35),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black,
                  Color(0xFF020010),
                  Color.fromARGB(255, 0, 6, 166)
                ],
                stops: [0.9, 0.4, 0.8],
              ),
            ),
            duration: const Duration(milliseconds: 500),
            width: mainViewModel.dialogWidth,
            height: mainViewModel.dialogHeight,
            alignment: Alignment.center,
            child: Container(
              color: Colors.transparent,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: width - 100,
                    height: 120,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 2, 4, 89),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100),
                        topRight: Radius.circular(100),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: SizedBox(
                          width: width,
                          height: 150,
                        ),
                      ),
                    ),
                  ),
                  mainViewModel.showDialogScreen
                      ? BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                          child: const SizedBox(
                            width: 0,
                            height: 0,
                          ),
                        )
                      : Container(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 7),
                              child: const Icon(
                                Icons.paypal,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              mainViewModel.currentItemPostion.toString(),
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: Text(
                          selectedUnBenefitedCompany.price.toString(),
                          style: const TextStyle(
                              fontSize: 28, color: Colors.white),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: Text(
                          selectedUnBenefitedCompany.hasBenefit
                              ? "+${selectedUnBenefitedCompany.changePercent}%"
                              : "-${selectedUnBenefitedCompany.changePercent}%",
                          style: TextStyle(
                            fontSize: 20,
                            color: selectedUnBenefitedCompany.hasBenefit
                                ? Colors.green.withOpacity(0.7)
                                : Colors.red.withOpacity(0.7),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            top: 35, bottom: 10, left: 15, right: 15),
                        child: SfSparkLineChart(
                          axisLineColor: Colors.transparent,
                          data: selectedUnBenefitedCompany
                              .chardData[mainViewModel.selectedItem].data,
                          trackball: const SparkChartTrackball(
                              color: Colors.white,
                              activationMode: SparkChartActivationMode.tap),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 16),
                        child: Row(
                          children: const [
                            Text(
                              "12:30",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            SizedBox(
                              width: 55,
                            ),
                            Text(
                              "13:30",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            SizedBox(
                              width: 55,
                            ),
                            Text(
                              "14:30",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            SizedBox(
                              width: 55,
                            ),
                            Text(
                              "15:30",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      mainViewModel.showDialogMonth
                          ? Container(
                              margin: const EdgeInsets.only(top: 30),
                              height: 30,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: timeList.length,
                                itemBuilder: (context, index) {
                                  String title = timeList[index];
                                  return AnimatedContainer(
                                    duration: const Duration(seconds: 1),
                                    decoration: BoxDecoration(
                                      color: mainViewModel.selectedItem == index
                                          ? Colors.white
                                          : const Color(0xFF080720),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    margin: const EdgeInsets.only(
                                        right: 5, left: 20),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          mainViewModel.selectedItem = index;
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Center(
                                          child: Text(
                                            title,
                                            style: TextStyle(
                                              color:
                                                  mainViewModel.selectedItem ==
                                                          index
                                                      ? Colors.black
                                                      : const Color(0xFF504d72),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Container()
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onLongerPress(MainViewModel mainViewModel) {
    print('onLongerPress called');
    // setState(() {
    // mainViewModel.showDialogScreen = true;
    // if (mainViewModel.dialogWidth != 0) {
    // dialogWidth = 0;
    // dialogHeight = 0;
    // } else {
    // dialogWidth = 350;
    // dialogHeight = 420;
    // }
    // });
  }
}
