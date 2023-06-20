import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:products_app/models/product.dart';
import 'package:products_app/providers/product_form_provider.dart';
import 'package:products_app/providers/products_provider.dart';
import 'package:products_app/theme/app_theme.dart';
import 'package:products_app/ui/input_decoration.dart';
import 'package:products_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)?.settings.arguments as Product;

    final productsProvider = Provider.of<ProductsProvider>(context);

    productsProvider.selectedProduct = product;

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(product),
      child: _ProductBody(),
    );
  }
}

class _ProductBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productFormProvider = Provider.of<ProductFormProvider>(context);

    final productsProvider = Provider.of<ProductsProvider>(context);

    navigateToHome() {
      productsProvider.newPictureFile = null;
      Navigator.pushReplacementNamed(context, 'home');
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(
                    urlImage: productsProvider.selectedProduct.image ?? ''),
                Positioned(
                  top: 60,
                  left: 20,
                  child: IconButton(
                    onPressed: () {
                      navigateToHome();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  top: 60,
                  right: 25,
                  child: IconButton(
                    onPressed: () async {
                      final picker = ImagePicker();
                      final XFile? pickedFile =
                          await picker.pickImage(source: ImageSource.camera);
                      if (pickedFile == null) return;
                      productsProvider.updateSelectedImage(pickedFile.path);
                    },
                    icon: const Icon(
                      Icons.camera_alt_rounded,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            _ContainerForm(),
            const SizedBox(height: 100)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          FocusScope.of(context).unfocus();
          if (!productFormProvider.isValidForm()) return;

          final String? urlImage = await productsProvider.uploadImage();

          if (urlImage != null) productFormProvider.product.image = urlImage;

          await productsProvider
              .createOrUpdateProduct(productFormProvider.product);
          navigateToHome();
        },
        child: const Icon(Icons.save),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}

class _ContainerForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productFormProvider = Provider.of<ProductFormProvider>(context);

    final selectedProduct = productFormProvider.product;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _containerBoxDecoration(),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: productFormProvider.formKey,
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextFormField(
                initialValue: selectedProduct.name,
                onChanged: (value) {
                  selectedProduct.name = value;
                },
                validator: (value) {
                  return (value == null || value.isEmpty)
                      ? 'Name is required'
                      : null;
                },
                decoration: InputDecorations.loginInputDecoration(
                  hintText: 'Product Name',
                  labelText: 'Product',
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                initialValue: '${selectedProduct.price}',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: (value) {
                  selectedProduct.price = (double.tryParse(value) == null)
                      ? 0
                      : double.parse(value);
                },
                validator: (value) {
                  return (value == null || value.isEmpty)
                      ? 'Price is required'
                      : null;
                },
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecorations.loginInputDecoration(
                  hintText: '\$150',
                  labelText: 'Price',
                ),
              ),
              const SizedBox(height: 30),
              SwitchListTile.adaptive(
                title: const Text('Available'),
                value: selectedProduct.available,
                activeColor: AppTheme.primaryColor,
                onChanged: productFormProvider.updateAvailability,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _containerBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(45),
            bottomRight: Radius.circular(45),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 5),
                blurRadius: 5)
          ]);
}
