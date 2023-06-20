import 'package:flutter/material.dart';
import 'package:products_app/models/product.dart';
import 'package:products_app/theme/app_theme.dart';

class CardProduct extends StatelessWidget {
  final Product product;

  const CardProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Container(
          width: double.infinity,
          height: 320,
          decoration: _cardShape(),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _CardHomeBackground(urlImage: product.image ?? ''),
              _CardPriceContainer(price: product.price.toString()),
              _CardDescContainer(name: product.name, id: product.id ?? ''),
              (product.available) ? Container() : _CardNotAvailableContainer()
            ],
          )),
    );
  }

  BoxDecoration _cardShape() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 15,
            offset: Offset(0, 5),
          )
        ],
      );
}

class _CardHomeBackground extends StatelessWidget {
  final String urlImage;

  const _CardHomeBackground({required this.urlImage});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: FadeInImage(
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        image: NetworkImage((urlImage.isNotEmpty)
            ? urlImage
            : 'https://dicesabajio.com.mx/wp-content/uploads/2021/06/no-image.jpeg'),
        placeholder: const AssetImage('assets/jar-loading.gif'),
      ),
    );
  }
}

class _CardNotAvailableContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.yellow[800],
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        width: 110,
        height: 60,
        child: const Center(
          child: FittedBox(
            fit: BoxFit.contain,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('No disponible',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ),
        ),
      ),
    );
  }
}

class _CardPriceContainer extends StatelessWidget {
  final String price;

  const _CardPriceContainer({required this.price});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Container()),
        Container(
          decoration: const BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20))),
          width: 110,
          height: 60,
          child: Center(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text('\$$price',
                    style: const TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CardDescContainer extends StatelessWidget {
  final String name;
  final String id;

  const _CardDescContainer({required this.name, required this.id});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Container(
        decoration: const BoxDecoration(
          color: AppTheme.primaryColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        width: double.infinity,
        height: 65,
        child: Padding(
          padding: const EdgeInsets.only(top: 8, left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                id,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
