import 'package:flutter/material.dart';
import 'package:quickk/ui/common/app_colors.dart';
import 'package:quickk/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import 'addscreen_viewmodel.dart';

class AddscreenView extends StackedView<AddscreenViewModel> {
  final String url;
  const AddscreenView({Key? key, required this.url}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AddscreenViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: kcDarkGreyColor,
      appBar: AppBar(
        title: const Text(
          'Add your Quickk',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w400, color: Colors.amber),
        ),
        backgroundColor: kcDarkGreyColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Name your Quickk:',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: Colors.orange),
              ),
              verticalSpaceSmall,
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white)),
                child: TextFormField(
                  style: const TextStyle(color: kcLightGrey),
                  controller: viewModel.quickkname,
                  decoration: const InputDecoration(
                    hintText: "Name your Quickk...",
                    hintStyle: TextStyle(
                        color: kcLightGrey, fontWeight: FontWeight.w100),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 10),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              verticalSpaceMedium,
              const Text(
                'Quickk:',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: Colors.red),
              ),
              verticalSpaceTiny,
              SizedBox(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white)),
                  child: Text(
                    url,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w100,
                        color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    const Text(
                      'Favorite: ',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: Color.fromARGB(255, 255, 0, 0)),
                    ),
                    horizontalSpaceTiny,
                    GestureDetector(
                      onTap: () => viewModel.tofavorite(),
                      child: Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10)),
                          child: Icon(
                            size: 18,
                            Icons.favorite,
                            color: viewModel.isfavorite
                                ? Colors.red
                                : Colors.white,
                          )),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => viewModel.addquickk(),
                    child: const Text(
                      'Add',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  AddscreenViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AddscreenViewModel(url: url);
}
