import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'gptModel.dart';


class ChatGptScreen extends StatefulWidget {
  const ChatGptScreen({super.key});

  @override
  State<ChatGptScreen> createState() => _ChatGptScreenState();
}

class _ChatGptScreenState extends State<ChatGptScreen> {
  TextEditingController messageController = TextEditingController();
  List<MessageModel> messageList = [];
  bool inProgress = false;

  //initialize openai
  final openAI = OpenAI.instance.build(
      token: "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",
      baseOption: HttpSetup(receiveTimeout: 30000),
      isLogger: true);

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0E6B56),
        title: const Center(child: Text("Food GPT")),
      ),
      body: Column(
        children: [
          Expanded(
              child: messageList.isEmpty
                  ? const Center(
                child: Text(
                  "Get shelf life details here...",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18,),
                ),
              )
                  : buildMessageListWidget()),
          if (inProgress)
            const LinearProgressIndicator(
              minHeight: 2,
            ),
          buildSendWidget(),
        ],
      ),
    );
  }

  Widget buildMessageListWidget() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return buildSingleMessageRow(messageList[index]);
      },
      reverse: true,
      itemCount: messageList.length,
    );
  }

  Widget buildSingleMessageRow(MessageModel messageModel) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Align(
        alignment:
        messageModel.sentByMe ? Alignment.topRight : Alignment.topLeft,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: messageModel.sentByMe
                  ? const Color(0xff0E6B56)
                  : Colors.black
            ),
            padding: const EdgeInsets.all(10),
            child: Text(
              messageModel.message,
              style: const TextStyle(
                fontSize: 16,color: Colors.white
              ),
            )),
      ),
    );
  }

  Widget buildSendWidget() {
    return Container(
      color: Colors.white,
      height: 60,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
              child: TextField(
                cursorColor: const Color(0xff0E6B56),
                controller: messageController,
                decoration: const InputDecoration(
                  hintText: "How can i help you?",
                  border: InputBorder.none,
                ),
              )),
          const SizedBox(
            width: 16,
          ),
          FloatingActionButton(
            backgroundColor: const Color(0xff0E6B56),
            onPressed: () {
              String question = messageController.text.toString();
              if (question.isEmpty) return;
              messageController.clear();
              addMessageToMessageList(question, true);
              sendMessageToAPI(question);
            },
            elevation: 0,
            child: const Icon(
              Icons.send,
              size: 18,color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void sendMessageToAPI(String question) async {
    //send to OPENAI API

    setState(() {
      inProgress = true;
    });

    final request = CompleteText(
      prompt: question,
      model: kTranslateModelV3,
      maxTokens: 4000,
    );
    try {
      final response = await openAI.onCompleteText(request: request);
      String answer = response?.choices.last.text.trim() ?? "";
      addMessageToMessageList(answer, false);
    } catch (e) {
      addMessageToMessageList("Failed to get response please try again", false);
    }

    setState(() {
      inProgress = false;
    });
  }

  void addMessageToMessageList(String message, bool sentByMe) {
    setState(() {
      messageList.insert(0, MessageModel(message: message, sentByMe: sentByMe));
    });
  }
}