import 'package:flutter/material.dart';
import 'package:flutter_eco_mmerce/UI/pages/SignUp.dart';
import 'package:flutter_eco_mmerce/UI/widgets/InputField.dart';
import 'package:flutter_eco_mmerce/UI/widgets/SquareButton.dart';
import 'package:flutter_eco_mmerce/UI/pages/HomePage.dart';
import 'package:flutter_eco_mmerce/model/support/Global.dart';

import '../../model/Model.dart';
import '../../model/objects/User.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool _login = false;
  User _user;

  TextEditingController _emailFieldController = TextEditingController();
  TextEditingController _passwordFieldController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF5F5F5),
        body: Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height * 1,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("img/logo-olfattivo-mostre-.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 100, 20, 0),
                      child: Image.asset(
                        'img/logo4.png',
                        width: 150,
                        height: 150,
                        fit: BoxFit.contain,
                      )
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(child:
                      InputField(
                        labelText: 'E-mail',
                        controller: _emailFieldController,
                        textAlign: TextAlign.start,
                      ),
                      ),
                    ],),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(child:
                      InputField(
                        labelText: 'Password',
                        isPassword: true,
                        controller: _passwordFieldController,
                        textAlign: TextAlign.start,
                      ),
                      ),
                    ],),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SquareButton(
                            onPressed: () async {
                              if(_emailFieldController.text != "" && _passwordFieldController.text != ""){
                                _trylogin();
                              }
                            },
                            text: 'Accedi',
                          )
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SquareButton(
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUp(),
                                ),
                              );
                            },
                            text: 'Registrati',
                          )
                        ],
                      )

                    ],
                  ),
                ],
              ),

            )
        )
    );
  }

  void _trylogin() {
    setState(() {
      _login = true;
      _user = null;
    });
    Model.sharedInstance.login(_emailFieldController.text, _passwordFieldController.text).then((result) async {
      setState(() {
        _login = false;
        _user = result;
      });

      if(_user != null) {
        loggedIn = _user;
        var snackBar = SnackBar(
          duration: Duration(milliseconds: 800),
          content: Text('Bentornato ${loggedIn}'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(_user, []),
            //builder: (context) => Search(),
          ),
        );
      }

      else{
        var snackBar = SnackBar(
          duration: Duration(milliseconds: 800),
          backgroundColor: Colors.red,
          content: Text('Email o password non corretti'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

    });
  }
}
