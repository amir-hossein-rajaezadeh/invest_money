import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/base_view_model.dart';

class MainViewModel extends BaseViewModel {
  late Timer timer;
  late ScrollController firstScrollController;
  late ScrollController secondScrollController;
  late AnimationController controller;
  late AnimationController dialogController;
  late AnimationController dialogScaleController;

  late Animation<double> animation;
  late Animation<double> defaultAnimation;

  late Animation<Offset> firstRightToLeftAnim;
  late Animation<Offset> dialogAnim;

  late AnimationController firstRightToLeftAnimController;
  late Animation<Offset> secondRightToLeftAnim;
  late Animation<Offset> rightBoxAnim;
  late Animation<Offset> leftBoxAnim;
  late Animation<Offset> rightToLeftListviewAnim;
  late AnimationController rightToLeftListviewController;
  late AnimationController boxesController;
  List<Color> firstAndLastColoredItem = [];
  int dialogMode = 0;
  int showDialogScreenMode = -1;
  var selectedCompanyIndex = 0;
  bool showListView = false;
  int selectedItem = 0;
  double dialogWidth = 350;
  double dialogHeight = 420;
  double listviewItemWidth = 215;
  double listviewItemHeight = 80;
  late Color color = Colors.white;
  int selectedCompanyMode = 0;
  bool showDialogMonth = false;
  Offset currentItemPostion = const Offset(0, 0);
  late double height = 0;
  List<String> timeList = ["1D", "1W", "1M", "6M", "1Y"];
  int selectedListView = -1;
  void setFirstAndLastItemColor(int listViewIndex) {
    firstAndLastColoredItem = [
      listViewIndex == 1 ? const Color(0xFF3fdcd6) : const Color(0xFF5810df),
      listViewIndex == 1 ? const Color(0xFF48eace) : const Color(0xFF4f0cdc),
      listViewIndex == 1 ? const Color(0xFF90e6cf) : const Color(0xFF0e07ca)
    ];
    notifyListeners();
  }

  void setListViewItemClicked(
      bool pointerDown, int index, int listViewIndex, Offset localPosition) {
    if (pointerDown) {
      showDialogScreenMode = -1;

      selectedListView = listViewIndex;
      dialogAnim = Tween(
        begin: const Offset(0, 1),
        end: const Offset(0, 0),
      ).animate(CurvedAnimation(
          parent: dialogController, curve: Curves.fastOutSlowIn));
      selectedCompanyIndex = index;
      controller.forward();
      timer = Timer(
        const Duration(milliseconds: 1000),
        () async {
          showDialogScreenMode = 1;
          notifyListeners();
          dialogScaleController
            ..reset()
            ..forward();
          dialogController
            ..reset()
            ..forward();
          await Future.delayed(
            const Duration(milliseconds: 1500),
          );
          showDialogScreenMode = 0;
        },
      );
    } else {
      timer.cancel();
      controller.reverse();
    }

    notifyListeners();
  }

  void setInitStateAnim(TickerProvider provider) {
    firstScrollController = ScrollController(initialScrollOffset: 140.0);
    secondScrollController = ScrollController(initialScrollOffset: 140.0);
    dialogController = AnimationController(
      duration: const Duration(milliseconds: 1100),
      vsync: provider,
    );
    controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: provider,
    );

    dialogScaleController = AnimationController(
      duration: const Duration(milliseconds: 1100),
      vsync: provider,
    );

    animation = Tween(begin: 1.0, end: 0.8).animate(controller);
    defaultAnimation = Tween(begin: 1.0, end: 1.0).animate(controller);
    firstRightToLeftAnimController = AnimationController(
      vsync: provider,
      duration: const Duration(milliseconds: 1000),
    );

    boxesController = AnimationController(
      vsync: provider,
      duration: const Duration(milliseconds: 1300),
    );
    rightToLeftListviewController = AnimationController(
      vsync: provider,
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

    dialogAnim = Tween(
      begin: const Offset(1.0, 1.0),
      end: currentItemPostion,
    ).animate(dialogController);

    Future.delayed(const Duration(milliseconds: 100)).then((value) async {
      height = 300;
      await Future.delayed(
        const Duration(milliseconds: 700),
      );
      boxesController.forward();
      notifyListeners();
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
        showListView = true;
      }
      notifyListeners();
    });

    notifyListeners();
  }
}

final mainViewModelProvider = ChangeNotifierProvider.autoDispose<MainViewModel>(
  (ref) => MainViewModel(),
);
