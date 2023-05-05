import 'package:flutter/material.dart';

import 'component/main_body.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF070713),
        body: MainBody(),
      ),
    );
  }
}
