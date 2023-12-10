import 'package:flutter/material.dart';

class ImageGridPage extends StatelessWidget {
  final List<String> imageUrls = [
"https://img.freepik.com/premium-vector/dont-waste-food-world-food-day-international-awareness-day-food-loss-waste-vector_201904-924.jpg?size=626&ext=jpg&ga=GA1.1.132290296.1702190481&semt=ais"
  ];

  ImageGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0E6B56),
        title: const Text("Awareness"),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns in the grid
        ),
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrls[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}