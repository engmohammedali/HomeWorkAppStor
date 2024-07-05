import 'package:appstore/pages/products/ProductDetailsPage.dart';
import 'package:appstore/pages/shared/models/Provider.dart';
import 'package:appstore/pages/shared/models/products_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatefulWidget {
  final Product product;
  final bool isGrid;

  ProductWidget({
    super.key,
    required this.product,
    this.isGrid = true,
  });

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  bool ischooseproduct = false;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Model>(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(product: widget.product),
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // photo
              Image.network(
                widget.product.thumbnail,
                fit: BoxFit.contain,
                height: widget.isGrid ? null : 200,
              ),

              // space
              const Spacer(),

              // title - price
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.product.title),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.product.price.toStringAsFixed(2)}\$',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          ischooseproduct = !ischooseproduct;

                          // TODO: ADD TO CART
                          if (ischooseproduct) {
                            provider.addToListMyBasket(
                              widget.product,
                            );
                          }
                          
                          else {
                            provider.removeProduct(
                              widget.product,
                            );
                          }
                   
                        },
                        icon: const Icon(
                          Icons.add_shopping_cart,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
