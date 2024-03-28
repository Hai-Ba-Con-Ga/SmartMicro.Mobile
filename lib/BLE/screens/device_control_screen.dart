import 'dart:async';

import 'package:SmartMicro.Mobile/BLE/constants.dart';
import 'package:chickies_ui/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:collection/collection.dart'; // You have to add this manually, for some reason it cannot be added automatically

import '../widgets/service_tile.dart';
import '../widgets/characteristic_tile.dart';
import '../widgets/descriptor_tile.dart';
import '../utils/snackbar.dart';
import '../utils/extra.dart';

class DeviceControlScreen extends StatefulWidget {
  final BluetoothDevice device;

  const DeviceControlScreen({Key? key, required this.device}) : super(key: key);

  @override
  State<DeviceControlScreen> createState() => _DeviceControlScreenState();
}

class _DeviceControlScreenState extends State<DeviceControlScreen> {
  BluetoothConnectionState _connectionState = BluetoothConnectionState.disconnected;
  List<BluetoothService> _services = [];
  bool _isConnecting = false;
  bool _isDisconnecting = false;

  late StreamSubscription<BluetoothConnectionState> _connectionStateSubscription;
  late StreamSubscription<bool> _isConnectingSubscription;
  late StreamSubscription<bool> _isDisconnectingSubscription;

  BluetoothService? _uartService;
  BluetoothCharacteristic? _uartRxCharacteristic;
  BluetoothCharacteristic? _uartTxCharacteristic;

  //* init state
  @override
  void initState() {
    super.initState();

    //up services + rssi when connected
    _connectionStateSubscription = widget.device.connectionState.listen((state) async {
      _connectionState = state;
      if (state == BluetoothConnectionState.connected) {
        _services = []; // must rediscover services
        _services = await widget.device.discoverServices();
      }
      if (mounted) {
        setState(() {});
      }
    });

    _isConnectingSubscription = widget.device.isConnecting.listen((value) {
      _isConnecting = value;
      if (mounted) {
        setState(() {});
      }
    });

    _isDisconnectingSubscription = widget.device.isDisconnecting.listen((value) {
      _isDisconnecting = value;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _connectionStateSubscription.cancel();
    _isConnectingSubscription.cancel();
    _isDisconnectingSubscription.cancel();
    super.dispose();
  }

  bool get isConnected {
    return _connectionState == BluetoothConnectionState.connected;
  }

  Future onConnectPressed() async {
    try {
      await widget.device.connectAndUpdateStream();
      _services = await widget.device.discoverServices();
      Snackbar.show(ABC.c, "Connect: Success", success: true);
    } catch (e) {
      if (e is FlutterBluePlusException && e.code == FbpErrorCode.connectionCanceled.index) {
        // ignore connections canceled by the user
      } else {
        Snackbar.show(ABC.c, prettyException("Connect Error:", e), success: false);
      }
    }
  }

  Future onCancelPressed() async {
    try {
      await widget.device.disconnectAndUpdateStream(queue: false);
      Snackbar.show(ABC.c, "Cancel: Success", success: true);
    } catch (e) {
      Snackbar.show(ABC.c, prettyException("Cancel Error:", e), success: false);
    }
  }

  Future onDisconnectPressed() async {
    try {
      await widget.device.disconnectAndUpdateStream();
      Snackbar.show(ABC.c, "Disconnect: Success", success: true);
    } catch (e) {
      Snackbar.show(ABC.c, prettyException("Disconnect Error:", e), success: false);
    }
  }

  List<Widget> _buildServiceTiles(BuildContext context, BluetoothDevice d) {
    return _services
        .map(
          (s) => ServiceTile(
            service: s,
            characteristicTiles: s.characteristics.map((c) => _buildCharacteristicTile(c)).toList(),
          ),
        )
        .toList();
  }

  Future onWritePressed(BluetoothCharacteristic char, {String? message}) async {
    print(message == null ? BleData().getRandomBytes() : BleData().stringToBytes(message));
    try {
      await char.write(
        message == null ? BleData().getRandomBytes() : BleData().stringToBytes(message),
        withoutResponse: char.properties.writeWithoutResponse,
      );
      Snackbar.show(ABC.c, "Write: Success", success: true);
      if (char.properties.read) {
        await char.read();
      }
    } catch (e) {
      Snackbar.show(ABC.c, prettyException("Write Error:", e), success: false);
    }
  }

  Widget _uartServiceTiles(BuildContext context, BluetoothDevice d) {
    _uartService = _services.firstWhereOrNull((element) => element.uuid.toString().toUpperCase() == BleUUID.UART_SERVICE_UUID);
    //test
    // if (_services.isNotEmpty) {
    //   _uartService = _services.last;
    // }
    if (_uartService == null) {
      return Container(child: Text("UART Service not found:"));
    }

    BluetoothCharacteristic? rxChar = _uartService!.characteristics.firstWhereOrNull(
      (c) => c.uuid.toString().toUpperCase() == BleUUID.RX_CHARACTERISTIC_CHARACTERISTIC_UUID,
    );

    //test
    // if (_services.isNotEmpty) {
    //   rxChar = _uartService!.characteristics.first;
    // }

    if (rxChar == null) {
      return Container(child: Text("UART RxChar not found"));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            ElevatedButton(onPressed: () => {onWritePressed(rxChar, message: BleData().mapping(MessageData.open))}, child: Text("Open")),
            ElevatedButton(onPressed: () => {onWritePressed(rxChar, message: BleData().mapping(MessageData.close))}, child: Text("Close")),
          ],
        ),
        Column(
          children: [
            ElevatedButton(onPressed: () => {onWritePressed(rxChar, message: BleData().mapping(MessageData.on))}, child: Text("on")),
            ElevatedButton(onPressed: () => {onWritePressed(rxChar, message: BleData().mapping(MessageData.off))}, child: Text("off")),
          ],
        )
      ],
    );
  }

  CharacteristicTile _buildCharacteristicTile(BluetoothCharacteristic c) {
    return CharacteristicTile(
      characteristic: c,
      descriptorTiles: c.descriptors.map((d) => DescriptorTile(descriptor: d)).toList(),
    );
  }

  Widget buildSpinner(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: CircularProgressIndicator(
          backgroundColor: Colors.black12,
          color: Colors.black26,
        ),
      ),
    );
  }

  Widget buildRemoteId(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('${widget.device.remoteId}'),
    );
  }

  Widget buildConnectButton(BuildContext context) {
    return Row(children: [
      if (_isConnecting || _isDisconnecting) buildSpinner(context),
      TextButton(
          onPressed: _isConnecting ? onCancelPressed : (isConnected ? onDisconnectPressed : onConnectPressed),
          child: Text(
            _isConnecting ? "CANCEL" : (isConnected ? "DISCONNECT" : "CONNECT"),
            style: Theme.of(context).primaryTextTheme.labelLarge?.copyWith(color: ChickiesColor.purple),
          ))
    ]);
  }

  //* BUILD
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: Snackbar.snackBarKeyC,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.device.platformName),
          actions: [buildConnectButton(context)],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                buildRemoteId(context),
                ..._buildServiceTiles(context, widget.device),
                _uartServiceTiles(context, widget.device),
              ],
            ),
          ),
        ),
      ),
    );
  }
}