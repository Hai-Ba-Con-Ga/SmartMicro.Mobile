import 'package:SmartMicro.Mobile/api/client.dart';
import 'package:SmartMicro.Mobile/api/shared_prefs.dart';
import 'package:SmartMicro.Mobile/data/device.dart';
import 'package:SmartMicro.Mobile/screens/navigator_bar.dart';
import 'package:SmartMicro.Mobile/screens/voice/bloc/voice_bloc.dart';
import 'package:SmartMicro.Mobile/screens/voice/test_widget.dart';
import 'package:SmartMicro.Mobile/screens/welcome_screen.dart';
import 'package:chickies_ui/Colors.dart';
import 'package:chickies_ui/Components/Button/button.dart';
import 'package:chickies_ui/Components/Container/rounded_container.dart';
import 'package:chickies_ui/chickies_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  String username = 'Username';
  List<Device> devices = [];

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future _init() async {
    final res = await SharedPrefs.getString('username') ?? 'Username';
    setState(() {
      username = res.split('@').first;
    });
    final response = await APIClient().getDevicesByOwnerId(await SharedPrefs.getInt('userId') ?? 0);
    if (response.isNotEmpty) {
      setState(() {
        devices = response;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ChickiesColor.background,
      body: RefreshIndicator(
        onRefresh: () async {
          await _init();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 40),
              Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RoundedContainer(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.width * 0.5,
                    margin: const EdgeInsets.all(0),
                    decoration: const BoxDecoration(
                      color: ChickiesColor.primary,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    // padding: const EdgeInsets.all(0),
                    child: Center(child: Icon(Icons.person, size: 40, color: ChickiesColor.black.withOpacity(0.3))),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.width * 0.5,
                    width: MediaQuery.of(context).size.width * 0.5,
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              //* Setting button
                              RoundedContainer(
                                child: IntrinsicWidth(child: IconButton(onPressed: () {}, icon: Icon(Icons.settings))),
                                padding: const EdgeInsets.all(0),
                                margin: const EdgeInsets.all(10),
                              ),
                              //* logout button
                              RoundedContainer(
                                child: IntrinsicWidth(
                                    child: IconButton(
                                        onPressed: () {
                                          SharedPrefs.clear();
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(builder: (context) => WelcomeScreen()),
                                            (route) => false,
                                          );
                                        },
                                        icon: Icon(Icons.exit_to_app))),
                                padding: const EdgeInsets.all(0),
                                margin: const EdgeInsets.all(10),
                              ),
                            ],
                          ),
                        ),
                        Text(username, style: TextStyle(fontSize: 25, color: ChickiesColor.black), overflow: TextOverflow.ellipsis, maxLines: 3, textAlign: TextAlign.left),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(left: 20),
                  child: Text("Devices", style: TextStyle(fontSize: 25, color: ChickiesColor.black), overflow: TextOverflow.ellipsis, maxLines: 3, textAlign: TextAlign.left)),
              ...List.generate(
                devices.length,
                (index) => CardSwipe(
                  height: 120,
                  width: 60,
                  onPressed: () {
                    print('delete');
                  },
                  child: RoundedContainer(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 100,
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          margin: const EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                            color: ChickiesColor.primary.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(child: Icon(Icons.devices_other_sharp, size: 30, color: ChickiesColor.black.withOpacity(0.3))),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(devices[index].serialId.toString(),
                                style: TextStyle(fontSize: 20, color: ChickiesColor.grey2), overflow: TextOverflow.ellipsis, maxLines: 3, textAlign: TextAlign.left),
                            Text(devices[index].deviceName.toString(),
                                style: TextStyle(fontSize: 20, color: ChickiesColor.grey2), overflow: TextOverflow.ellipsis, maxLines: 3, textAlign: TextAlign.left),
                            Text("Create: " + DateFormat('hh:mm - yy/MM/dd').format(devices[index].createdDate ?? DateTime.now()),
                                style: TextStyle(fontSize: 15, color: ChickiesColor.black), overflow: TextOverflow.ellipsis, maxLines: 3, textAlign: TextAlign.left),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              //* button create device
              GestureDetector(
                onTap: () async {
                  await createDevice('-123123', 'BLE');
                },
                child: RoundedContainer(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 70,
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        margin: const EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          color: ChickiesColor.primary.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(child: Icon(Icons.add, size: 30, color: ChickiesColor.black.withOpacity(0.3))),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Create new device", style: TextStyle(fontSize: 20, color: ChickiesColor.grey2), overflow: TextOverflow.ellipsis, maxLines: 3, textAlign: TextAlign.left),
                          Text("Create new device", style: TextStyle(fontSize: 15, color: ChickiesColor.black), overflow: TextOverflow.ellipsis, maxLines: 3, textAlign: TextAlign.left),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future createDevice(String serialId, String deviceName) async {
    print('create new device');

    final newDevices = await APIClient().getDevicesByOwnerId(await SharedPrefs.getInt('userId') ?? 0);
    final isExist = newDevices.any((element) => element.serialId == serialId);

    if (isExist) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Device already exist'),
          content: Text('This device already exist in your account'),
          actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))],
        ),
      );
      return;
    }

    final userId = await SharedPrefs.getInt('userId');
    final response = await APIClient().createDevice(Device(
      serialId: serialId,
      ownerId: userId,
      deviceTypeId: 2,
      deviceName: 'Device 1',
      createdDate: DateTime.now(),
    ));
    if (response) {

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Create new device'),
          content: Text('Create new device success'),
          actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))],
        ),
      );

      final res = await APIClient().getDevices();
      if (res.isNotEmpty) {
        setState(() {
          devices = res;
        });
      }
    }
  }

  Future deleteDevice(int id) async {
    final response = await APIClient().deleteDevice(id);
    if (response) {
      final res = await APIClient().getDevices();
      if (res.isNotEmpty) {
        setState(() {
          devices = res;
        });
      }
    }
  }
}
