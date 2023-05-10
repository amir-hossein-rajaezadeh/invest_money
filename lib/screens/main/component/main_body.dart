import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_money/screens/main/view_model/main_view_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../../../data/company.dart';

class MainBody extends ConsumerStatefulWidget {
  const MainBody({super.key});

  @override
  ConsumerState<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends ConsumerState<MainBody>
    with TickerProviderStateMixin {
  @override
  void dispose() {
    final mainViewModel = ref.watch(mainViewModelProvider);

    mainViewModel.firstScrollController.dispose();
    mainViewModel.secondScrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final mainViewModel = ref.watch(mainViewModelProvider);
      mainViewModel.setInitStateAnim(this);
      await Future.delayed(const Duration(milliseconds: 700));
      mainViewModel.boxesController.forward();
      print("test data ");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double? height = MediaQuery.of(context).size.height;
    double? width = MediaQuery.of(context).size.width;
    final mainViewModel = ref.watch(mainViewModelProvider);
    return SingleChildScrollView(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              firstWidget(mainViewModel.height, mainViewModel),
              secondWidget(width, height, mainViewModel),
              listViews(mainViewModel.showListView, mainViewModel),
            ],
          ),
          dismissableDilog(width, mainViewModel),
        ],
      ),
    );
  }

  Widget firstWidget(double height, MainViewModel mainViewModel) {
    return AnimatedContainer(
        height: height,
        duration: const Duration(milliseconds: 800),
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
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const SizedBox(
                height: 80,
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(left: 20),
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
        ));
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
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.topLeft,
                        colors: mainViewModel.benefitColorList),
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
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: mainViewModel.unBenefitColorList),
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
            scale: mainViewModel.selectedCompanyIndex == index &&
                    listViewIndex == mainViewModel.selectedListView
                ? mainViewModel.listViewItemScaleAnimation
                : mainViewModel.listViewItemDefualtAnimation,
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
                    mainViewModel.setListViewItemClicked(
                        true, index, listViewIndex, details.localPosition);
                  },
                  onPointerUp: (details) {
                    mainViewModel.setListViewItemClicked(
                        false, index, listViewIndex, details.localPosition);
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
                              color: mainViewModel.selectedCompanyIndex ==
                                          index &&
                                      listViewIndex ==
                                          mainViewModel
                                              .selectedListViewLogooItemColor
                                  ? mainViewModel.color
                                  : Colors.white.withOpacity(0.5),
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
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: listViewIndex == 1
                          ? mainViewModel.benefitColorList
                          : mainViewModel.unBenefitColorList),
                ),
                child: Row(
                  children: const [],
                ),
              );
  }

  Widget dismissableDilog(double width, MainViewModel mainViewModel) {
    Company company = mainViewModel.selectedListView == 0
        ? companyList[mainViewModel.selectedCompanyIndex]
        : companyList
            .where((e) => mainViewModel.selectedListView == 1
                ? e.hasBenefit
                : !e.hasBenefit)
            .toList()[mainViewModel.selectedCompanyIndex];
    return mainViewModel.showDialogScreenMode == 0
        ? Dismissible(
            direction: DismissDirection.vertical,
            onDismissed: (direction) => mainViewModel.dialogOnDismissedFun(),
            key: UniqueKey(),
            child: dialogUI(mainViewModel, width, company),
          )
        : mainViewModel.showDialogScreenMode == 1
            ? SlideTransition(
                position: mainViewModel.dialogAnim,
                child: ScaleTransition(
                  scale: mainViewModel.dialogScaleController,
                  child: dialogUI(mainViewModel, width, company),
                ),
              )
            : Container();
  }

  Widget dialogUI(MainViewModel mainViewModel, double width, Company company) {
    return GestureDetector(
      onLongPress: () => mainViewModel.dialogOnLongPress(),
      child: Container(
        color: Colors.transparent,
        child: AnimatedContainer(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(35),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black, Color.fromARGB(255, 0, 6, 166)],
              stops: [0.8, 1],
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
                mainViewModel.blurOutsideDialog
                    ? BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: const SizedBox(
                          width: 350,
                          height: 500,
                        ),
                      )
                    : Container(),
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: SizedBox(
                      width: width,
                      height: 150,
                    ),
                  ),
                ),
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
                            company.name,
                            style: const TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: Text(
                        company.price.toString(),
                        style:
                            const TextStyle(fontSize: 28, color: Colors.white),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: Text(
                        company.hasBenefit
                            ? "+${company.changePercent}%"
                            : "-${company.changePercent}%",
                        style: TextStyle(
                          fontSize: 20,
                          color: company.hasBenefit
                              ? Colors.green.withOpacity(0.7)
                              : Colors.red.withOpacity(0.7),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      height: 180,
                      margin: const EdgeInsets.only(
                          top: 30, bottom: 10, left: 20, right: 20),
                      child:
                          // LineChart(LineChartData(
                          //   lineTouchData: LineTouchData(
                          //     handleBuiltInTouches: true,
                          //     touchTooltipData: LineTouchTooltipData(
                          //       tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                          //     ),
                          //   ),
                          //   gridData: FlGridData(show: false),
                          //   titlesData: FlTitlesData(
                          //     topTitles: AxisTitles(
                          //       sideTitles: SideTitles(showTitles: false),
                          //     ),
                          //     bottomTitles: AxisTitles(
                          //       sideTitles: SideTitles(showTitles: false),
                          //     ),
                          //     rightTitles: AxisTitles(
                          //       sideTitles: SideTitles(showTitles: false),
                          //     ),
                          //     leftTitles: AxisTitles(
                          //       sideTitles: SideTitles(showTitles: false),
                          //     ),
                          //   ),
                          //   borderData: FlBorderData(show: false),
                          //   lineBarsData: <LineChartBarData>[
                          //     LineChartBarData(
                          //         isCurved: true,
                          //         color: const Color(0xFF968cb7),
                          //         barWidth: 4,
                          //         isStrokeCapRound: true,
                          //         dotData: FlDotData(show: false),
                          //         belowBarData: BarAreaData(show: false),
                          //         spots:
                          //             mainViewModel.addChartDataValueToFlSpot())
                          //   ],
                          // ))

                          // SfCartesianChart(
                          //     plotAreaBorderWidth: 0,
                          //     // enableAxisAnimation: true,
                          //     primaryXAxis: CategoryAxis(),
                          //     primaryYAxis: NumericAxis(
                          //         isVisible: false,
                          //         axisLine: const AxisLine(width: 0),
                          //         minimum: 0,
                          //         maximum: 20),
                          //     series: <LineSeries<ChartDataItem, num>>[
                          //   LineSeries<ChartDataItem, num>(
                          //       dataSource:
                          //           mainViewModel.addChartDataValueToFlSpot(),
                          //       xValueMapper: (ChartDataItem sales, _) =>
                          //           sales.x,
                          //       yValueMapper: (ChartDataItem sales, _) =>
                          //           sales.y,
                          //       animationDuration: 1500,
                          //       width: 3,
                          //       color: const Color(0xFF968cb7),
                          //       // animationDelay: 200,
                          //       markerSettings:
                          //           const MarkerSettings(isVisible: false))
                          // ])

                          SfCartesianChart(
                              plotAreaBorderWidth: 0,
                              // enableAxisAnimation: true,
                              primaryXAxis: NumericAxis(isVisible: false),
                              primaryYAxis: NumericAxis(
                                  isVisible: false,
                                  axisLine: const AxisLine(width: 0),
                                  minimum: 0,
                                  maximum: 22),
                              series: <SplineSeries<ChartDataItem, num>>[
                            SplineSeries<ChartDataItem, num>(
                              splineType: SplineType.natural,
                              dataSource:
                                  mainViewModel.addChartDataValueToFlSpot(),
                              xValueMapper: (ChartDataItem sales, _) => sales.x,
                              yValueMapper: (ChartDataItem sales, _) => sales.y,
                              animationDuration: 1500,
                              width: 3,
                              color: const Color(0xFF968cb7),
                              // animationDelay: 200,
                            )
                          ]),
                    ),

                    // SfSparkLineChart(
                    //   axisLineColor: Colors.transparent,
                    //   data:
                    //       company.chardData[mainViewModel.selectedItem].data,
                    //   trackball: const SparkChartTrackball(
                    //       color: Colors.white,
                    //       activationMode: SparkChartActivationMode.tap),
                    // ),
                    // ),
                    Container(
                      margin: const EdgeInsets.only(left: 16, top: 15),
                      child: Row(
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
                    mainViewModel.showDialogMonth
                        ? Container(
                            margin: const EdgeInsets.only(top: 20),
                            height: 30,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: mainViewModel.timeList.length,
                              itemBuilder: (context, index) {
                                String title = mainViewModel.timeList[index];
                                return AnimatedContainer(
                                  duration: const Duration(seconds: 1),
                                  decoration: BoxDecoration(
                                    color: mainViewModel.selectedItem == index
                                        ? Colors.white
                                        : const Color(0xFF080720),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  margin:
                                      const EdgeInsets.only(right: 5, left: 20),
                                  child: InkWell(
                                    onTap: () => mainViewModel
                                        .setDialogSelectedTime(index),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Center(
                                        child: Text(
                                          title,
                                          style: TextStyle(
                                            color: mainViewModel.selectedItem ==
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
    );
  }
}
