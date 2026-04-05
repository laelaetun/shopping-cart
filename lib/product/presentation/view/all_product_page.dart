// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shopping_cart/product/presentation/bloc/product_bloc.dart';
// import 'package:shopping_cart/product/presentation/bloc/product_event.dart';
// import 'package:shopping_cart/product/presentation/bloc/product_state.dart';

// class AllProductPage extends StatefulWidget {
//   const AllProductPage({super.key});

//   @override
//   State<AllProductPage> createState() => _AllProductPageState();
// }

// class _AllProductPageState extends State<AllProductPage> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<ProductBloc>().add(ProductGetEvent());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Center(child: Text("Json Data"))),
//       body: BlocBuilder<ProductBloc, ProductState>(
//         builder: (context, state) {
//           if (state is ProductLoading) {
//             return Center(child: CircularProgressIndicator());
//           } else if (state is ProductLoaded) {
//             final data = state.products;
//             return ListView.builder(
//               itemCount: data.length,

//               itemBuilder: (context, index) {
//                 final resultIndex = state.products[index];
//                 print(resultIndex);
//                 return Card(child: ListTile(title: Text(resultIndex.title)));
//               },
//             );
//           }
//           return Container();
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/product/presentation/bloc/product_bloc.dart';
import 'package:shopping_cart/product/presentation/bloc/product_event.dart';
import 'package:shopping_cart/product/presentation/bloc/product_state.dart';
import 'package:shopping_cart/product/presentation/view/product_detail_page.dart';

class AllProductPage extends StatefulWidget {
  const AllProductPage({super.key});

  @override
  State<AllProductPage> createState() => _AllProductPageState();
}

class _AllProductPageState extends State<AllProductPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(ProductGetEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Products"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 8.0),
            child: GestureDetector(
              onTap: () {
                // Navigate to Cart Page
              },
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      size: 28,
                      color: Colors.black,
                    ),
                  ),
                  if (1 > 0) // Only show badge if there are items
                    Positioned(
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red, // Badge color
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 18,
                          minHeight: 18,
                        ),
                        child: Text(
                          "1",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProductLoaded) {
            final products = state.products;

            return GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.72,
              ),
              itemBuilder: (context, index) {
                final product = products[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailPage(product: product),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //IMAGE + FAVORITE ICON
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                              child: Image.network(
                                product.image,
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    const Icon(Icons.image, size: 80),
                              ),
                            ),

                            /// ❤️ Favorite Icon
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.favorite_border,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    //  favorite toggle
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),

                        /// 🔹 DETAILS
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// NAME
                              Text(
                                product.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),

                              const SizedBox(height: 6),

                              //CART (ONE ROW)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "\$${product.price}",
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  IconButton(
                                    onPressed: () {
                                      // add to cart
                                    },
                                    icon: const Icon(
                                      Icons.shopping_cart_outlined,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),

                              ///STOCK
                              Text(
                                "Stock}",
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          // if (state is ProductError) {
          //   return const Center(child: Text("Error loading products"));
          // }

          return const SizedBox();
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shopping_cart/product/presentation/bloc/product_bloc.dart';
// import 'package:shopping_cart/product/presentation/bloc/product_event.dart';
// import 'package:shopping_cart/product/presentation/bloc/product_state.dart';

// class AllProductPage extends StatefulWidget {
//   const AllProductPage({super.key});

//   @override
//   State<AllProductPage> createState() => _AllProductPageState();
// }

// class _AllProductPageState extends State<AllProductPage> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<ProductBloc>().add(ProductGetEvent());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("All Products"), centerTitle: true),
//       body: BlocBuilder<ProductBloc, ProductState>(
//         builder: (context, state) {
//           // 🔄 Loading
//           if (state is ProductLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           else if (state is ProductLoaded) {
//             final products = state.products;

//             if (products.isEmpty) {
//               return const Center(child: Text("No Products"));
//             }

//             return ListView.builder(
//               itemCount: products.length,
//               itemBuilder: (context, index) {
//                 final item = products[index];

//                 return Card(
//                   margin: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 6,
//                   ),
//                   elevation: 3,
//                   child: ListTile(
//                     title: Text(
//                       item.title,
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),

//                     leading: CircleAvatar(child: Text("${item.id}")),
//                   ),
//                 );
//               },
//             );
//           }

//           return const SizedBox();
//         },
//       ),
//     );
//   }
// }
