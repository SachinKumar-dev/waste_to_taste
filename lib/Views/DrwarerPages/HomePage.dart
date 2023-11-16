import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:waste_to_taste/Controllers/LocationProvider.dart';
import 'package:waste_to_taste/Controllers/ReadDataController.dart';
import 'package:waste_to_taste/Views/PagesOfContainer/Pages.dart';
import '../../Controllers/LocationPermission.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<void> fetchData;

  @override
  void initState() {
    super.initState();
    context.read<LocationPermission>().getLocation(context);
    fetchData = context.read<ReadDataController>().readData();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Consumer<LocationAddressProvider>(
        builder: (BuildContext context, provider, Widget? child) {
          return Stack(children: [
            // Image.asset("assets/logos/dum.png",height: double.infinity,width: double.infinity,fit: BoxFit.cover,),
            FutureBuilder(
              future: fetchData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // Handle error case
                  return Text('Error: ${snapshot.error}');
                } else {
                  // Data has been successfully fetched
                  List<DocumentSnapshot> documents =
                      context.read<ReadDataController>().documents;
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            shadowColor: Colors.blueGrey,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: documents.length,
                              itemBuilder: (context, index) {
                                String imageUrl = documents[index]["imageUrlP"];
                                return Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        radius: 30,
                                        child: ClipOval(
                                          child: Image.network(
                                            imageUrl,
                                            height: 140,
                                            width: 140,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          documents[index]['name'],
                                          style: GoogleFonts.roboto(
                                            fontSize: 19,fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              "assets/logos/img_5.png",
                                              scale: 25,
                                            ),
                                            Text(provider.address ??
                                                "Address not available"),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        const ScrollableImageContainer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: height * 0.33,
                            width: double.infinity,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 370,
                            height: 53,
                            child: ElevatedButton(
                                onPressed: () async {
                                  context.go('/location');
                                },
                                child: const Text(
                                  "Donate",
                                  style: TextStyle(fontSize: 16),
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  );
                }
              },
            ),
          ]);
        },
      ),
    );
  }
}
