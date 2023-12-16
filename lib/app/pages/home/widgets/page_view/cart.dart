import 'package:flutter/material.dart';
import 'package:flutter_trip_ui/app/pages/home/widgets/page_view/cart_widgets/empty_cart.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  bool emptyCart = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: emptyCart ? const EmptyCart() : const Placeholder(),
    );
  }
}
