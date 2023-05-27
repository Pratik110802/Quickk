import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quickk/ui/common/app_colors.dart';
import 'package:quickk/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import 'urltest_viewmodel.dart';

class UrltestView extends StackedView<UrltestViewModel> {
  const UrltestView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    UrltestViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: kcBackgroundColor,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (() {
                log('favorites');
              }),
              icon: const Icon(
                Icons.favorite,
                color: Colors.red,
              ))
        ],
        title: const Text(
          '🔥 Quickk',
          style: TextStyle(
              color: kcLightGrey, fontWeight: FontWeight.normal, fontSize: 22),
        ),
        backgroundColor: kcBackgroundColor,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        children: [
          verticalSpaceMedium,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              GestureDetector(
                onTap: (() => viewModel.launchInBrowser(viewModel.host)),
                child: Image.asset(
                  "assets/images/google.png",
                  width: 50,
                  height: 50,
                ),
              ),
              horizontalSpaceTiny,
              Flexible(
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      border: Border.all(color: kcLightGrey),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(
                    style: const TextStyle(color: kcLightGrey),
                    controller: viewModel.querycontroller,
                    decoration: InputDecoration(
                        hintText: "Enter whats in your mind?",
                        hintStyle: const TextStyle(
                            color: kcLightGrey, fontWeight: FontWeight.w100),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.only(left: 10),
                        suffix: IconButton(
                            onPressed: (() => viewModel.launchInApp()),
                            icon: const Icon(
                              Icons.search,
                              color: kcLightGrey,
                            ))),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
            ]),
          ),
          verticalSpaceMedium,
          const Text(
            'Launch the Link',
            style: TextStyle(
                color: kcLightGrey, fontWeight: FontWeight.w400, fontSize: 20),
          ),
          TextField(
            controller: viewModel.title,
          ),
          TextField(
            controller: viewModel.url,
            decoration: InputDecoration(hintText: viewModel.url.text),
          ),
          ElevatedButton(
              onPressed: () {
                // viewModel.setUrl();

                viewModel.getUrl();
              },
              child: const Text('set url')),
          verticalSpaceTiny,
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
                onPressed: () {
                  viewModel.getallkeys();
                  SnackBar snackdemo = const SnackBar(
                    content: Text('Loading all saved data'),
                    backgroundColor: Colors.orange,
                    elevation: 10,
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.all(5),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackdemo);
                },
                child: const Text('getall keys')),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
            ),
            height: 300,
            width: double.infinity,
            child: ListView.builder(
                shrinkWrap: false,
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onLongPress: () {
                      viewModel.removekey(viewModel.urls[index]);
                      SnackBar snackdemo = SnackBar(
                        content: Text(
                            viewModel.urls[index].toString() + ' is deleted'),
                        backgroundColor: Colors.red,
                        elevation: 10,
                        behavior: SnackBarBehavior.floating,
                        margin: const EdgeInsets.all(5),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackdemo);
                    },
                    onTap: () {
                      viewModel.launchsharedpref(viewModel.urls[index]);

                      SnackBar snackdemo = SnackBar(
                        content: Text(
                            viewModel.urls[index].toString() + ' is opening'),
                        backgroundColor: Colors.green,
                        elevation: 10,
                        behavior: SnackBarBehavior.floating,
                        margin: const EdgeInsets.all(5),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackdemo);
                    },
                    child: Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white10),
                        width: double.infinity,
                        height: 80,
                        child: Center(child: Text(viewModel.urls[index]))),
                  );
                }),
                itemCount: viewModel.urls.length),
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(
              child: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  viewModel.increment();
                },
              ),
              height: 100,
              width: double.infinity,
            ),
            Container(
              height: 500,
              width: double.infinity,
              color: Colors.red,
              child: ListView.builder(
                itemBuilder: ((context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        color: Colors.amber,
                      ),
                    )),
                itemCount: viewModel.count,
              ),
            ),
            SizedBox(
              child: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  viewModel.decrement();
                },
              ),
              height: 100,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }

  @override
  UrltestViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      UrltestViewModel();
}
