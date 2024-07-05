import 'package:appstore/pages/shared/models/products_response.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Model extends ChangeNotifier {
  late SharedPreferences prefs;

  final List<Product> _prodects = [];
  double _totleprice = 0;
  addToListMyBasket(Product newproduct) {
    _totleprice += newproduct.price;
    _prodects.add(newproduct);
    notifyListeners();
  }


  removeProduct(Product newproduct) {
    _prodects.remove(newproduct);
    _totleprice -= newproduct.price;
    notifyListeners();
  }

  removeAllProduct() {
    // ignore: collection_methods_unrelated_type
    _prodects.clear();
    notifyListeners();
  }

  List<Product> getAllProdectMyBasket() {
    return _prodects;
  }

  totlePrice() {
    return _totleprice;
  }

  countProducts() {
    return _prodects.length;
  }

  islogin(bool islogin) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setBool('islogin', islogin);
  }

  getchecklogin() async {
    return await prefs.getBool('islogin');
  }
}










  // setcountchoseproudect(int countchoseproudect) {
  //   _countchoseproudect += countchoseproudect;
  //   notifyListeners();
  // }

  // getCountChoseProudect() {
  //   return _countchoseproudect;
  // }
