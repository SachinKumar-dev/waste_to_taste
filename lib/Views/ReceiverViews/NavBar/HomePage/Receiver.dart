import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:waste_to_taste/Controllers/foodDocReadController.dart';
import 'package:waste_to_taste/Controllers/userDocReadController.dart';

class FoodListScreen extends StatefulWidget {
  String userId;
   FoodListScreen({super.key,required this.userId});

  @override
  _FoodListScreenState createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  @override
  void initState() {
    super.initState();
    print('User ID in FoodListScreen: ${widget.userId}');
    context.read<FoodDoc>().readData(context,widget.userId);
    context.read<UserDoc>().readData(context);
  }

  //fetch imageUrl
  Future<String> getImageUrl(String imageUrl) async {
    await Future.delayed(const Duration(seconds: 2));
    return imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Details'),
      ),
      body:Consumer2<FoodDoc, UserDoc>(
        builder: (context, foodDoc, userDoc, child) {
          if (foodDoc.foodDocs.isEmpty || userDoc.userDocs.isEmpty) {
            // No data available
            return const Center(
              child: Text('No data available.'),
            );
          }
          return ListView.builder(
            itemCount: foodDoc.foodDocs.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: (){
                          context.go("/foodDetails");
                        },
                        child: SizedBox(
                          height: mq.height * 0.3,
                          width: mq.width * 0.99,
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 2,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 25,
                        top: 25,
                        child: Container(
                          height: mq.height * 0.01,
                          width: mq.width * 0.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color(0xff1B2EF4),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 25,
                        top: 65,
                        child:FutureBuilder<String>(
                          future:
                          getImageUrl(userDoc.userDocs[index]["imageUrlP"]),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              // Shimmer while loading
                              return Shimmer.fromColors(
                                baseColor: Colors.blueGrey[400]!,
                                highlightColor: Colors.grey[100]!,
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.white,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return const Text('Error loading image');
                            } else if (snapshot.hasData) {
                              // Image loaded successfully
                              return CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.white,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(0xff0E6B56),
                                      width: 2,
                                    ),
                                  ),
                                  child: ClipOval(
                                    child: Image.network(
                                      snapshot.data!,
                                      fit: BoxFit.cover,
                                      height: 160,
                                      width: 140,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              // Handle the case when snapshot.data is null
                              return const Text('Image URL is null');
                            }
                          },
                        ),
                      ),
                      Positioned(
                        left: 140,
                        top: 100,
                        child: SizedBox(
                          width: 200,
                          child: Text(
                            userDoc.userDocs[index]['name'],
                            style: GoogleFonts.roboto(fontSize: 20),
                            overflow: TextOverflow.ellipsis,

                          ),
                        ),
                      ),
                      Positioned(
                        left: 55,
                        top: 194,
                        child: SizedBox(
                          width: 200,
                          child: Text(
                            foodDoc.foodDocs[index]['location'],
                            style: const TextStyle(fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 25,
                        top: 190,
                        child: Icon(
                          Icons.location_on_rounded,
                          color: Colors.red,
                        ),
                      ),
                      Positioned(
                        left: 350,
                        top: 205,
                        child: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            size: 28,
                          ),
                          color: Colors.red,
                          onPressed: () {
                            //fun
                          },
                        ),
                      ),
                      Positioned(
                        left: 25,
                        top: 235,
                        child: Container(
                          height: mq.height * 0.01,
                          width: mq.width * 0.35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color(0xffD67180),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 115,
                        top: 25,
                        child: Container(
                          height: mq.height * 0.01,
                          width: mq.width * 0.35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color(0xffB2BFF0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
