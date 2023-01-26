import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:morevie/controller/search_controller.dart';
import 'package:morevie/service/Config.dart';
import 'package:morevie/utils/components.dart';
import 'package:morevie/view/detail_movie_page.dart';
import 'package:skeletons/skeletons.dart';

// class SearchPage extends GetView

class SearchPage extends GetView<SearchController> {
  @override
  Widget build(BuildContext context) {
    Get.put(SearchController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Obx(
        () => Column(
          children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                child: Row(children: [
                  Container(
                      width: MediaQuery.of(context).size.width / 1.66,
                      child: SearchTextField(onChanged: (value) {
                        controller.query.value = value;
                      }, onSubmit: (val) {
                        controller.isLoadSearch.value = true;
                        FocusScope.of(context).unfocus();
                        controller.getListSearch();
                      })),
                  const SizedBox(width: 10),
                  CardButton(
                      cardColor: Colors.black.withOpacity(0.6),
                      shadowColor: Colors.black.withOpacity(0.9),
                      cardIcon: const Icon(
                        Icons.tune,
                        color: Colors.white,
                      ),
                      callback: () {
                        showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                            context: context,
                            isScrollControlled: true,
                            builder: (_) => Padding(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(0.6),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            height: 5,
                                            width: 50,
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextComponent(
                                                label: "Filter Movie",
                                                size: 22,
                                                color: Colors.black
                                                    .withOpacity(0.6),
                                                weight: FontWeight.w600),
                                            CardTextComponent(
                                                label: 'Reset',
                                                assetIcon: 'ic_delete.png',
                                                textColor: Colors.black
                                                    .withOpacity(0.8),
                                                bgColor: Colors.white,
                                                callback: () {
                                                  controller.resetFilter();
                                                })
                                          ],
                                        ),
                                        const SizedBox(height: 15),
                                        Obx(
                                          () => Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextFormComponent(
                                                label: 'Region',
                                                controller:
                                                    TextEditingController(
                                                        text: controller
                                                            .regions.value),
                                                hintText:
                                                    'Input region (optional)',
                                                onComplete: (val) {
                                                  controller.regions.value =
                                                      val;
                                                },
                                              ),
                                              const SizedBox(height: 15),
                                              TextFormComponent(
                                                label: 'Movie Date',
                                                controller:
                                                    TextEditingController(
                                                        text: controller
                                                            .year.value
                                                            .toString()),
                                                onTap: () {
                                                  DatePicker.showDatePicker(
                                                      context,
                                                      showTitleActions: true,
                                                      minTime: DateTime(1900),
                                                      maxTime: DateTime(2100),
                                                      onConfirm: (date) {
                                                    controller
                                                        .setFilterDate(date);
                                                  }, onChanged: (date) {
                                                    controller
                                                        .setFilterDate(date);
                                                  });
                                                },
                                              ),
                                              const SizedBox(height: 15),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3.8,
                                                child: CardTextComponent(
                                                    label: "Adult",
                                                    assetIcon:
                                                        controller.isAdult.value
                                                            ? "ic_star.png"
                                                            : "ic_uncheck.png",
                                                    bgColor:
                                                        controller.isAdult.value
                                                            ? Colors.redAccent
                                                            : Colors.white,
                                                    textColor:
                                                        controller.isAdult.value
                                                            ? Colors.white
                                                            : Colors.redAccent,
                                                    callback: () {
                                                      controller.isAdult
                                                                  .value ==
                                                              true
                                                          ? controller.isAdult
                                                              .value = false
                                                          : controller.isAdult
                                                              .value = true;
                                                    }),
                                              ),
                                              const SizedBox(height: 15)
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ));
                      }),
                  const SizedBox(width: 5),
                  CardButton(
                      cardColor: Colors.redAccent,
                      shadowColor: Colors.redAccent,
                      cardIcon: const Icon(Icons.search, color: Colors.white),
                      callback: () {
                        controller.isLoadSearch.value = true;
                        FocusScope.of(context).unfocus();
                        controller.getListSearch();
                      })
                ])),
            controller.listSearch.isEmpty
                ? const EmptyListComponent()
                : Container(
                    height: MediaQuery.of(context).size.height / 1.45,
                    child: Skeleton(
                      skeleton: SkeletonListView(),
                      isLoading: controller.isLoadSearch.value,
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: ((context, index) => InkWell(
                              onTap: () =>
                                  Get.to(DetailMoviePage(), arguments: {
                                'movieId': controller.listSearch[index]?.id ?? 0
                              }),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.width /
                                              3.9,
                                      width: MediaQuery.of(context).size.width /
                                          3.7,
                                      child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          shadowColor:
                                              Colors.black.withOpacity(0.6),
                                          elevation: 10,
                                          child: Stack(children: [
                                            Positioned(
                                              top: 0,
                                              left: 0,
                                              bottom: 0,
                                              right: 0,
                                              child: CachedNetworkImage(
                                                imageUrl: (controller
                                                                .listSearch[
                                                                    index]
                                                                ?.backdropPath ??
                                                            "")
                                                        .isEmpty
                                                    ? "https://diskopukm.palembang.go.id/assets/images/default.png"
                                                    : Config.baseImage +
                                                        (controller
                                                                .listSearch[
                                                                    index]
                                                                ?.backdropPath ??
                                                            ""),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Positioned(
                                                child: Container(
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                      colors: [
                                                    Colors.white
                                                        .withOpacity(0.4),
                                                    Colors.white
                                                        .withOpacity(0.3),
                                                    Colors.white
                                                        .withOpacity(0.2),
                                                    Colors.black
                                                        .withOpacity(0.1)
                                                  ])),
                                            ))
                                          ])),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          TextComponent(
                                            maxLines: 2,
                                            label: controller.listSearch[index]
                                                    ?.originalTitle ??
                                                " - ",
                                            weight: FontWeight.w600,
                                            size: 14,
                                          ),
                                          TextComponent(
                                              size: 12,
                                              label: controller
                                                      .listSearch[index]
                                                      ?.releaseDate ??
                                                  " - "),
                                          const SizedBox(height: 5),
                                          TextComponent(
                                            maxLines: 2,
                                            size: 10,
                                            label: controller.listSearch[index]
                                                    ?.overview ??
                                                " - ",
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset('assets/images/ic_fire.png',
                                            width: 15,
                                            height: 15,
                                            fit: BoxFit.contain),
                                        const SizedBox(width: 5),
                                        TextComponent(
                                          size: 12,
                                          label:
                                              "${controller.listSearch[index]?.popularity ?? 0.0}",
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
                        separatorBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 0.5,
                              color: Colors.black.withOpacity(0.1)),
                        ),
                        itemCount: controller.listSearch.length,
                      ),
                    ),
                  ),
          ],
        ),
      )),
    );
  }
}
