import 'package:flutter/cupertino.dart';

class ModelReportConsultasMensajerias with ChangeNotifier{

  double _currentPage = 0;
  double get currentPage => this._currentPage;
  set currentPage(double current){
    this._currentPage = current;
    notifyListeners();
  }


  PageController _pageViewController = new PageController();
  PageController get pageViewController => this._pageViewController;
  set pageViewController(PageController controller){
    _pageViewController = controller;
    // notifyListeners();
  }

  int _bodyPage = 0;
  int get bodyPage => this._bodyPage;
  set bodyPage(int current){
    this._bodyPage = current;
    notifyListeners();
  }

}