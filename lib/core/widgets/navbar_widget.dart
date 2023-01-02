import 'package:flutter/material.dart';

class BaseScaffoldWidget extends StatefulWidget {
  final List<Widget> navItems;
  final Widget body;
  final String title;
  const BaseScaffoldWidget(
      {super.key,
      required this.navItems,
      required this.title,
      required this.body});

  @override
  State<BaseScaffoldWidget> createState() => _BaseScaffoldWidgetState();
}

class _BaseScaffoldWidgetState extends State<BaseScaffoldWidget> {
  @override
  Widget build(BuildContext context) {
    bool mobile = MediaQuery.of(context).size.width > 700 ? false : true;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontStyle: FontStyle.italic),
        ),
        actions: mobile ? null : widget.navItems,
      ),
      drawer: mobile
          ? Drawer(
              child: ListView(
                children: widget.navItems,
              ),
            )
          : null,
      body: widget.body,
    );
  }
}
