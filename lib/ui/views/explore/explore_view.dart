import 'package:flutter/material.dart';
import 'package:quickk/ui/common/app_data.dart';
import 'package:stacked/stacked.dart';
import '../../common/app_colors.dart';
import 'explore_viewmodel.dart';

class ExploreView extends StackedView<ExploreViewModel> {
  final ExploreCard data;
  const ExploreView({Key? key, required this.data}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ExploreViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: kcBackgroundColor,
      appBar: AppBar(
        backgroundColor: kcBackgroundColor,
        title: Text(data.title),
      ),
      body: SafeArea(
          child: ListView(
        children: [
          Container(
              margin: const EdgeInsets.all(20),
              height: 400,
              width: double.infinity,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 1),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () =>
                      viewModel.launchInApp(data.exploredata[index].url),
                  child: Column(children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              colors: [
                                Colors.black,
                                data.exploredata[index].viewcolor
                              ],
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft)),
                      height: 50,
                      width: 50,
                      child: Icon(data.cardicon),
                    ),
                    Text(data.exploredata[index].urltitle)
                  ]),
                ),
                itemCount: data.exploredata.length,
              ))
        ],
      )),
    );
  }

  @override
  ExploreViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ExploreViewModel();
}
