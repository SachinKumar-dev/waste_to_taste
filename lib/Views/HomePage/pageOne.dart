import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PageOne extends StatefulWidget {
  const PageOne({super.key});

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: (){
          context.go("/MainScreen");
          return (Future.value(false));
        },
        child: Center(
          child: GestureDetector(
            onTap: (){
              context.go("/login");
            },
            child: Container(
              height: 160,
              width: 160,
              decoration:
                  const BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
              child: const Center(child: Text("Coming Soon.....",style: TextStyle(fontSize: 20,color: Colors.white),)),
            ),
          ),
        ),
      ),
    );
  }
}
