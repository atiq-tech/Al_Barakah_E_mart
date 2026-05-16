// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class Product {
//   final String name;
//   final String description;
//
//   Product({required this.name, required this.description});
// }
//
// class MyApp extends StatelessWidget {
//   final List<Product> products = [
//     Product(name: "Product 1", description: "Description for Product 1"),
//     Product(name: "Product 2", description: "Description for Product 2"),
//     Product(name: "Product 3", description: "Description for Product 3"),
//     // Add more products as needed
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Daraz Search'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               TextField(
//                 onChanged: (value) {
//                   // Implement search logic here
//                   // You can filter the products based on the search query
//                   List<Product> searchResults = products
//                       .where((product) =>
//                       product.name.toLowerCase().contains(value.toLowerCase()))
//                       .toList();
//
//                   // Update the UI with the search results
//                   // For simplicity, you can use a ListView.builder to display the results
//                   // You may also consider using a GridView or a custom UI based on your needs
//                   // For now, we'll just print the results to the console
//                   print(searchResults);
//                 },
//                 decoration: const InputDecoration(
//                   labelText: 'Search',
//                   hintText: 'Enter product name',
//                   prefixIcon: Icon(Icons.search),
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               // Display search results here (ListView, GridView, etc.)
//               // For simplicity, we are not displaying results in this example
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
