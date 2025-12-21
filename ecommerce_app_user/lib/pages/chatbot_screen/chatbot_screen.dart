import 'package:flutter/material.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:ecommerce_app_user/constants/messages.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  DialogFlowtter? dialogFlowtter;
  final TextEditingController _textInputController = TextEditingController();

  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    DialogFlowtter.fromFile(path: "assets/dialog_flow_auth.json")
        .then((instance) {
      setState(() {
        dialogFlowtter = instance;
      });
    }).catchError((error) {
      print("Error initializing DialogFlowtter: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[500],
        title: Text(
          "Chatbot",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Messages(messages: messages),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[300], // Màu nền Messenger
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: TextField(
                        cursorColor: Colors.black,
                        controller: _textInputController,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          hintText: "Nhắn tin...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      sendMessage(_textInputController.text.trim());
                      _textInputController.clear();
                    }, // Vô hiệu hóa nút gửi khi không có tin nhắn
                    icon: const Icon(
                      Icons.send,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ), // Thêm khoảng cách giữa 2 tin nhắn
        ],
      ),
    );
  }

  sendMessage(String text) async {
    if (text.isEmpty || dialogFlowtter == null) return;
    if (dialogFlowtter == null) {
      print("DialogFlowtter chưa khởi tạo!");
      return;
    }
    // if (text.isEmpty) {
    //   print("Message is empty");
    // } else {
    setState(() {
      addMessage(
        Message(
          text: DialogText(text: [text]),
        ),
        true,
      );
    });
    try {
      DetectIntentResponse response = await dialogFlowtter!.detectIntent(
        queryInput: QueryInput(text: TextInput(text: text)),
      );

      if (response.message == null) return;

      setState(() {
        addMessage(response.message!);
      });
    } catch (e) {
      print("Error sending message: $e");
    }
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({
      "message": message,
      "isUserMessage": isUserMessage,
    });
  }
}
