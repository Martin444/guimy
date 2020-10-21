import 'package:flutter/material.dart';
import 'package:guimyapp/src/Pages/AuthUser/LoginUser.dart';
import 'package:guimyapp/src/Provider/ModelProvider.dart';
import 'package:guimyapp/src/Templates/HomePage.dart';
import 'package:provider/provider.dart';

enum AuthStatus{
  notLoggedIn,
  loggedIn,
}

class OurRoot extends StatefulWidget {
  @override
  _OurRootState createState() => _OurRootState();
}

class _OurRootState extends State<OurRoot> {
  AuthStatus _authStatus = AuthStatus.notLoggedIn;

  @override
  void didChangeDependencies() async {

    super.didChangeDependencies();
    
    //get the state, check current User , set AuthStatus based on state
    ModelProvider _currentUser = Provider.of<ModelProvider>(context, listen: false);
    String _returnString = await _currentUser.onStartUp();
    if( _returnString == "success"){
     setState(() {
      _authStatus = AuthStatus.loggedIn;
     });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget retVal;

    switch (_authStatus) {
      case AuthStatus.notLoggedIn:
        retVal = LoginUser();
        break;
      case AuthStatus.loggedIn:
        retVal = HomePage();
        break;
      default:
    }
    return retVal;
  }
}