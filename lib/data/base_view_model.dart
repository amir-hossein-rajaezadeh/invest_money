import 'package:flutter/cupertino.dart';

class BaseViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool _loadingMore = false;

  bool getLoading() {
    return _isLoading;
  }

  void setIsLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void cancelIsLoading() {
    _isLoading = false;
    notifyListeners();
  }

  bool getLoadMore() {
    return _loadingMore;
  }

  void setLoadMore() {
    _loadingMore = true;
    notifyListeners();
  }

  void cancelLoadMore() {
    _loadingMore = false;
    notifyListeners();
  }
}
