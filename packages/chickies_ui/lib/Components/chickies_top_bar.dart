import 'package:chickies_ui/Colors.dart';
import 'package:flutter/material.dart';

class ChickiesTopBar extends StatefulWidget {
  const ChickiesTopBar({
    super.key,
    required this.tabs,
    required this.titles,
    required this.title,
  });

  final List<Widget> tabs;
  final List<String> titles;
  final String title;

  @override
  State<ChickiesTopBar> createState() => _ChickiesTopBarState();
}

class _ChickiesTopBarState extends State<ChickiesTopBar> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ChickiesColor.white,
          elevation: 0,
          toolbarHeight: 50,
          title: Text(
            widget.title,
            style: TextStyle(
              color: ChickiesColor.grey2,
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width * 60 / 100,
              decoration: BoxDecoration(
                color: ChickiesColor.grey,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: TabBar(
                dividerColor: ChickiesColor.transparent,
                controller: _tabController,
                padding: EdgeInsets.all(4),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: ChickiesColor.primary,
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: ChickiesColor.white,
                unselectedLabelColor: ChickiesColor.grey2,
                tabs: widget.titles.map((e) => Tab(text: e)).toList(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: widget.tabs.map((e) => e).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
