import 'package:flutter/material.dart';
import 'package:flutter_eco_mmerce/UI/pages/Login.dart';
import 'package:flutter_eco_mmerce/UI/widgets/InputField.dart';
import 'package:flutter_eco_mmerce/UI/widgets/SquareButton.dart';
import 'package:flutter_eco_mmerce/model/Model.dart';

import 'package:flutter_eco_mmerce/model/objects/User.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);


  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _adding = false;
  User _justAddedUser;

  TextEditingController _firstNameFieldController = TextEditingController();
  TextEditingController _lastNameFieldController = TextEditingController();
  TextEditingController _telephoneNumberFieldController = TextEditingController();
  TextEditingController _emailFieldController = TextEditingController();
  TextEditingController _addressFieldController = TextEditingController();
  TextEditingController _passwordFieldController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("img/Background2.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
          children: [
            Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                child: Image.asset(
                  'img/logo4.png',
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                )
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Column(
                children: [
                  InputField(
                    textAlign: TextAlign.start,
                    labelText: 'Nome',
                    controller: _firstNameFieldController,
                  ),
                  InputField(
                    textAlign: TextAlign.start,
                    labelText: 'Cognome',
                    controller: _lastNameFieldController,
                  ),
                  InputField(
                    textAlign: TextAlign.start,
                    labelText: 'Telefono',
                    controller: _telephoneNumberFieldController,
                  ),
                  InputField(
                    textAlign: TextAlign.start,
                    labelText: 'Email',
                    controller: _emailFieldController,
                  ),
                  InputField(
                    textAlign: TextAlign.start,
                    labelText: 'Password',
                    isPassword: true,
                    controller: _passwordFieldController,
                  ),
                  InputField(
                    textAlign: TextAlign.start,
                    labelText: 'Indirizzo',
                    controller: _addressFieldController,
                  ),
                  Row(children:[
                  SquareButton(
                    text: 'Registrati',
                    onPressed: () {
                      if(_firstNameFieldController.text != "" && _lastNameFieldController.text != "" && _addressFieldController.text != "" && _emailFieldController.text != "" && _passwordFieldController.text != "" ) {
                        _register();
                      }
                      else{
                        var snackBar = SnackBar(
                          duration: Duration(milliseconds: 1000),
                          backgroundColor: Colors.red,
                          content: Text('Impossibile aggiugnere utente, ricontrolla i campi di testo'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                  ),
                    SquareButton(
                      text: 'Accedi',
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ),
                        );
                      },
                    ),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }

  void _register() {
    setState(() {
      _adding = true;
      _justAddedUser = null;
    });
    User user = User(
      nome: _firstNameFieldController.text,
      cognome: _lastNameFieldController.text,
      telefono: _telephoneNumberFieldController.text,
      mail: _emailFieldController.text,
      indirizzo: _addressFieldController.text,
      password: _passwordFieldController.text,
    );
    Model.sharedInstance.addUser(user).then((result) async{

        setState(() {
          _adding = false;
          _justAddedUser = result;
        });

        if(_justAddedUser != null) {
        var snackBar = SnackBar(
          duration: Duration(milliseconds: 800),
          content: Text('Benvenuto ${_justAddedUser}'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ),
        );
      }
        else{
          var snackBar = SnackBar(
            duration: Duration(milliseconds: 800),
            backgroundColor: Colors.red,
            content: Text('Utente già registrato'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

      });
  }

}