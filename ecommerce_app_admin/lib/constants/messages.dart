import 'package:flutter/material.dart';

class Messages extends StatefulWidget {
  final List messages;
  const Messages({super.key, required this.messages});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return ListView.separated(
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Row(
            mainAxisAlignment: widget.messages[index]['isUserMessage']
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            children: [
              if (!widget.messages[index]['isUserMessage'])
                const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/chatbot.png"),
                  radius: 16,
                ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(18),
                    topRight: const Radius.circular(18),
                    bottomRight: Radius.circular(
                      widget.messages[index]["isUserMessage"] ? 4 : 18,
                    ),
                    bottomLeft: Radius.circular(
                      widget.messages[index]["isUserMessage"] ? 18 : 4,
                    ),
                  ),
                  color: widget.messages[index]["isUserMessage"]
                      ? Colors.blue[600]
                      : Colors.grey[300],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                constraints: BoxConstraints(maxWidth: w * 0.7),
                child: Text(
                  widget.messages[index]["message"].text.text[0],
                  style: TextStyle(
                    color: widget.messages[index]["isUserMessage"]
                        ? Colors.white
                        : Colors.black87,
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
        );
      },
      separatorBuilder: (_, i) => const Padding(
        padding: EdgeInsets.only(top: 10),
      ),
      itemCount: widget.messages.length,
    );
  }
}
