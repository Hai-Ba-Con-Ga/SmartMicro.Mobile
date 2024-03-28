import 'dart:async';

import 'package:SmartMicro.Mobile/BLE/constants.dart';
import 'package:SmartMicro.Mobile/BLE/screens/device_control_screen.dart';
import 'package:chickies_ui/Colors.dart';
import 'package:chickies_ui/Components/Button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'device_screen.dart';
import '../utils/snackbar.dart';
import '../widgets/system_device_tile.dart';
import '../widgets/scan_result_tile.dart';
import '../utils/extra.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  List<BluetoothDevice> _systemDevices = [];
  List<ScanResult> _scanResults = [];
  bool _isScanning = false;
  late StreamSubscription<List<ScanResult>> _scanResultsSubscription;
  late StreamSubscription<bool> _isScanningSubscription;

  @override
  void initState() {
    super.initState();

    //add event update scan results when scan.
    _scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {
      _scanResults = results;
      if (mounted) {
        setState(() {});
      }
    }, onError: (e) {
      Snackbar.show(ABC.b, prettyException("Scan Error:", e), success: false);
    });

    _isScanningSubscription = FlutterBluePlus.isScanning.listen((state) {
      _isScanning = state;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _scanResultsSubscription.cancel();
    _isScanningSubscription.cancel();
    super.dispose();
  }

  //* on SCAN
  Future onScanPressed() async {
    try {
      _systemDevices = await FlutterBluePlus.systemDevices;
    } catch (e) {
      Snackbar.show(ABC.b, prettyException("System Devices Error:", e), success: false);
    }
    try {
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
    } catch (e) {
      Snackbar.show(ABC.b, prettyException("Start Scan Error:", e), success: false);
    }
    if (mounted) {
      setState(() {});
    }
  }

  //* on STOP SCAN
  Future onStopPressed() async {
    try {
      FlutterBluePlus.stopScan();
    } catch (e) {
      Snackbar.show(ABC.b, prettyException("Stop Scan Error:", e), success: false);
    }
  }

  //* on CONNECT <-
  Future<void> onConnectPressed(BluetoothDevice device) async {
    await device.connectAndUpdateStream().catchError((e) {
      Snackbar.show(ABC.c, prettyException("Connect Error:", e), success: false);
    });
    final _services = await device.discoverServices();
    final _uartService = _services.firstWhere((element) => element.uuid.toString().toUpperCase() == BleUUID.UART_SERVICE_UUID);
    final _rxChar = _uartService.characteristics.firstWhere((c) => c.uuid.toString().toUpperCase() == BleUUID.RX_CHARACTERISTIC_CHARACTERISTIC_UUID);
    final _txChar = _uartService.characteristics.firstWhere((c) => c.uuid.toString().toUpperCase() == BleUUID.TX_CHARACTERISTIC_CHARACTERISTIC_UUID);
    MaterialPageRoute route = MaterialPageRoute(
        builder: (context) => DeviceControlScreen(
              device: device,
              rxChar: _rxChar,
              txChar: _txChar,
            ),
        settings: RouteSettings(name: '/DeviceControlScreen'));
    // Navigator.of(context).push(route);

    final object = {'device': device, 'rxChar': _rxChar, 'txChar': _txChar};
    Navigator.of(context).pushNamed('/DeviceControlScreen', arguments: object);
  }

  //* on REFRESH
  Future onRefresh() {
    if (_isScanning == false) {
      FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
    }
    if (mounted) {
      setState(() {});
    }
    return Future.delayed(Duration(milliseconds: 500));
  }

  //* SCAN BUTTON
  Widget buildScanButton(BuildContext context) {
    if (FlutterBluePlus.isScanningNow) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        child: ChickiesButton(
          backgroundColor: ChickiesColor.blue,
          text: 'Scanning...',
          onPressed: onStopPressed,
          // style: ElevatedButton.styleFrom(backgroundColor: ChickiesColor.purple, foregroundColor: Colors.white),
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        child: ChickiesButton(
          text: 'Scan for Devices',
          onPressed: onScanPressed,
          // style: ElevatedButton.styleFrom(backgroundColor: ChickiesColor.purple, foregroundColor: Colors.white),
        ),
      );
    }
  }

  //* List of System Devices
  // List<Widget> _buildSystemDeviceTiles(BuildContext context) {
  //   return _systemDevices
  //       .map(
  //         (d) => SystemDeviceTile(
  //           device: d,
  //           onOpen: () => Navigator.of(context).push(
  //             MaterialPageRoute(
  //               builder: (context) => DeviceControlScreen(device: d),
  //               settings: RouteSettings(name: '/DeviceControlScreen'),
  //             ),
  //           ),
  //           onConnect: () => onConnectPressed(d),
  //         ),
  //       )
  //       .toList();
  // }

  //* List of Scan Results
  List<Widget> _buildScanResultTiles(BuildContext context) {
    return _scanResults
        .map(
          (r) => ScanResultTile(
            result: r,
            onTap: () => onConnectPressed(r.device),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: Snackbar.snackBarKeyB,
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: ChickiesColor.background,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: ChickiesColor.background),
            onPressed: () {
              // Navigator.pop(context);
            },
          ),
          leadingWidth: 0,
          title: Text("Find Devices", style: TextStyle(color: ChickiesColor.primary, fontSize: 30)),
          // Image.asset(
          //   'assets/images/chickies_logo2.png',
          //   height: 80,
          // ),
          excludeHeaderSemantics: false,
          // toolbarHeight: 90,
          // centerTitle: true,
          backgroundColor: Colors.transparent,
          foregroundColor: ChickiesColor.primary,
          elevation: 0,
        ),
        body: RefreshIndicator(
          onRefresh: onRefresh,
          child: ListView(
            children: <Widget>[
              // buildScanButton(context),
              // ..._buildSystemDeviceTiles(context),
              ..._buildScanResultTiles(context),
            ],
          ),
        ),
        floatingActionButton: buildScanButton(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
