import 'package:appstore/pages/shared/models/Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyBasket extends StatefulWidget {
  const MyBasket({super.key});

  @override
  State<MyBasket> createState() => _MyBasketState();
}

class _MyBasketState extends State<MyBasket> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Model>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // if (context.watch<Model>().countProducts() == 0) {
          //   AwesomeDialog(
          //     context: context,
          //     dialogType: DialogType.info,
          //     animType: AnimType.rightSlide,
          //     title: 'The basket is empty',
          //     desc: 'Please select a product',
          //     btnCancelOnPress: () {},
          //     btnOkOnPress: () {},
          //   )..show();
          // } else if (context.read<Model>().getchecklogin()) {
          //   provider.removeAllProduct();
          //   ShowsnackBar(context, " Was purchased");
          // } else {
          //   AwesomeDialog(
          //     context: context,
          //     dialogType: DialogType.error,
          //     animType: AnimType.rightSlide,
          //     title: 'Please login',
          //     desc: '',
          //     btnCancelOnPress: () {},
          //     btnOkText: "Login",
          //     btnCancelText: "Cancel",
          //     btnOkOnPress: () {
          //       Navigator.push(
          //           context, MaterialPageRoute(builder: (context) => Login()));
          //     },
          //   )..show();
          // }
        },
        child: Text("Buy"),
      ),
      appBar: AppBar(
        title: Text("My Basket"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text("${provider.totlePrice().toStringAsFixed(2)}"),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Stack(children: [
              Padding(
                padding: const EdgeInsets.only(right: 3),
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      color: const Color.fromARGB(255, 255, 82, 82),
                    )),
              ),
              Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.redAccent),
                      child: Text(
                        "${provider.countProducts()}",
                        style: TextStyle(color: Colors.white),
                      )))
            ]),
          ),
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          child: ListView.builder(
              itemCount: provider.countProducts(),
              itemBuilder: (context, int index) {
                return Card(
                    child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(provider
                        .getAllProdectMyBasket()[index]
                        .images
                        .first
                        .toString()),
                  ),
                  title:
                      Text("${provider.getAllProdectMyBasket()[index].title}"),
                  subtitle: Text(
                      "${provider.getAllProdectMyBasket()[index].price.toStringAsFixed(2)}\$"),
                  trailing: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () {
                            // provider.addToListMyBasket(
                            //   provider.getAllProdectMyBasket()[index],
                            // );
                          },
                          icon: Icon(Icons.add)),
                      IconButton(
                          onPressed: () {
                            provider.removeProduct(
                                provider.getAllProdectMyBasket()[index]);
                          },
                          icon: Icon(Icons.remove)),
                    ],
                  ),
                ));
              })),
    );
  }
}
