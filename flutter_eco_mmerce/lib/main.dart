import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_eco_mmerce/UI/pages/HomePage.dart';
import 'package:flutter_eco_mmerce/UI/pages/Login.dart';
import 'package:flutter_eco_mmerce/UI/pages/ShoppingCart.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/home',
  routes: {
    '/home': (context) => Login()
  },
));
