import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget _child;

  AppScaffold.drawer({
    super.key,
    final Widget? title,
    final Widget? body,
    final Widget? drawer,
    final Widget? floatingActionButton,
    final List<Widget> actions = const [],
    final double? toolbarHeight,
    final Color? backgroundColor,
    final bool? automaticallyImplyLeading,
  }) : _child = _AppScaffoldWithSideDrawer(
          title: title,
          body: body,
          drawer: drawer,
          floatingActionButton: floatingActionButton,
          actions: actions,
          toolbarHeight: toolbarHeight,
          backgroundColor: backgroundColor,
          automaticallyImplyLeading: automaticallyImplyLeading,
        );

  @override
  Widget build(BuildContext context) {
    return _child;
  }
}

class _AppScaffoldWithSideDrawer extends StatelessWidget {
  final Widget? title;
  final Widget? body;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final List<Widget> actions;
  final double? toolbarHeight;
  final Color? backgroundColor;
  final bool automaticallyImplyLeading;

  const _AppScaffoldWithSideDrawer({
    this.title,
    this.body,
    this.drawer,
    this.floatingActionButton,
    this.actions = const [],
    this.toolbarHeight = kToolbarHeight,
    this.backgroundColor,
    final bool? automaticallyImplyLeading,
  }) : automaticallyImplyLeading = automaticallyImplyLeading ?? true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: automaticallyImplyLeading,
        backgroundColor: backgroundColor,
        toolbarHeight: toolbarHeight,
        actions: actions,
        title: title,
      ),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
