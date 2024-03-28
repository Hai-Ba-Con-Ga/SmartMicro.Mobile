
// // Import the library.
// import 'package:signalr_netcore/signalr_client.dart';

// // The location of the SignalR Server.
// final serverUrl = "192.168.10.50:51001";
// // Creates the connection by using the HubConnectionBuilder.
// final hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();

// class hubClient {
//   // Start the connection.
//   Future<void> startConnection() async {
//     await hubConnection.start();
//   }

//   // Invoke the method on the server.
//   Future<void> invokeMethod(String methodName, List<dynamic> args) async {
//     await hubConnection.invoke(methodName, args);
//   }

//   // Register a method on the client.
//   void registerMethod(String methodName, Function(List<dynamic>) method) {
//     hubConnection.on(methodName, method);
//   }
//   // When the connection is closed, print out a message to the console.
//   final hubConnection.onclose( (error) => print("Connection Closed"));
// }