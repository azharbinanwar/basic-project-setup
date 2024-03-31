import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:basic_project_template/core/extensions/widget_extension.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Text('Welcome to iDoc').center(),
    );
  }
}
