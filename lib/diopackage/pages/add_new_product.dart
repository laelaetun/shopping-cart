import 'package:flutter/material.dart';
import 'package:shopping_cart/diopackage/model/users.dart';
import 'package:shopping_cart/diopackage/service/apiservice.dart';

class AddProductPage extends StatefulWidget {
  final Users? product; // if provided, page will update

  const AddProductPage({super.key, this.product});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final ApiService apiService = ApiService();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController titleController;
  late TextEditingController priceController;
  late TextEditingController descriptionController;
  late TextEditingController categoryController;
  late TextEditingController imageController;
  late TextEditingController ratingController;
  late TextEditingController countController;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.product?.title ?? '');
    priceController = TextEditingController(
      text: widget.product?.price.toString() ?? '',
    );
    descriptionController = TextEditingController(
      text: widget.product?.description ?? '',
    );
    categoryController = TextEditingController(
      text: widget.product?.category ?? '',
    );
    imageController = TextEditingController(text: widget.product?.image ?? '');
    ratingController = TextEditingController(
      text: widget.product?.rating?.rate.toString() ?? '',
    );
    countController = TextEditingController(
      text: widget.product?.rating?.count.toString() ?? '',
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    categoryController.dispose();
    imageController.dispose();
    ratingController.dispose();
    countController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final newProduct = Users(
      id: widget.product?.id,
      title: titleController.text,
      price: num.tryParse(priceController.text) ?? 0,
      description: descriptionController.text,
      category: categoryController.text,
      image: imageController.text,
      rating: Rating(
        rate: num.tryParse(ratingController.text) ?? 0,
        count: int.tryParse(countController.text) ?? 0,
      ),
    );

    Users? result;
    if (widget.product == null) {
      // Add new
      result = await apiService.addProduct(newProduct);
    } else {
      // Update existing
      result = await apiService.addProduct(newProduct);
    }

    if (result != null) {
      Navigator.pop(context, result);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Failed to save product")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isUpdate = widget.product != null;
    return Scaffold(
      appBar: AppBar(title: Text(isUpdate ? "Update Product" : "Add Product")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Title"),
                validator: (value) =>
                    value!.isEmpty ? "Title is required" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Price"),
                validator: (value) =>
                    value!.isEmpty ? "Price is required" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
                validator: (value) =>
                    value!.isEmpty ? "Description is required" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: categoryController,
                decoration: const InputDecoration(labelText: "Category"),
                validator: (value) =>
                    value!.isEmpty ? "Category is required" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: imageController,
                decoration: const InputDecoration(labelText: "Image URL"),
                validator: (value) =>
                    value!.isEmpty ? "Image URL is required" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: ratingController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Rating"),
                validator: (value) =>
                    value!.isEmpty ? "Rating is required" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: countController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Rating Count"),
                validator: (value) =>
                    value!.isEmpty ? "Rating count is required" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text(isUpdate ? "Update Product" : "Add Product"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
