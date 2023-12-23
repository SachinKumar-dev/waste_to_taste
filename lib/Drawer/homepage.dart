import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        children: [
          const Text("HomePage"),
          ElevatedButton(onPressed: (){
            context.go('/location');
          }, child: const Icon(Icons.forward)
          )],
      )),
    );
  }
}
