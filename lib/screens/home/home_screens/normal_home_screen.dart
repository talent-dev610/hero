import 'package:flutter/material.dart';
import 'package:hero/widgets/top_appBar.dart';

class NormalHomeScreen extends StatelessWidget {
  const NormalHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopAppBar(title: 'Stingrays'),
        body: Center(child: Text('peepee poopoo')));
  }
}
