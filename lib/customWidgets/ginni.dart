


import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

import '../modelclass/ginni_model/message_model.dart';

class Ginni extends StatefulWidget {
  Ginni({super.key});

  @override
  State<Ginni> createState() => _GinniState();
}

class _GinniState extends State<Ginni> {
  TextEditingController messageController = TextEditingController();
  List<MessageModel> messages = []; // List to store messages

  @override
  void initState() {
    super.initState();
    // Any chat initialization logic can go here
  }

  Future<void> sendMessage(String message) async {
    if (message.isNotEmpty) {
      // Add the user's message to the list
      setState(() {
        messages.add(MessageModel(
          sender: "user",
          messageid: Uuid().v4(),
          createdon: DateTime.now(),
          text: message,
        ));
      });

      messageController.clear(); // Clear the input field

      // Send the message to Rasa and get the response
      String rasaResponse = await sendToRasa(message);

      // Add Rasa's response to the messages list
      setState(() {
        messages.add(MessageModel(
          sender: "RASA",
          messageid: Uuid().v4(),
          createdon: DateTime.now(),
          text: rasaResponse,
        ));
      });
    }
  }

  Future<String> sendToRasa(String message) async {
    final url = Uri.parse("http://192.168.249.162:5005/webhooks/rest/webhook");
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'sender': 'ginni_dialog', 'message': message}),
    );

    if (response.statusCode == 200) {
      List<dynamic> responseBody = jsonDecode(response.body);
      if (responseBody.isNotEmpty) {
        return responseBody[0]['text']; // Return Rasa's response text
      } else {
        return "No response from Ginni."; // In case of no response
      }
    } else {
      throw Exception('Failed to get response from Rasa');
    }
  }

  @override
  Widget build(BuildContext context) {
    Color closeIconColor= Colors.black;
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            // Existing Ginni UI stays here (without any changes)
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.blue
              ),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    child: Image(image: AssetImage('assets/images/icons8-doctor-48.png')),
                  ),
                  SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ginni',
                        style: TextStyle(
                          fontSize: 14,

                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Your AI Assistant',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: closeIconColor= Colors.black,
                      ),
                    ),
                    onHover: (event) {
                      setState(() {
                        closeIconColor =
                        event == true ? Colors.blue : Colors.grey;
                      });
                    },
                  ),
                ],
              ),
            ),
            // Message ListView builder
            Expanded(
              child: ListView.builder(
                // Reverse to keep latest messages at the bottom
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  MessageModel currentMessage = messages[index];
                  return currentMessage.sender == "RASA"
                      ? rasamessage(currentMessage.text, currentMessage.createdon.toString())
                      : usermessagecard(currentMessage.text, currentMessage.createdon.toString());
                },
              ),
            ),

            // Input field and send button (UI unchanged, but functionality added)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextInput("Ask something", messageController),
                  ),
                  SizedBox(width: 8),
                  SendIcon(25, () => sendMessage(messageController.text.trim())), // Added functionality
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget rasamessage(String message ,String dateandtime ){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  message, style: TextStyle(
                    fontSize: 16
                ),
                ),
              ),
            ),
          ),
          Text(dateandtime, style: TextStyle(
              color: Colors.grey,
              fontSize: 8
          ),)
        ],
      ),
    );
  }

  Widget TextInput(String hint, TextEditingController controller) {
    return Container(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFFF5F5F6)),
          ),
          fillColor: Color(0xFFF5F5F6),
          filled: true,
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget SendIcon(double radius, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: Colors.blue,
        radius: radius,
        child: Center(
          child: Icon(CupertinoIcons.paperplane_fill, color: Colors.white, size: radius * 1.2),
        ),
      ),
    );
  }

  Widget usermessagecard(String message, String dateandtime) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.blue
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              dateandtime,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
