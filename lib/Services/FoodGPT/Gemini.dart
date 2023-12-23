import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_gemini/google_gemini.dart';

class TextOnly extends StatefulWidget {
  const TextOnly({
    super.key,
  });

  @override
  State<TextOnly> createState() => _TextOnlyState();
}

class _TextOnlyState extends State<TextOnly> {
  bool loading = false;
  List textChat = [];

  final TextEditingController _textController = TextEditingController();
  final ScrollController _controller = ScrollController();

  // Create Gemini Instance
  final gemini = GoogleGemini(
    apiKey: "AIzaSyBAz_Pg657h8xXQkKgi63fODpIChugm6E4",
  );

  @override
  void initState() {
    showCenterMessage("Welcome! ");
    super.initState();
  }

  void showCenterMessage(String message) {
    setState(() {
      textChat = [
        {
          "role": "Gemini",
          "text": message,
        }
      ];
    });
  }

  // Text only input
  void fromText({required String query}) {
    setState(() {
      loading = true;
      textChat.add({
        "role": "User",
        "text": query,
      });
      _textController.clear();
    });
    scrollToTheEnd();

    gemini.generateFromText(query).then((value) {
      setState(() {
        loading = false;
        textChat.add({
          "role": "Gemini",
          "text": value.text,
        });
      });
      scrollToTheEnd();
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
        textChat.add({
          "role": "Gemini",
          "text": error.toString(),
        });
      });
      scrollToTheEnd();
    });
  }

  void scrollToTheEnd() {
    _controller.jumpTo(_controller.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "FoodGPT",
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          backgroundColor: const Color(0xff0E6B56),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _controller,
                itemCount: textChat.length,
                padding: const EdgeInsets.only(bottom: 20),
                itemBuilder: (context, index) {
                  return ListTile(
                    isThreeLine: true,
                    leading: CircleAvatar(
                      child: Text(textChat[index]["role"].substring(0, 1)),
                    ),
                    title: Text(textChat[index]["role"]),
                    subtitle: Text(textChat[index]["text"]),
                  );
                },
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      cursorColor: Colors.grey,
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: "Ask shelf life here...",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none),
                        fillColor: Colors.red,
                      ),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                  IconButton(
                    icon: loading
                        ? const CircularProgressIndicator(color: Color(0xff0E6B56),)
                        : const Icon(Icons.send),
                    onPressed: () {
                      fromText(query: _textController.text);
                    },
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
