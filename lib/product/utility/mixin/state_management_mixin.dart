import 'package:flutter/material.dart';

mixin StateManagementMixin<T extends StatefulWidget> on State<T> {
  bool isLoading = false;

  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  void setLoading(bool value) {
    if (isLoading != value) {
      setState(() {
        isLoading = value;
      });
    }
  }
}
