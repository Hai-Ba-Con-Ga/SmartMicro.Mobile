import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

void main() {
  final value = BleData().stringToBytes("open#");

  final value2 = "open#".codeUnits;
  print(value2.join(''));
  Uint8List value3 = Uint8List.fromList(value2);
  // hex
  print(value.map((e) => e.toRadixString(16)).toList());
}

class BleUUID {
  static const String UART_SERVICE_UUID = "6E400001-B5A3-F393-E0A9-E50E24DCCA9E";
  static const String TX_CHARACTERISTIC_CHARACTERISTIC_UUID = "6E400002-B5A3-F393-E0A9-E50E24DCCA9E";
  static const String RX_CHARACTERISTIC_CHARACTERISTIC_UUID = "6E400003-B5A3-F393-E0A9-E50E24DCCA9E";
}

class BleData {

  static const String ON = "on#";
  static const String OFF = "off#";
  static const String OPEN = "open#";
  static const String CLOSE = "close#";
  static const String SERIAL = "serial#";

  String mapping(MessageData data) {
    switch (data) {
      case MessageData.on:
        return ON;
      case MessageData.off:
        return OFF;
      case MessageData.open:
        return OPEN;
      case MessageData.close:
        return CLOSE;
      default:
        return "";
    }
  }

  List<int> stringToBytes(String inputString) {
    List<int> intList = [];
    Uint8List bytes = utf8.encode(inputString);
    for (int byte in bytes) {
      intList.add(byte);
    }
    return intList;
  }

  String bytesToString(List<int> bytes) {
    return utf8.decode(bytes);
  }

  List<int> getRandomBytes() {
    final math = Random();
    return [math.nextInt(255), math.nextInt(255), math.nextInt(255), math.nextInt(255)];
  }
}

enum MessageData { on, off, close, open, serial}
