import 'package:flutter/material.dart';
import 'package:products_app/models/product.dart';
import 'package:products_app/providers/products_provider.dart';
import 'package:products_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: FutureBuilder(
        future: productsProvider.getAllProducts(),
        builder: (_, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const LoadingWidget();
          }

          final List<Product> listProducts = snapshot.data;

          return ListView.builder(
            itemCount: listProducts.length,
            itemBuilder: (context, index) => GestureDetector(
              child: CardProduct(product: listProducts[index]),
              onTap: () {
                Navigator.pushNamed(context, 'product',
                    arguments: listProducts[index]);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'product',
              arguments: Product(available: true, name: '', price: 0));
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
