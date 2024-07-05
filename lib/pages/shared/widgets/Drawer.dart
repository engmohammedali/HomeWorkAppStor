import 'package:appstore/pages/auth/login.dart';
import 'package:appstore/pages/cart/Mybasket.dart';
import 'package:appstore/pages/home/home_page.dart';
import 'package:appstore/pages/products/ProductsPage.dart';
import 'package:appstore/pages/shared/models/Provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
              arrowColor: const Color.fromARGB(255, 238, 238, 238),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/drower.jpg'), fit: BoxFit.cover),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/me.jpg'),
              ),
              accountName: Text("Mohammedali"),
              accountEmail: Text("mohameed661@gmail.com")),
          Card(
            child: ListTile(
              leading: Icon(Icons.home),
              title: Text('Home Page'),
              trailing: Icon(Icons.navigate_next),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => HomePage(),
                  ),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text('Products Page'),
              trailing: Icon(Icons.navigate_next),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ProductsPage(),
                  ),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.add_shopping_cart),
              title: Text('My Basket'),
              trailing: Icon(Icons.navigate_next),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => MyBasket(),
                  ),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.login),
              title: Text('Login'),
              trailing: Icon(Icons.navigate_next),
              onTap: () {
                if (context.read<Model>().getchecklogin()) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.rightSlide,
                    title: 'You have already logged in',
                    desc: '',
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {},
                  ).show();
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => Login(),
                    ),
                  );
                }
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.login),
              title: Text('Logout'),
              trailing: Icon(Icons.navigate_next),
              onTap: () async {
                context.read<Model>().islogin(false);
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => Login(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
