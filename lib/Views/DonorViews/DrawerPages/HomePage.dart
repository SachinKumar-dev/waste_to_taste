import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:waste_to_taste/Controllers/LocationPermission.dart';
import 'package:waste_to_taste/Controllers/LocationProvider.dart';
import 'package:waste_to_taste/Controllers/ReadDataController.dart';
import '../PagesOfContainer/Pages.dart';

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
      body: WillPopScope(
        onWillPop: () {
          context.go('/MainScreen');
          return (Future.value(false));
        },
        child: Consumer<LocationAddressProvider>(
          builder: (BuildContext context, provider, Widget? child) {
            return Stack(children: [
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: documents.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                     children: [
                                       const Icon(Icons.home_rounded,color:Colors.deepOrange,),
                                       Text("Home",
                                         style: GoogleFonts.roboto(
                                           fontSize: 19,
                                           fontWeight: FontWeight.w500,
                                           color: Colors.black,
                                         ),
                                       ),
                                     ],
                                   ),
                                    const SizedBox(height: 8,),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 6.0),
                                      child: Text(provider.address ??
                                          "Address not available",style:TextStyle(color: Colors.grey.shade700,fontSize: 15),),
                                    ),
                                    const Divider(
                                      thickness:0.5,
                                      color: Colors.grey,
                                      height: 30,
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                          const ScrollableImageContainer(),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              "Top food categories to donate",
                              style: GoogleFonts.roboto(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: SizedBox(
                                      height: height * 0.23,
                                      width: width * 0.4,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                              "assets/images/img.png",
                                              scale: 3.5,
                                            ),
                                          ),
                                          Text(
                                            "Breads",
                                            style: GoogleFonts.roboto(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: SizedBox(
                                      height: height * 0.23,
                                      width: width * 0.4,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                              "assets/images/rice.png",
                                              scale: 3.5,
                                            ),
                                          ),
                                          Text(
                                            "Rice",
                                            style: GoogleFonts.roboto(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: SizedBox(
                                      height: height * 0.23,
                                      width: width * 0.4,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                              "assets/images/vegies.png",
                                              scale: 3.5,
                                            ),
                                          ),
                                          Text(
                                            "   Cooked \nVegetables",
                                            style: GoogleFonts.roboto(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: SizedBox(
                                      height: height * 0.23,
                                      width: width * 0.4,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                              "assets/images/jamun.png",
                                              scale: 3.5,
                                            ),
                                          ),
                                          Text(
                                            "Sweets",
                                            style: GoogleFonts.roboto(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: SizedBox(
                                      height: height * 0.23,
                                      width: width * 0.4,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                              "assets/images/apple.png",
                                              scale: 3.5,
                                            ),
                                          ),
                                          Text(
                                            "Fruits",
                                            style: GoogleFonts.roboto(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 28.0,top: 30),
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
      ),
    );
  }
}
