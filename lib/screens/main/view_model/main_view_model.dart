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
  int dialogMode = 0;
  bool showDialogScreen = false;
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

  // bool isFirstTry = true;
  // double sliderValue = 0.0;
  // double volumeSliderValue = 1;

//   void setSliderValue(double value) {
//     sliderValue = value;
//     notifyListeners();
//   }

//   Future<void> setVolumeSliderValue(double value) async {
//     await audioPlayer.setVolume(value);
//     volumeSliderValue = value;
//     notifyListeners();
//   }
}

final mainViewModelProvider = ChangeNotifierProvider.autoDispose<MainViewModel>(
  (ref) => MainViewModel(),
);
