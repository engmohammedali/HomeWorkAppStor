import 'package:appstore/pages/cart/Mybasket.dart';
import 'package:appstore/pages/shared/models/Provider.dart';
import 'package:appstore/pages/shared/widgets/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageLayout extends StatefulWidget {
  final String title;
  final Widget body;
  const PageLayout({super.key, required this.title, required this.body});

  @override
  State<PageLayout> createState() => _PageLayoutState();
}

class _PageLayoutState extends State<PageLayout> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Model>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Stack(children: [
              Padding(
                padding: const EdgeInsets.only(right: 3),
                child: IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyBasket()));
                    },
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
      drawer: MyDrawer(),
      body: widget.body,
    );
  }
}
