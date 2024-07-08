import 'dart:convert';

import 'package:appstore/pages/shared/models/products_response.dart';
import 'package:appstore/pages/shared/widgets/Snackbar.dart';
import 'package:appstore/services/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class Model extends ChangeNotifier {
  // late SharedPreferences prefs;
  
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

  // islogin(bool islogin) async {
  //   prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('islogin', islogin);
  // }

  // getchecklogin() async {
  //   return await prefs.getBool('islogin');
  // }



  //    Future<void> addCart() async {
   
  //   final url = Uri.parse('https://dummyjson.com/carts/add');
  //   final response = await post(
  //     url,
  //     headers: {'Content-Type': 'application/json'},
  //     body: json.encode( 
  
    
  //   )
  //   );

  //   if (response.statusCode == 200) {
  //     // ShowsnackBar(context, "Account successfully created");
  //     final data = json.decode(response.body);
  //     final token = data['token'];
  //     print('Login successful. Token: $token');
     
  //   } else {
  //     // ShowsnackBar(
  //     //     context, " Login failed. Status code: ${response.statusCode}");
  //     // print('Response: ${response.body}');
  //   }
   
  // }

  
}










  // setcountchoseproudect(int countchoseproudect) {
  //   _countchoseproudect += countchoseproudect;
  //   notifyListeners();
  // }

  // getCountChoseProudect() {
  //   return _countchoseproudect;
  // }
