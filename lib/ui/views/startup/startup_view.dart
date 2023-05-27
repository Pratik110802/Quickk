import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:quickk/ui/common/app_colors.dart';
import 'package:quickk/ui/common/ui_helpers.dart';

import 'package:stacked/stacked.dart';

import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: kcBackgroundColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Quickk',
              style: TextStyle(
                color: kcLightGrey,
                fontSize: 40,
                fontWeight: FontWeight.w400,
              ),
            ),
            verticalSpaceLarge,
            SizedBox(
                height: 300,
                width: double.infinity,
                child: LottieBuilder.asset("assets/lottie/rocket.json")),
            verticalSpaceMedium,
            const Opacity(
                opacity: 0.5,
                child: Text(
                  'Made with ❤️ by itspratikpatil',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w200),
                ))
          ],
        ),
      ),
    );
  }

  @override
  StartupViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      StartupViewModel();

  @override
  void onViewModelReady(StartupViewModel viewModel) => SchedulerBinding.instance
      .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic());
}
