import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:waste_to_taste/Controllers/ReadDataController.dart';

class PageOne extends StatefulWidget {
  const PageOne({super.key});

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  late Future<void> fetchData;

  @override
  void initState() {
    super.initState();
    fetchData = context.read<ReadDataController>().readData();
  }

  //fetch imageUrl
  Future<String> getImageUrl(String imageUrl) async {
    await Future.delayed(const Duration(seconds: 2));
    return imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: FutureBuilder(
        future: fetchData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Data is still being fetched
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Handle error case
            return const Center(child: Text('Something went wrong.}'));
          } else {
            // Data has been successfully fetched
            List<DocumentSnapshot> documents =
                context.read<ReadDataController>().documents;
            return Stack(
              children: [
                Container(
                  height: height * 0.45,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Color(0xff0E6B56),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                      )),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 28.0),
                        child: Column(
                          children: [
                            FutureBuilder<String>(
                              future:
                                  getImageUrl(documents[index]["imageUrlP"]),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  // Shimmer while loading
                                  return Shimmer.fromColors(
                                    baseColor: Colors.blueGrey[400]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: CircleAvatar(
                                      radius: 70,
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
                                    radius: 70,
                                    backgroundColor: Colors.white,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
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
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15.0, top: 25),
                              child: Text(
                                documents[index]['name'], // Your text goes here
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),

                            ),
                          ],
                        ),
                      );
                    }),
                Align(
                  alignment: const Alignment(0.2, 0.4),
                  child: Card(
                    elevation: 1,
                    child: Container(
                      height: height * 0.48,
                      width: width * 0.95,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50)),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: documents.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                const SizedBox(height:100),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height*.09,
                                    width: 350,
                                    child: Card(
                                      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                        color: const Color(0xff0E6B56),
                                        child: ListTile(
                                          title: Text(
                                            "Email",
                                            style: GoogleFonts.poppins(
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                          subtitle: Padding(
                                            padding: const EdgeInsets.only(bottom: 12.0,top: 5),
                                            child: Text(
                                              documents[index]["email"],
                                              overflow: TextOverflow.ellipsis,
                                              maxLines:2,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                             ),
                                            ),
                                          ),
                                        ))),
                                const SizedBox(
                                  height: 40,
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height*.09,
                                    width: 350,
                                    child: Card(
                                        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                        color: const Color(0xff0E6B56),
                                        child: ListTile(
                                          title: Text(
                                            "Contact",
                                            style: GoogleFonts.poppins(
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                          subtitle: Padding(
                                            padding: const EdgeInsets.only(top: 5.0),
                                            child: Text(
                                              documents[index]["MobileNumber"],
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17),
                                            ),
                                          ),
                                        ))),
                              ],
                            );
                          }),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
