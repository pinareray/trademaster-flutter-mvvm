import 'package:flutter/material.dart';

abstract class BaseView<T extends StatefulWidget> extends State<T> {
  @override
  void initState() {
    super.initState();
    onPageLoad();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onViewModelReady();
    });
  }

  @override
  void dispose() {
    onDispose();
    super.dispose();
  }

  /// Called when the page is first loaded (before build)
  void onPageLoad() {}

  /// Called after the first frame is rendered
  void onViewModelReady() {}

  /// Called when the widget is disposed
  void onDispose() {}
}
