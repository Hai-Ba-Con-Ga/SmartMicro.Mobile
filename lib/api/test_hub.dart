import 'package:SmartMicro.Mobile/screens/voice/bloc/voice_bloc.dart';
import 'package:chickies_ui/Colors.dart';
import 'package:chickies_ui/Components/Button/button.dart';
import 'package:chickies_ui/Components/Container/rounded_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signalr_netcore/json_hub_protocol.dart';
import 'package:signalr_netcore/signalr_client.dart';

class TestHub extends StatefulWidget {
  const TestHub({super.key});

  @override
  State<TestHub> createState() => _TestHubState();
}

class _TestHubState extends State<TestHub> {
  final hubConnection = HubConnectionBuilder().withHubProtocol(JsonHubProtocol()).withUrl('https://iot.wyvernp.id.vn/hubs/data-report').build();

  TextEditingController messageController = TextEditingController();
  List<String> messages = [];

  @override
  void initState() {
    super.initState();
    _startHubConnection();

    // Define an event handler for receiving messages
    hubConnection.on('ReceiveDataReport', _handleReceivedMessage);
  }

  void _startHubConnection() async {
    try {
      await hubConnection.start();
      print('SignalR connection started.');
    } catch (e) {
      print('Error starting SignalR connection: $e');
    }
  }

  void _handleReceivedMessage(List<Object?>? arguments) {
    print('Received message: $arguments');
    String user = arguments?[0] as String;
    String message = arguments?[1] as String;

    setState(() {
      messages.add('$user: $message');
    });
  }

  void _sendMessage() {
    String user = 'You'; // Replace with the user's name or identifier
    String message = messageController.text;

    // Send the message to the SignalR hub
    hubConnection.invoke('SendMessage', args: [user, message]);

    // Clear the text input field
    messageController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Chat with SignalR'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(messages[index]),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: 'Enter your message',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Ensure that the SignalR connection is closed when the app is disposed
    hubConnection.stop();
    super.dispose();
  }
}
