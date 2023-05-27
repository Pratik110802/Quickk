import 'package:flutter/material.dart';
import 'package:quickk/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:quickk/ui/common/app_colors.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: kcBackgroundColor,
      appBar: AppBar(
          backgroundColor: kcBackgroundColor,
          title: const Text(
            '🔥 Quickk',
            style: TextStyle(
                color: kcLightGrey, fontWeight: FontWeight.w400, fontSize: 23),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  viewModel.getfavquickks();
                  viewModel.showbottomsheet(
                      viewModel.allfavquickks, viewModel.favorites);
                },
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ))
          ]),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => viewModel.refresh(),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const Divider(
                color: kcLightGrey,
                thickness: 0.2,
              ),
              GestureDetector(
                onTap: () => viewModel.launchgoogleinBrowser(),
                child: Container(
                  margin: const EdgeInsets.only(left: 100, right: 100),
                  child: Image.asset(
                    "assets/images/google.png",
                    height: 90,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Flexible(
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(color: kcLightGrey),
                          borderRadius: BorderRadius.circular(20)),
                      child: TextFormField(
                        focusNode: viewModel.query,
                        style: const TextStyle(color: kcLightGrey),
                        controller: viewModel.querycontroller,
                        decoration: InputDecoration(
                            hintText: "Whats in your mind?...",
                            hintStyle: const TextStyle(
                                fontSize: 20,
                                color: kcMediumGrey,
                                fontWeight: FontWeight.w300),
                            border: InputBorder.none,
                            contentPadding:
                                const EdgeInsets.only(left: 30, top: 10),
                            suffix: GestureDetector(
                              onTap: viewModel.querycontroller.clear,
                              child: const Icon(
                                Icons.close,
                                color: kcLightGrey,
                              ),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () => viewModel.launchInApp(),
                              child: const Icon(
                                Icons.search,
                                color: kcLightGrey,
                                size: 22,
                              ),
                            )),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ),
                ]),
              ),
              const Divider(
                color: kcLightGrey,
                thickness: 0.2,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 24.0, top: 10),
                child: Text('Explore',
                    style: TextStyle(
                        color: kcLightGrey,
                        fontWeight: FontWeight.w300,
                        fontSize: 24)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black26),
                    height: 260,
                    width: double.infinity,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 2, crossAxisCount: 2),
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () => viewModel
                              .navigatetoexplore(viewModel.explorelist[index]),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.black,
                                      viewModel.explorelist[index].cardcolor
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12, top: 20),
                              child: Text(viewModel.explorelist[index].title,
                                  style: const TextStyle(
                                      color: kcLightGrey,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15)),
                            ),
                          ),
                        ),
                      ),
                      itemCount: viewModel.explorelist.length,
                    )),
              ),
              const Divider(
                color: kcLightGrey,
                thickness: 0.2,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Your Quickks',
                      style: TextStyle(
                          color: kcLightGrey,
                          fontWeight: FontWeight.w300,
                          fontSize: 24),
                    ),
                    IconButton(
                        onPressed: () {
                          viewModel.getallquicks();
                          SnackBar snackdemo = const SnackBar(
                            content: Text(
                              'Loading your Quickks...',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.italic),
                            ),
                            backgroundColor: Colors.grey,
                            elevation: 10,
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(5),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackdemo);
                        },
                        icon: const Icon(Icons.refresh)),
                  ],
                ),
              ),
              viewModel.allquickknames.isEmpty
                  ? const Center(
                      child: Text(
                      'No Quickks yet',
                      style: TextStyle(
                          color: kcLightGrey,
                          fontWeight: FontWeight.w200,
                          fontSize: 18),
                    ))
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.black26),
                        height: 100,
                        width: double.infinity,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: ((context, index) {
                              return GestureDetector(
                                  onLongPress: () {
                                    viewModel.deletequickk(viewModel
                                        .allquickknames[index]
                                        .toString());
                                  },
                                  onTap: () {
                                    viewModel.launchsharedpref(
                                        viewModel.allquickknames[index]);

                                    SnackBar snackdemo = SnackBar(
                                      content: Text(
                                        viewModel.allquickknames[index]
                                                .toString() +
                                            ' is opening',
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            fontStyle: FontStyle.italic),
                                      ),
                                      backgroundColor: Colors.green,
                                      elevation: 10,
                                      behavior: SnackBarBehavior.floating,
                                      margin: const EdgeInsets.all(5),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackdemo);
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 5, right: 5, bottom: 5, top: 5),
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 10, top: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          gradient: const LinearGradient(
                                              colors: [
                                                Colors.white10,
                                                Colors.black26,
                                                Colors.blueGrey,
                                                Colors.black12,
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight)),
                                      width: 100,
                                      height: 50,
                                      child: Text(
                                          viewModel.allquickknames[index],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 17))));
                            }),
                            itemCount: viewModel.allquickknames.length),
                      ),
                    ),
              verticalSpaceMedium,
              const Divider(
                color: kcLightGrey,
                thickness: 0.2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}

//  ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     shrinkWrap: true,
//                     itemBuilder: ((context, index) {
//                       return GestureDetector(
//                           onTap: () {
//                             viewModel
//                                 .launchsharedpref(viewModel.allquickknames[index]);

//                             SnackBar snackdemo = SnackBar(
//                               content: Text(
//                                 viewModel.allquickknames[index].toString() +
//                                     ' is opening',
//                                 style: const TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w300,
//                                     fontStyle: FontStyle.italic),
//                               ),
//                               backgroundColor: Colors.green,
//                               elevation: 10,
//                               behavior: SnackBarBehavior.floating,
//                               margin: const EdgeInsets.all(5),
//                             );
//                             ScaffoldMessenger.of(context)
//                                 .showSnackBar(snackdemo);
//                           },
//                           child: Container(
//                               margin: const EdgeInsets.only(
//                                   left: 5, right: 5, bottom: 5, top: 5),
//                               padding: const EdgeInsets.only(
//                                   left: 20, right: 10, top: 10),
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(20),
//                                   gradient: const LinearGradient(
//                                       colors: [
//                                         Colors.white10,
//                                         Colors.black26,
//                                         Colors.blueGrey,
//                                         Colors.black12,
//                                       ],
//                                       begin: Alignment.topLeft,
//                                       end: Alignment.bottomRight)),
//                               width: double.infinity,
//                               height: 50,
//                               child: Text(viewModel.allquickknames[index],
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.w300,
//                                       fontSize: 17))));
//                     }),
//                     itemCount: viewModel.allquickknames.length),
