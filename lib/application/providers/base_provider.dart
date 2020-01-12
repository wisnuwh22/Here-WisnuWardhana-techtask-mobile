import 'package:flutter/material.dart';

class BaseProvider extends ChangeNotifier{
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setBusy(){
    _isLoading = true;
  }

  void setIdle(){
    _isLoading = false;
  }

  @override
  void dispose() {
    super.dispose();
  }
}