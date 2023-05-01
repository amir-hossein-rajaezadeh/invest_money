import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

@immutable
class Company {
  final String name;
  final double price;
  final double changePercent;
  final bool hasBenefit;
  final String companyLogo;

  const Company(
      {required this.name,
      required this.changePercent,
      required this.price,
      required this.hasBenefit,
      required this.companyLogo});
}

const companyList = [
  Company(
      name: "", price: 0, changePercent: 0, hasBenefit: true, companyLogo: ""),
  Company(
      name: "Google",
      price: 100.27,
      changePercent: 0.55,
      hasBenefit: true,
      companyLogo: "assets/images/google.png"),
  Company(
      name: "Shopify",
      price: 44.67,
      changePercent: 0.47,
      hasBenefit: false,
      companyLogo: "assets/images/shopify.png"),
  Company(
      name: "Dropbox",
      price: 19.9,
      changePercent: 1.07,
      hasBenefit: true,
      companyLogo: "assets/images/dropbox.png"),
  Company(
      name: "Apple",
      price: 155.48,
      changePercent: 0.47,
      hasBenefit: true,
      companyLogo: "assets/images/apple.png"),
  Company(
      name: "PayPal",
      price: 72.05,
      changePercent: 1.14,
      hasBenefit: false,
      companyLogo: "assets/images/paypal.png"),
  Company(
      name: "", price: 0, changePercent: 0, hasBenefit: false, companyLogo: ""),
];
// var benefitedCompanyList = companyList.where((e) => e.hasBenefit);
// var nonBenefitedCompanyList = companyList.where((e) => !e.hasBenefit);

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late Timer _timer;

  late ScrollController _firstScrollController;
  late ScrollController _secondScrollController;
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<Offset> firstRightToLeftAnim;
  late AnimationController firstRightToLeftAnimController;
  late Animation<Offset> secondRightToLeftAnim;
  late Animation<Offset> rightBoxAnim;
  late Animation<Offset> leftBoxAnim;
  late Animation<Offset> rightToLeftListviewAnim;
  late AnimationController rightToLeftListviewController;
  late AnimationController boxesController;
  int dialogMode = 0;
  bool showDialogScreen = false;
  var selectedCompanyIndex = 0;
  bool showListView = false;
  int selectedItem = 0;
  double dialogWidth = 0;
  double dialogHeight = 0;
  double listviewItemWidth = 215;
  double listviewItemHeight = 80;

  @override
  void dispose() {
    _firstScrollController.dispose();
    _secondScrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _firstScrollController = ScrollController(initialScrollOffset: 140.0);
    _secondScrollController = ScrollController(initialScrollOffset: 140.0);
    _controller = AnimationController(
      duration: const Duration(milliseconds: 370),
      vsync: this,
    );
    _animation = Tween(begin: 1.0, end: 0.7).animate(_controller);

    firstRightToLeftAnimController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    boxesController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );
    rightToLeftListviewController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    firstRightToLeftAnim = Tween(
      begin: const Offset(2, 0),
      end: const Offset(-1, 0),
    ).animate(CurvedAnimation(
        parent: firstRightToLeftAnimController, curve: Curves.easeOut));

    secondRightToLeftAnim = Tween(
      begin: const Offset(-2, 0),
      end: const Offset(1, 0),
    ).animate(CurvedAnimation(
        parent: firstRightToLeftAnimController, curve: Curves.easeOut));

    rightBoxAnim = Tween(
      begin: const Offset(8, 0),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(parent: boxesController, curve: Curves.easeOut));

    leftBoxAnim = Tween(
      begin: const Offset(-2, 0),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(parent: boxesController, curve: Curves.easeOut));

    rightToLeftListviewAnim = Tween(
      begin: const Offset(2, 0),
      end: const Offset(0, 0),
    ).animate(rightToLeftListviewController);

    Future.delayed(const Duration(microseconds: 0)).then((value) async {
      setState(() {
        _height = 300;
      });
      await Future.delayed(
        const Duration(milliseconds: 700),
      );
      boxesController.forward();
    });

    boxesController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        rightToLeftListviewController.forward();
      }
    });
    rightToLeftListviewController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        firstRightToLeftAnimController.forward();
      }
    });

    firstRightToLeftAnimController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          showListView = true;
        });
      }
    });

    super.initState();
  }

  double _height = 0;
  @override
  Widget build(BuildContext context) {
    double? height = MediaQuery.of(context).size.height;
    double? width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xFF070713),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              AnimatedContainer(
                height: _height,
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
                            "25 800",
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
                                "+620",
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 18),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SlideTransition(
                position: leftBoxAnim,
                child: Container(
                  margin: const EdgeInsets.only(right: 5, left: 5, top: 12),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Container(
                                width: 10,
                              ),
                              RotatedBox(
                                quarterTurns: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 1.5),
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
                          position: rightBoxAnim,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _height = height / 2 - 120;
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
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                  Container(
                                    width: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 1.5),
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
              ),
              SlideTransition(
                position: rightToLeftListviewAnim,
                child: Container(
                  height: 80,
                  margin: const EdgeInsets.only(top: 20),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: companyList.length,
                    itemBuilder: (context, index) {
                      Company company = companyList[index];
                      return company.name != ""
                          ? ScaleTransition(
                              scale: _animation,
                              child: Center(
                                child: Container(
                                  width: 215,
                                  height: 80,
                                  margin: EdgeInsets.only(
                                      right: 15, left: index == 0 ? 30 : 0),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0a0720),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Listener(
                                    onPointerDown: (details) {
                                      setState(() {
                                        _controller.forward();

                                        selectedCompanyIndex = index;
                                        // listviewItemWidth = 160;
                                        // listviewItemHeight = 60;
                                      });
                                      print("called");
                                    },
                                    onPointerUp: (details) {
                                      _controller.reverse();

                                      setState(() {
                                        // selectedCompanyIndex = index;
                                        // listviewItemWidth = 215;
                                        // listviewItemHeight = 90;
                                      });
                                    },

                                    // onPanCancel: () => _timer?.cancel(),
                                    // onPanDown: (_) => {
                                    //   _timer = Timer(Duration(seconds: 1), () {
                                    //     setState(() {
                                    //       selectedCompanyIndex = index;
                                    //       listviewItemWidth = 120;
                                    //       listviewItemHeight = 40;
                                    //     });
                                    //     print("called");
                                    //     // Your function goes here
                                    //   })
                                    // },

                                    child: Row(
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(left: 12),
                                          width: 55,
                                          height: 55,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: const Color(0xFF1b193d),
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              company.companyLogo,
                                              width: 27,
                                              fit: BoxFit.fill,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 12, left: 12),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                company.name,
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Color(0xFF47417d),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 10),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      company.price.toString(),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white
                                                              .withOpacity(0.8),
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 8),
                                                      child: Text(
                                                        company.hasBenefit
                                                            ? "+${company.changePercent}%"
                                                            : "-${company.changePercent}%",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: company
                                                                    .hasBenefit
                                                                ? Colors.green
                                                                    .withOpacity(
                                                                        0.7)
                                                                : Colors.red
                                                                    .withOpacity(
                                                                        0.7),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
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
                            )
                          : Container();
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
                        controller: _firstScrollController,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: companyList
                            .where((e) => !e.hasBenefit)
                            .toList()
                            .length,
                        itemBuilder: (context, index) {
                          Company benefitedCompany = companyList
                              .where((e) => e.hasBenefit)
                              .toList()[index];

                          return benefitedCompany.name == ""
                              ? Container(
                                  height: 80,
                                  margin: const EdgeInsets.only(left: 5),
                                  width: 215,
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
                                  child: Row(
                                    children: [],
                                  ),
                                )
                              : Container(
                                  height: 80,
                                  margin: EdgeInsets.only(
                                      right: 18, left: index == 0 ? 40 : 0),
                                  width: 215,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0a0720),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: GestureDetector(
                                    onLongPress: () {
                                      setState(() {
                                        dialogMode = 1;
                                        selectedCompanyIndex = index;
                                        showDialogScreen = true;
                                        if (dialogWidth != 0) {
                                          dialogWidth = 0;
                                          dialogHeight = 0;
                                        } else {
                                          dialogWidth = 350;
                                          dialogHeight = 480;
                                        }
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(left: 12),
                                          width: 55,
                                          height: 55,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: const Color(0xFF1b193d),
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              benefitedCompany.companyLogo,
                                              width: 27,
                                              fit: BoxFit.fill,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 12, left: 12),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                benefitedCompany.name,
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Color(0xFF47417d)),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 10),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      benefitedCompany.price
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white
                                                              .withOpacity(0.8),
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 8),
                                                      child: Text(
                                                        benefitedCompany
                                                                .hasBenefit
                                                            ? "+${benefitedCompany.changePercent}%"
                                                            : "-${benefitedCompany.changePercent}%",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: benefitedCompany
                                                                    .hasBenefit
                                                                ? Colors.green
                                                                    .withOpacity(
                                                                        0.7)
                                                                : Colors.red
                                                                    .withOpacity(
                                                                        0.7),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
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
                                );
                        },
                      ),
                    )
                  : SlideTransition(
                      position: firstRightToLeftAnim,
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
                        controller: _secondScrollController,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            companyList.where((e) => !e.hasBenefit).length,
                        itemBuilder: (context, index) {
                          Company nonBenefitedCompany = companyList
                              .where((e) => !e.hasBenefit)
                              .toList()[index];

                          return nonBenefitedCompany.name == ""
                              ? Container(
                                  height: 80,
                                  width: 210,
                                  margin: const EdgeInsets.only(right: 5),
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
                                  child: Row(children: []),
                                )
                              : GestureDetector(
                                  onLongPress: () {
                                    setState(() {
                                      dialogMode = 2;
                                      selectedCompanyIndex = index;
                                      showDialogScreen = true;
                                      if (dialogWidth != 0) {
                                        dialogWidth = 0;
                                        dialogHeight = 0;
                                      } else {
                                        dialogWidth = 350;
                                        dialogHeight = 480;
                                      }
                                    });
                                    print("longPress");
                                  },
                                  child: Container(
                                    height: 80,
                                    margin: const EdgeInsets.only(
                                        right: 18, left: 2),
                                    width: 215,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF0a0720),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(left: 12),
                                          width: 55,
                                          height: 55,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: const Color(0xFF1b193d),
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              nonBenefitedCompany.companyLogo,
                                              width: 27,
                                              fit: BoxFit.fill,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 12, left: 12),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                nonBenefitedCompany.name,
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Color(0xFF47417d)),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 10),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      nonBenefitedCompany.price
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white
                                                              .withOpacity(0.8),
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 8),
                                                      child: Text(
                                                        nonBenefitedCompany
                                                                .hasBenefit
                                                            ? "+${nonBenefitedCompany.changePercent}%"
                                                            : "-${nonBenefitedCompany.changePercent}%",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: nonBenefitedCompany
                                                                    .hasBenefit
                                                                ? Colors.green
                                                                    .withOpacity(
                                                                        0.7)
                                                                : Colors.red
                                                                    .withOpacity(
                                                                        0.7),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
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
                                );
                        },
                      ),
                    )
                  : SlideTransition(
                      position: secondRightToLeftAnim,
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
          ),
          dismissableDilog(width)
        ],
      ),
    ));
  }

  Dismissible dismissableDilog(double width) {
    Company selectedUnBenefitedCompany = dialogMode == 0
        ? companyList[selectedCompanyIndex]
        : companyList
            .where((e) => dialogMode == 1 ? e.hasBenefit : !e.hasBenefit)
            .toList()[selectedCompanyIndex];
    return Dismissible(
      direction: DismissDirection.vertical,
      onDismissed: (direction) {
        setState(() {
          showDialogScreen = false;
          dialogWidth = 0;
          dialogHeight = 0;
        });
      },
      key: UniqueKey(),
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
        duration: const Duration(milliseconds: 1500),
        width: dialogWidth,
        height: dialogHeight,
        alignment: Alignment.center,
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
              margin: const EdgeInsets.only(bottom: 5),
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
            showDialogScreen
                ? BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: const SizedBox(
                      width: 0,
                      height: 0,
                    ),
                  )
                : Container(),
            Container(
              child: Column(
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
                          selectedUnBenefitedCompany.name,
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
                      style: const TextStyle(fontSize: 28, color: Colors.white),
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
                    margin: const EdgeInsets.only(top: 35),
                    child: SfSparkLineChart(
                      axisLineColor: Colors.transparent,
                      data: const <double>[
                        1,
                        5,
                        -6,
                        0,
                        1,
                        -2,
                        7,
                        -7,
                        -4,
                        -10,
                      ],
                      trackball: const SparkChartTrackball(
                          color: Colors.white,
                          activationMode: SparkChartActivationMode.tap),

                      // labelDisplayMode: SparkChartLabelDisplayMode.all,
                      // labelStyle: TextStyle(color: Colors.white),
                      // marker: SparkChartMarker(
                      //     displayMode: SparkChartMarkerDisplayMode.all),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 16),
                    child: Row(
                      // mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          "12:30",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        SizedBox(
                          width: 55,
                        ),
                        Text(
                          "13:30",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        SizedBox(
                          width: 55,
                        ),
                        Text(
                          "14:30",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        SizedBox(
                          width: 55,
                        ),
                        Text(
                          "15:30",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    height: 30,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          decoration: BoxDecoration(
                            color: selectedItem == index
                                ? Colors.white
                                : const Color(0xFF080720),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          margin: const EdgeInsets.only(right: 5, left: 20),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedItem = index;
                              });
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Center(
                                child: Text(
                                  "1M",
                                  style: TextStyle(
                                    color: selectedItem == index
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
