import 'dart:async';
import 'dart:convert';
import 'package:flutter_eco_mmerce/model/managers/RestManager.dart';
import 'package:flutter_eco_mmerce/model/objects/Product.dart';
import 'package:flutter_eco_mmerce/model/objects/User.dart';
import 'package:flutter_eco_mmerce/model/objects/Purchase.dart';
import 'package:flutter_eco_mmerce/model/support/Constants.dart';


class Model {
  static Model sharedInstance = Model();

  RestManager _restManager = RestManager();

  Future<List<Product>> showProducts() async {
    try {
      return List<Product>.from(json.decode(await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_SHOW_ALL_PRODUCTS)).map((i) => Product.fromJson(i)).toList());
    }
    catch (e) {
      return null; // not the best solution
    }
  }


  Future<List<Product>> searchProduct(String nome) async {
    Map<String, String> params = Map();
    params["nome"] = nome;
    try {
      return List<Product>.from(json.decode(await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_SEARCH_PRODUCTS, params)).map((i) => Product.fromJson(i)).toList());
    }
    catch (e) {
      return null; // not the best solution
    }
  }

  Future<User> addUser(User user) async {
    try {
      String rawResult = await _restManager.makePostRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_ADD_USER, user);
      if ( rawResult.contains(Constants.RESPONSE_ERROR_MAIL_USER_ALREADY_EXISTS)) {
        return null; // not the best solution
      }
      else {
        return User.fromJson(jsonDecode(rawResult));
      }
    }
    catch (e) {
      return null; // not the best solution
    }
  }

  Future<User> login(String mail, String password) async {
    Map<String, String> params = Map();
    params["mail"] = mail;
    params["password"] = password;
    try {
      String rawResult = await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_LOGIN_USER, params);
      if ( rawResult.contains(Constants.RESPONSE_ERROR_USER_DOES_NOT_EXIST)) {
        return null; // not the best solution
      }
      else {
        return User.fromJson(jsonDecode(rawResult));
      }
    }
    catch (e) {
      return null; // not the best solution
    }
  }

  Future<Purchase> addPurchase(Purchase purchase) async {
    try {
      String rawResult = await _restManager.makePostRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_ADD_PURCHASE, purchase);
      if ( rawResult.contains(Constants.RESPONDE_ERROR_QUANTITY_NOT_AVAILABLE)) {
        return null; // not the best solution

      }
      else {
        return Purchase.fromJson(jsonDecode(rawResult));
      }
    }
    catch (e) {
      return null; // not the best solution
    }
  }


}
