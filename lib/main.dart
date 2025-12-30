import 'package:flutter/material.dart';

import 'core/constants/app_constants.dart';
import 'core/init/theme/app_theme.dart';
import 'feature/home/view/home_view.dart';

void main() {
  runApp(const TradeMasterApp());
}

class TradeMasterApp extends StatelessWidget {
  const TradeMasterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ApplicationConstants.appName,
      theme: AppTheme.darkTheme,
      home: const HomeView(),
    );
  }
}
