import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:waste_to_taste/Controllers/donateStatus.dart';
import '../../../../Controllers/foodDocReadController.dart';

class FoodDetails extends StatefulWidget {
  const FoodDetails({super.key});

  @override
  State<FoodDetails> createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  @override
  void initState() {
    super.initState();
    context.read<FoodDoc>().readData(context," ");
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: WillPopScope(
        onWillPop: (){
          context.go("/navBar");
          return (Future.value(false));
        },
        child: Consumer2<FoodDoc,DonationProvider>(
          builder: (context, foodDoc,status, child) {
            return Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xff0E6B56),
                        Colors.white,
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Container(
                        height: mq.height * 0.7,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: ListView.builder(
                          // physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 88.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.account_circle_rounded,
                                            color: Color(0xff0E6B56),
                                          ),
                                        ),
                                        Text(
                                          foodDoc.foodDocs[index]['contact'],
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(Icons.location_on,
                                              color: Colors.red),
                                        ),
                                        SizedBox(
                                          width: 200,
                                          child: Text(
                                            foodDoc.foodDocs[index]['location'],
                                            style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 16),
                                            maxLines: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(Icons.date_range_rounded,
                                              color: Color(0xff0E6B56)),
                                        ),
                                        SizedBox(
                                          width: 200,
                                          child: Text(
                                            foodDoc.foodDocs[index]['date'],
                                            style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 18),
                                            maxLines: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(Icons.pin,
                                              color: Color(0xff0E6B56)),
                                        ),
                                        SizedBox(
                                          width: 200,
                                          child: Text(
                                            foodDoc.foodDocs[index]['pinCode'],
                                            style: const TextStyle(
                                              fontSize: 18,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            maxLines: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(Icons.access_time_filled,
                                              color: Color(0xff0E6B56)),
                                        ),
                                        Text(
                                          foodDoc.foodDocs[index]['startTime'] +
                                              "   --  ",
                                          style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 18),
                                          maxLines: 2,
                                        ),
                                        Text(
                                          foodDoc.foodDocs[index]['endTime'],
                                          style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 18),
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(Icons.fastfood_rounded,
                                                  color: Color(0xff0E6B56)),
                                            ),
                                            Text(
                                              'Food: ${foodDoc.foodDocs[index]['rows'].map((item) => '${item['food']}').join(', ')}',
                                              style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 18,
                                              ),
                                              maxLines: 2,
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              const Icon(Icons.timelapse_rounded,
                                                  color: Color(0xff0E6B56)),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Shelf Life: ${foodDoc.foodDocs[index]['rows'].map((item) => ' ${item['shelfLife']}').join(', ')}',
                                                  style: const TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: 18,
                                                  ),
                                                  maxLines: 2,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(Icons.numbers_rounded,
                                                  color: Color(0xff0E6B56)),
                                            ),
                                            Text(
                                              'Quantity: ${foodDoc.foodDocs[index]['rows'].map((item) => '${item['quantity']}').join(', ')}',
                                              style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 18,
                                              ),
                                              maxLines: 2,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  // ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //       top: 28.0, left: 110, bottom: 20),
                                  //   child: SizedBox(
                                  //     width: mq.width * 0.5,
                                  //     height: mq.height * 0.05,
                                  //     child: ElevatedButton(
                                  //         onPressed: () {
                                  //           status.donate();
                                  //         },
                                  //         child: const Text(
                                  //           "Received",
                                  //           style: TextStyle(fontSize: 16),
                                  //         )),
                                  //   ),
                                  // )
                                  )],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 180,
                  left: 120,
                  child: SizedBox(
                    height: mq.height * 0.2,
                    width: 200,
                    child:
                        Image.asset("assets/logos/salad.png", fit: BoxFit.cover),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
