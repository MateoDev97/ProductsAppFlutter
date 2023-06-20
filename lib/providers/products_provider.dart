import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:products_app/models/product.dart';

class ProductsProvider extends ChangeNotifier {
  final String _baseUrl = 'flutterproducts-7b150-default-rtdb.firebaseio.com';

  late Product selectedProduct;
  File? newPictureFile;

  Future<List<Product>?> getAllProducts() async {
    final url = Uri.https(_baseUrl, 'products.json');

    final response = await http.get(url);

    final Map<String, dynamic> productsMap = json.decode(response.body);

    final List<Product> listProducts = [];

    productsMap.forEach((key, value) {
      final tempProduct = Product.fromJson(value);
      tempProduct.id = key;
      listProducts.add(tempProduct);
    });
    return listProducts;
  }

  Future createOrUpdateProduct(Product product) async {
    if (product.id == null) {
      createProduct(product);
    } else {
      updateProduct(product);
    }
  }

  Future createProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products.json');
    await http.post(url, body: product.toRawJson());
  }

  Future updateProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products/${product.id}.json');
    await http.put(url, body: product.toRawJson());
  }

  updateSelectedImage(String path) {
    selectedProduct.image = path;
    newPictureFile = File.fromUri(Uri(path: path));
    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if (newPictureFile == null) return null;

    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/mateodev97/image/upload?upload_preset=ppwj9no8');

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file =
        await http.MultipartFile.fromPath('file', newPictureFile!.path);
    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();

    final resp = await http.Response.fromStream(streamResponse);

    newPictureFile = null;

    print(resp.body);

    return jsonDecode(resp.body)['secure_url'];
  }
}
