import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_money/data/company.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../data/base_view_model.dart';

class MainViewModel extends BaseViewModel {
  late Timer timer;
  late ScrollController benefitedStoksScrollController;
  late ScrollController unBenefitedStoksScrollController;
  late AnimationController dialogScaleController;
  bool shouldBeVisible = false;
  late AnimationController listViewItemController;
  late Animation<double> listViewItemScaleAnimation;
  late Animation<double> listViewItemDefualtAnimation;
  late Animation<Offset> dialogAnimation;
  late AnimationController dialogController;
  late Animation<Offset> benefitedStoorksListAnimation;
  late AnimationController benefitedStoorksListController;
  late Animation<Offset> unBenefitedStoorksListAnimation;
  late Animation<Offset> rightBoxAnimation;
  late Animation<Offset> leftBoxAnimation;
  late AnimationController boxesController;
  late Animation<Offset> allStoksListviewAnimation;
  late AnimationController allStoksListviewController;
  int dialogMode = 0;
  int showDialogScreenMode = -1;
  var selectedCompanyIndex = 0;
  bool showAllStoksListView = false;
  int selectedItem = 0;
  double dialogWidth = 350;
  double dialogHeight = 420;
  Color color = Colors.white;
  bool showDialogMonths = false;
  Offset currentItemPostion = const Offset(0, 0);
  late double height = 0;
  List<String> dialogTimeList = ["1D", "1W", "1M", "6M", "1Y"];
  int selectedListView = -1;
  bool blurOutsideDialog = false;
  int selectedListViewLogooItemColor = -1;
  List<Color> benefitedFirstItemColorList = [
    const Color(0xFF3fdcd6),
    const Color(0xFF48eace),
    const Color(0xFF90e6cf)
  ];
  List<Color> unBenefitLastItemColorList = [
    const Color(0xFF5810df),
    const Color(0xFF4f0cdc),
    const Color(0xFF0e07ca)
  ];
  late TrackballBehavior trackballBehavior;

  void setListViewItemClicked(
      bool pointerDown, int index, int listViewIndex, Offset localPosition) {
    // When ListView Item Holded:
    if (pointerDown) {
      showDialogScreenMode = -1;

      dialogAnimation = Tween(
        begin: const Offset(0, 1),
        end: const Offset(0, 0),
      ).animate(CurvedAnimation(
          parent: dialogController, curve: Curves.fastOutSlowIn));
      // Resize the button height so when u hold button it looks smaller
      listViewItemController.forward();

      selectedCompanyIndex = index;
      selectedListView = listViewIndex;
      selectedListViewLogooItemColor = listViewIndex;
      notifyListeners();
      timer = Timer(
        const Duration(milliseconds: 1000),
        () async {
          // Change view from SlideTranstion and ScaleTrantion to Dismissble widget
          showDialogScreenMode = 1;
          notifyListeners();
          dialogScaleController
            ..reset()
            ..forward();
          dialogController
            ..reset()
            ..forward();
          blurOutsideDialog = true;
          await Future.delayed(
            const Duration(milliseconds: 200),
          );
          showDialogScreenMode = 0;
        },
      );
    } else {
      // If Item has NOT been hoolded for a second, then reset all values cuz at least it should be hoolded for a second to function
      selectedListViewLogooItemColor = -1;
      timer.cancel();
      // Change the size of small button to it original by reversibng controller
      listViewItemController.reverse();
    }
    notifyListeners();
  }

  // When u hold Dialog for more than a second
  void dialogOnLongPress() {
    //Increease height of dialog
    dialogHeight = 470;
    // Show stock's timeList at bottom of dialog
    showDialogMonths = true;
    notifyListeners();
  }

  void setDialogSelectedTime(int index) {
    selectedItem = index;
    notifyListeners();
  }

  void dialogOnDismissedFun() {
    // Reset all values when swip up/down dialog
    showDialogScreenMode = -1;
    blurOutsideDialog = false;
    selectedItem = 0;
    dialogHeight = 420;
    showDialogMonths = false;
    notifyListeners();
  }

  void setInitStateAnim(TickerProvider provider) {
    benefitedStoksScrollController =
        ScrollController(initialScrollOffset: 123.0);
    unBenefitedStoksScrollController =
        ScrollController(initialScrollOffset: 180.0);
    trackballBehavior = TrackballBehavior(
        enable: true,
        tooltipSettings: const InteractiveTooltip(
          enable: true,
          textStyle: TextStyle(fontSize: 15),
          color: Color(0xFF968cb7),
        ));
    dialogController = AnimationController(
      duration: const Duration(milliseconds: 1100),
      vsync: provider,
    );
    listViewItemController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: provider,
    );

    dialogScaleController = AnimationController(
      duration: const Duration(milliseconds: 1100),
      vsync: provider,
    );

    listViewItemScaleAnimation =
        Tween(begin: 1.0, end: 0.8).animate(listViewItemController);
    listViewItemDefualtAnimation =
        Tween(begin: 1.0, end: 1.0).animate(listViewItemController);
    benefitedStoorksListController = AnimationController(
      vsync: provider,
      duration: const Duration(milliseconds: 800),
    );

    boxesController = AnimationController(
      vsync: provider,
      duration: const Duration(milliseconds: 800),
    );
    allStoksListviewController = AnimationController(
      vsync: provider,
      duration: const Duration(milliseconds: 700),
    );
    benefitedStoorksListAnimation = Tween(
      begin: const Offset(2, 0),
      end: const Offset(-1, 0),
    ).animate(CurvedAnimation(
        parent: benefitedStoorksListController, curve: Curves.easeOut));

    unBenefitedStoorksListAnimation = Tween(
      begin: const Offset(-2, 0),
      end: const Offset(1, 0),
    ).animate(CurvedAnimation(
        parent: benefitedStoorksListController, curve: Curves.easeOut));

    rightBoxAnimation = Tween(
      begin: const Offset(8, 0),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(parent: boxesController, curve: Curves.easeOut));

    leftBoxAnimation = Tween(
      begin: const Offset(-2, 0),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(parent: boxesController, curve: Curves.easeOut));

    allStoksListviewAnimation = Tween(
      begin: const Offset(2, 0),
      end: const Offset(0, 0),
    ).animate(allStoksListviewController);

    dialogAnimation = Tween(
      begin: const Offset(1.0, 1.0),
      end: currentItemPostion,
    ).animate(dialogController);
    Future.delayed(const Duration(milliseconds: 100)).then((value) async {
      height = 300;
      notifyListeners();
    });

    boxesController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        allStoksListviewController.forward();
      }
    });
    allStoksListviewController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        benefitedStoorksListController.forward();
      }
    });

    benefitedStoorksListController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        showAllStoksListView = true;
      }
      notifyListeners();
    });

    notifyListeners();
  }

  List<ChartDataItem> addChartDataValueToChartList() {
    List<ChartDataItem> chartList = [];
    for (var element in selectedListView == 0
        ? companyList[selectedCompanyIndex].chardData[selectedItem].data
        : companyList
            .where((element) => selectedListView == 1
                ? element.hasBenefit
                : !element.hasBenefit)
            .toList()[selectedCompanyIndex]
            .chardData[selectedItem]
            .data) {
      chartList.add(ChartDataItem(x: element.x, y: element.y));
    }
    return chartList;
  }
}

final mainViewModelProvider = ChangeNotifierProvider.autoDispose<MainViewModel>(
  (ref) => MainViewModel(),
);
