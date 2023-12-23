import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:waste_to_taste/Controllers/LocationProvider.dart';

class AddItems extends StatefulWidget {
  final String userId;

  const AddItems({required this.userId, super.key});

  @override
  State<AddItems> createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
  // Controllers
  TextEditingController contactController = TextEditingController();
  TextEditingController pickupController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();

  // Dynamic rows
  List<RowData> rows = [RowData()];

  // Select time
  Future<void> _selectTime(
      BuildContext context, TextEditingController controller) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      controller.text = pickedTime.format(context);
    }
  }

  // Select date
  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime lastDate = DateTime(2030, 12, 31);
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: lastDate,
    );

    if (pickedDate != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  // Check for emptiness of fields
  bool checkAndShowDialog() {
    bool allRowsFilled = rows.every((row) => row.isFilled());
    if (contactController.text.isEmpty ||
        pickupController.text.isEmpty ||
        startTimeController.text.isEmpty ||
        endTimeController.text.isEmpty ||
        dateController.text.isEmpty ||
        pinCodeController.text.isEmpty ||
        !allRowsFilled) {
      showAlertDialog(
          context, "All fields are mandatory to fill.");
      return false; // Conditions not met
    }
    return true; // Conditions met
  }

  // Make sure start and end time must be different
  bool timeCheck() {
    if (startTimeController.text.trim() == endTimeController.text.trim()) {
      showAlertDialog(context, "Start and end time cannot be the same.");
      return false; // Conditions not met
    }
    return true; // Conditions met
  }

  // Create data
  Future<void> createData() async {
    DateTime now = DateTime.now();

    // Create a list to store data for each row
    List<Map<String, dynamic>> rowsData = [];

    // Loop through each row
    for (RowData row in rows) {
      if (row.isFilled()) {
        rowsData.add({
          "food": row.foodController.text,
          "shelfLife": row.shelfLifeController.text,
          "quantity": row.quantityController.text,
        });
      }
    }

    print("UserId: ${widget.userId}");

    CollectionReference db =
        FirebaseFirestore.instance.collection("Food Details");
    await db.add({
      "userId": widget.userId,
      "contact": contactController.text,
      "location": pickupController.text,
      "startTime": startTimeController.text,
      "endTime": endTimeController.text,
      "date": dateController.text,
      "pinCode": pinCodeController.text,
      "rows": rowsData,
      'createdAt': now,
    });
    // Generate a new document with a unique ID
    DocumentReference documentReference = db.doc();

    // Access the auto-generated document ID
    String documentId = documentReference.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        onPopInvoked: (bool didPop){
          if(didPop){
            context.go('/drawer');
          }
          else{
            return;
          }
        },
      canPop: true,
        child: Consumer<LocationAddressProvider>(
          builder: (BuildContext context, provider, Widget? child) {
            pickupController.text = provider.address ?? "Address not available";
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0, left: 18),
                    child: Text(
                      "Food Details:",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 2.0, bottom: 20),
                              child: Text(
                                "Food Items",
                                style: GoogleFonts.inter(
                                  fontSize: 15,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, bottom: 20),
                              child: Text(
                                "Shelf Life(Hrs)",
                                style: GoogleFonts.inter(
                                  fontSize: 15,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, bottom: 20),
                              child: Text(
                                "No.of Person",
                                style: GoogleFonts.inter(
                                  fontSize: 15,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        for (int i = 0; i < rows.length; i++) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: SizedBox(
                                    height: 60,
                                    child: TextField(
                                      cursorColor: Colors.black,
                                      controller: rows[i].foodController,
                                      decoration: InputDecoration(
                                        hintText: "Food",
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: const BorderSide(
                                              color: Colors.black),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: const BorderSide(
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: SizedBox(
                                    height: 60,
                                    child: TextField(
                                      cursorColor: Colors.black,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(3),
                                      ],
                                      keyboardType: TextInputType.number,
                                      controller: rows[i].shelfLifeController,
                                      decoration: InputDecoration(
                                        hintText: "Shelf Life",
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: const BorderSide(
                                              color: Colors.black),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: const BorderSide(
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: SizedBox(
                                    height: 60,
                                    child: TextField(
                                      cursorColor: Colors.black,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(6),
                                      ],
                                      keyboardType: TextInputType.number,
                                      controller: rows[i].quantityController,
                                      decoration: InputDecoration(
                                        hintText: "Quantity",
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: const BorderSide(
                                              color: Colors.black),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: const BorderSide(
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (rows[i].isFilled()) {
                                      if (i == rows.length - 1) {
                                        rows.add(RowData());
                                      } else {
                                        rows.removeAt(i);
                                      }
                                    } else {
                                      checkAndShowDialog();
                                    }
                                  });
                                },
                                icon: Icon(rows[i].isFilled()
                                    ? Icons.remove
                                    : Icons.add),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                        ],
                        TextField(
                          cursorColor: Colors.black,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                            // Restrict to 6 digits
                          ],
                          keyboardType: TextInputType.phone,
                          controller: contactController,
                          decoration: InputDecoration(
                            hintText: "Contact Number",
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          cursorColor: Colors.black,
                          readOnly: true,
                          controller: pickupController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  context.go('/maps');
                                },
                                icon: const Icon(
                                  Icons.location_on_rounded,
                                  color: Colors.red,
                                )),
                            hintText: "Pickup location",
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(6),
                            // Restrict to 6 digits
                          ],
                          controller: pinCodeController,
                          decoration: InputDecoration(
                            hintText: "Pin Code",
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Convenient Pickup Date",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 15),
                        TextField(
                          cursorColor: Colors.black,
                          readOnly: true,
                          controller: dateController,
                          decoration: InputDecoration(
                            hintText: "Select Date",
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                          ),
                          onTap: () async {
                            _selectDate(context, dateController);
                          },
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Convenient Pickup Time",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 15),
                        TextField(
                          cursorColor: Colors.black,
                          readOnly: true,
                          controller: startTimeController,
                          decoration: InputDecoration(
                            hintText: "Start Time",
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                          ),
                          onTap: () async {
                            _selectTime(context, startTimeController);
                          },
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          cursorColor: Colors.black,
                          readOnly: true,
                          controller: endTimeController,
                          decoration: InputDecoration(
                            hintText: "End Time",
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                          ),
                          onTap: () async {
                            _selectTime(context, endTimeController);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 57,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff0E6B56),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () async {
                          if (checkAndShowDialog() && timeCheck()) {
                            // Show a loading indicator
                            showLoadingDialog();

                            // Wait for a short time
                            await Future.delayed(const Duration(seconds: 2));

                            // Hide the loading indicator
                            Navigator.of(context).pop();

                            // Create data
                            await createData();

                            // Show a SnackBar
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(seconds: 2),
                                backgroundColor: Color(0xff0E6B56),
                                content: Text('Submitted successfully.'),
                              ),
                            );

                            // Clear text fields
                            contactController.clear();
                            pickupController.clear();
                            startTimeController.clear();
                            endTimeController.clear();
                            dateController.clear();

                            // Clear text fields in dynamic rows
                            for (RowData row in rows) {
                              row.foodController.clear();
                              row.shelfLifeController.clear();
                              row.quantityController.clear();
                            }
                            await Future.delayed(const Duration(seconds: 3),
                                () {
                              context.go('/drawer');
                            });
                          }
                        },
                        child: const Text(
                          "Submit",
                          style: TextStyle(fontSize: 16,color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // Loading dialog
  void showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(
                color: Color(0xff0E6B56),
              ),
              SizedBox(width: 16),
              Text("Submitting..."),
            ],
          ),
        );
      },
    );
  }
}

class RowData {
  TextEditingController foodController = TextEditingController();
  TextEditingController shelfLifeController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  bool isFilled() {
    return foodController.text.isNotEmpty &&
        shelfLifeController.text.isNotEmpty &&
        quantityController.text.isNotEmpty;
  }
}

void showAlertDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Alert !"),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("OK",style: TextStyle(color: Colors.black),),
          ),
        ],
      );
    },
  );
}
