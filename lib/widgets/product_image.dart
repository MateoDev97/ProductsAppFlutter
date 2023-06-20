import 'dart:io';

import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String urlImage;

  const ProductImage({super.key, required this.urlImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        decoration: imageDecoration(),
        width: double.infinity,
        height: 450,
        child: Opacity(
          opacity: 0.8,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(45),
              topRight: Radius.circular(45),
            ),
            child: getImageProduct(urlImage),
          ),
        ),
      ),
    );
  }

  Widget getImageProduct(String urlImage) {
    if (urlImage.isEmpty) {
      return const FadeInImage(
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        image: NetworkImage(
            'https://dicesabajio.com.mx/wp-content/uploads/2021/06/no-image.jpeg'),
        placeholder: AssetImage('assets/jar-loading.gif'),
      );
    } else if (urlImage.startsWith('http')) {
      return FadeInImage(
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        image: NetworkImage(urlImage),
        placeholder: const AssetImage('assets/jar-loading.gif'),
      );
    } else {
      return Image.file(
        width: double.infinity,
        height: double.infinity,
        File(urlImage),
        fit: BoxFit.cover,
      );
    }
  }

  BoxDecoration imageDecoration() => BoxDecoration(
        color: Colors.black,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(45),
          topRight: Radius.circular(45),
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5)),
        ],
      );
}
