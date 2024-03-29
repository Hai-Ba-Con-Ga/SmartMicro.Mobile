import 'package:SmartMicro.Mobile/data/collected_data.dart';
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
  final hubConnection = HubConnectionBuilder()
      .withHubProtocol(JsonHubProtocol())
      .withUrl(
        'https://iot.wyvernp.id.vn/hubs/data-report?searialId=-1946710095',
        transportType: HttpTransportType.WebSockets,
      )
      .build();

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
    final user = arguments![0] as CollectedData;

    setState(() {
      messages.add('${user.dataValue} - ${user.dataUnit} - ${user.createdDate}');
    }
    );
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
            // Text("123"),
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(index.toString() + messages[index]),
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
                  // IconButton(
                  //   icon: Icon(Icons.send),
                  //   onPressed: _sendMessage,
                  // ),
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
