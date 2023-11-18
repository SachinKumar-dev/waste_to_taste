import 'package:flutter/material.dart';

class ScrollableImageContainer extends StatefulWidget {
  const ScrollableImageContainer({super.key});

  @override
  _ScrollableImageContainerState createState() =>
      _ScrollableImageContainerState();
}

class _ScrollableImageContainerState extends State<ScrollableImageContainer> {
  final List<String> imageUrls = [
    'https://plus.unsplash.com/premium_photo-1663045467897-6ff808fb7bac?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8Zm9vZCUyMGRvbmF0aW9ufGVufDB8fDB8fHww',
    'https://plus.unsplash.com/premium_photo-1663099744447-de198bcac9bf?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fGZvb2QlMjBkb25hdGlvbnxlbnwwfHwwfHx8MA%3D%3D',
    'https://plus.unsplash.com/premium_photo-1683141173692-aba4763bce41?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mjl8fGZvb2QlMjBkb25hdGlvbnxlbnwwfHwwfHx8MA%3D%3D',
    "https://plus.unsplash.com/premium_photo-1683121611041-b2a4cee2dad4?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nzd8fGZvb2QlMjBkb25hdGlvbnxlbnwwfHwwfHx8MA%3D%3D"
  ];

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          SizedBox(
            height: height * 0.3,
            width: double.infinity,
            child: PageView.builder(
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    imageUrls[index],
                    fit: BoxFit.cover,
                  ),
                );
              },
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              imageUrls.length,
                  (index) => buildDot(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDot(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        height: 8,
        width: 8,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentPage == index ? Colors.green.shade900 : Colors.grey,
        ),
      ),
    );
  }
}

