import 'package:SmartMicro.Mobile/api/test_hub.dart';
import 'package:SmartMicro.Mobile/data/collected_data.dart';
import 'package:SmartMicro.Mobile/screens/voice/bloc/voice_bloc.dart';
import 'package:chickies_ui/Colors.dart';
import 'package:chickies_ui/Components/Button/button.dart';
import 'package:chickies_ui/Components/Container/rounded_container.dart';
import 'package:chickies_ui/chickies_ui.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:signalr_netcore/json_hub_protocol.dart';
import 'package:signalr_netcore/signalr_client.dart';

class _TemperatureChart extends StatefulWidget {
  const _TemperatureChart();

  @override
  State<_TemperatureChart> createState() => _TemperatureChartState();
}

class _TemperatureChartState extends State<_TemperatureChart> {
  final hubConnection = HubConnectionBuilder()
      .withHubProtocol(JsonHubProtocol())
      .withUrl(
        'https://iot.wyvernp.id.vn/hubs/data-report?searialId=-1946710095',
        transportType: HttpTransportType.WebSockets,
      )
      .build();

  TextEditingController messageController = TextEditingController();
  List<CollectedData> messages = [];

  final MAX_X = 20;

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
    final user = CollectedData.fromJson(arguments![0] as Map<String, dynamic>);
    if ((user.collectedDataTypeId ?? 0) != 1) {
      return;
    }

    print(user.dataValue);

    if (messages.length > MAX_X) {
      messages = messages.sublist(0, MAX_X);
    }

    setState(() {
      if (messages.length == 0)
        messages = [user];
      else
        messages = [user, ...messages];
    });
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      sampleData1,
      duration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 0,
        maxX: MAX_X.toDouble(),
        maxY: 5,
        minY: 0,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        // lineChartBarData1_1,
        // lineChartBarData1_2,
        lineChartBarData1_3,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10°';
      case 2:
        text = '20°';
      case 3:
        text = '30°';
      case 4:
        text = '40°';
      case 5:
        text = '50°';
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;

    //messages -> 20 phan tu
    var first = '';
    if (messages.length >= 20) {
      first = DateFormat('HH:mm:ss').format(messages[19].createdDate?.add(Duration(hours: 7)) ?? DateTime.now());
    }

    var middle = '';
    if (messages.length >= 11) {
      middle = DateFormat('HH:mm:ss').format(messages[10].createdDate?.add(Duration(hours: 7)) ?? DateTime.now());
    }

    var last = '';
    if (messages.length >= 1) {
      last = DateFormat('HH:mm:ss').format(messages.first.createdDate?.add(Duration(hours: 7)) ?? DateTime.now());
    }

    switch (value.toInt()) {
      case 0:
        text = Text(first);
        break;
      case 10:
        text = Text(middle);
        break;
      case 20:
        text = Text(last);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => const FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: ChickiesColor.primary.withOpacity(0.2), width: 4),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData1_3 => LineChartBarData(
        isCurved: true,
        color: ChickiesColor.blue,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: messages.length != 0
            ? messages.map((e) => FlSpot(MAX_X - messages.indexOf(e).toDouble(), int.parse(e.dataValue ?? "10") / 10)).toList()
            : [
                FlSpot(20, 3),
              ],
        //     [
        //   FlSpot(1, 2.8),
        //   FlSpot(3, 1.9),
        //   FlSpot(6, 5),
        //   FlSpot(10, 1.3),
        //   FlSpot(13, 2.5),
        // ],
      );
}

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<StatefulWidget> createState() => ChartScreenState();
}

class ChartScreenState extends State<ChartScreen> {
  @override
  Widget build(BuildContext context) {
    return ChickiesTopBar(
      tabs: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(right: 30, left: 10, top: 10, bottom: 10),
            child: AspectRatio(
              aspectRatio: 1 / 1.5,
              child: _TemperatureChart(),
            ),
          ),
        ),
        TestHub(),
      ],
      titles: const ['NHIỆT ĐỘ', 'ÁNH SÁNG'],
      title: 'CHART',
    );
  }
}
