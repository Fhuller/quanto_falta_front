import 'package:flutter/material.dart';

class DefaultChangeNotifier extends ChangeNotifier {
  bool _loading = false;
  String? _error;
  bool _succcess = false;

  bool get loading => _loading;
  String? get error => _error;
  bool get hasError => _error != null;
  bool get isSuccess => _succcess;

  void showLoading() => _loading = true;
  void hideLoading() => _loading = false;
  void success() => _succcess = true;
  void setError(String? error) => _error = error;

  void showLoadingAndResetState() {
    showLoading();
    resetState();
  }

  void resetState() {
    setError(null);
    _succcess = false;
  }
}
