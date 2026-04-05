// import 'package:flutter/material.dart';
// import 'package:shopping_cart/diopackage/model/users.dart';
// import 'package:shopping_cart/diopackage/pages/add_new_product.dart';
// import 'package:shopping_cart/diopackage/service/apiservice.dart';

// class UsersPage extends StatefulWidget {
//   const UsersPage({super.key});

//   @override
//   State<UsersPage> createState() => _UsersPageState();
// }

// class _UsersPageState extends State<UsersPage> {
//   final apiService = ApiService();
//   List<Users> products = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchProducts();
//   }

//   void fetchProducts() async {
//     final fetchedProducts = await apiService.getProducts();
//     setState(() {
//       products = fetchedProducts;
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Shopping Products"),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.add),
//             onPressed: () {
//               // Navigate to Add Product Page
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const AddProductPage()),
//               );
//             },
//           ),
//         ],
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : products.isEmpty
//           ? const Center(child: Text("No Products Available"))
//           : ListView.builder(
//               padding: const EdgeInsets.all(10),
//               itemCount: products.length,
//               itemBuilder: (context, i) {
//                 final item = products[i];
//                 return Card(
//                   elevation: 5,
//                   margin: const EdgeInsets.symmetric(vertical: 8),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: Row(
//                       children: [
//                         // Product Image
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(8),
//                           child: Image.network(
//                             item.image,
//                             width: 80,
//                             height: 80,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         const SizedBox(width: 15),
//                         // Product details
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 item.title,
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               const SizedBox(height: 5),
//                               Text(
//                                 "\$${item.price}",
//                                 style: const TextStyle(
//                                   color: Colors.green,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(height: 5),
//                               Text(
//                                 "Rating: ${item.rating?.rate ?? 0} (${item.rating?.count ?? 0})",
//                                 style: const TextStyle(fontSize: 12),
//                               ),
//                             ],
//                           ),
//                         ),
//                         // Update & Delete Buttons
//                         Column(
//                           children: [
//                             IconButton(
//                               icon: const Icon(Icons.edit, color: Colors.blue),
//                               onPressed: () {},
//                             ),
//                             IconButton(
//                               icon: const Icon(Icons.delete, color: Colors.red),
//                               onPressed: () {},
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:shopping_cart/diopackage/model/users.dart';
import 'package:shopping_cart/diopackage/pages/add_new_product.dart';
import 'package:shopping_cart/diopackage/service/apiservice.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final apiService = ApiService();
  List<Users> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    setState(() => isLoading = true);
    final fetchedProducts = await apiService.getProducts();
    setState(() {
      products = fetchedProducts;
      isLoading = false;
    });
  }

  void _navigateToAddProduct() async {
    final newProduct = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddProductPage()),
    );

    if (newProduct != null && newProduct is Users) {
      setState(() {
        products.add(newProduct);
      });
    }
  }

  void _navigateToUpdateProduct(Users product, int index) async {
    final updatedProduct = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddProductPage(product: product)),
    );

    if (updatedProduct != null && updatedProduct is Users) {
      setState(() {
        products[index] = updatedProduct;
      });
    }
  }

  // void _deleteProduct(int productId, int index) async {
  //   final confirmed = await showDialog(
  //     context: context,
  //     builder: (_) => AlertDialog(
  //       title: const Text("Confirm Delete"),
  //       content: const Text("Are you sure you want to delete this product?"),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context, false),
  //           child: const Text("No"),
  //         ),
  //         TextButton(
  //           onPressed: () => Navigator.pop(context, true),
  //           child: const Text("Yes"),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping Products"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _navigateToAddProduct,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: fetchProducts,
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : products.isEmpty
            ? const Center(child: Text("No Products Available"))
            : ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: products.length,
                itemBuilder: (context, i) {
                  final item = products[i];
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          // Product Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/placeholder.png',
                              image: item.image,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 15),
                          // Product details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "\$${item.price}",
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "Rating: ${item.rating?.rate ?? 0} (${item.rating?.count ?? 0})",
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          // Update & Delete Buttons
                          Column(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: () =>
                                    _navigateToUpdateProduct(item, i),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () => apiService
                                    .deleteProduct(item.id ?? 0)
                                    .then(
                                      (_) =>
                                          setState(() => products.removeAt(i)),
                                    )
                                    .catchError(
                                      (e) => ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "Failed to delete product: $e",
                                              ),
                                            ),
                                          ),
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
