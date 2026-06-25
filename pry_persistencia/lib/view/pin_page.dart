import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import '../core/widgets/custom_app_bar.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_styles.dart';
import '../core/theme/app_theme.dart';
import '../core/widgets/custom_text.dart';
import '../core/widgets/custom_icon.dart';
import '../core/widgets/custom_card.dart';
import '../core/widgets/custom_button.dart';
import '../core/widgets/custom_elevated_button.dart';
import '../viewmodel/pin_viewmodel.dart';

class PinPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PinPageState();

}

class _PinPageState extends State<PinPage>{
  @override
  void initState() {
    super.initState();
    Future.microtask((){
      context.read<PinViewModel>().loadPin();
    });
  }

  @override
  Widget build(BuildContext context) {

    final viewModel = context.watch<PinViewModel>();
    return Scaffold();
  }
}
