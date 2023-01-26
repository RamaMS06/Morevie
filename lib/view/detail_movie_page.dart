import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:morevie/controller/detail_movie_controller.dart';
import 'package:morevie/service/Config.dart';
import 'package:morevie/utils/colors.dart';
import 'package:morevie/utils/components.dart';
import 'package:skeletons/skeletons.dart';

class DetailMoviePage extends GetView<DetailMovieController> {
  @override
  Widget build(BuildContext context) {
    Get.put(DetailMovieController());
    return Scaffold(
      body: Obx(
        () => SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            fit: StackFit.loose,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 1.5,
                child: Stack(
                  children: [
                    Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: CachedNetworkImage(
                          placeholder: ((context, url) => SkeletonAvatar(
                                style: SkeletonAvatarStyle(
                                    height: MediaQuery.of(context).size.height),
                              )),
                          imageUrl: controller.detailMovie.value.posterPath ==
                                  null
                              ? 'https://upload.wikimedia.org/wikipedia/commons/5/59/Empty.png?20091205084734'
                              : Config.baseImage +
                                  controller.detailMovie.value.posterPath!,
                          fit: BoxFit.fill,
                        )),
                    Positioned(
                        child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                            Colors.white.withOpacity(0.4),
                            Colors.white.withOpacity(0.3),
                            Colors.white.withOpacity(0.2),
                            Colors.black.withOpacity(0.1)
                          ])),
                    ))
                  ],
                ),
              ),
              DraggableScrollableSheet(
                  initialChildSize: 0.5,
                  minChildSize: 0.5,
                  maxChildSize: 1,
                  builder: ((context, scrollController) {
                    return SingleChildScrollView(
                      controller: scrollController,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: ColorsMaterial.blackMaterial,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(35),
                                topRight: Radius.circular(35))),
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 25, left: 20, right: 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                      child: SkeletonComponent(
                                          isLoad:
                                              controller.isLoadingMovie.value,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: TextComponent(
                                            label: controller.detailMovie.value
                                                    .originalTitle ??
                                                " - ",
                                            weight: FontWeight.w700,
                                            color: ColorsMaterial.whiteMaterial,
                                            size: 22,
                                          ))),
                                  const SizedBox(width: 20),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, top: 10),
                                        child: SkeletonComponent(
                                          isLoad:
                                              controller.isLoadingMovie.value,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4.5,
                                          child: RatingBar(
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemSize: 20,
                                              initialRating:
                                                  controller.detailMovie.value.voteAverage ==
                                                          null
                                                      ? 0
                                                      : controller
                                                              .detailMovie
                                                              .value
                                                              .voteAverage! /
                                                          3,
                                              ratingWidget: RatingWidget(
                                                  full: const Icon(Icons.star,
                                                      color:
                                                          Colors.amberAccent),
                                                  half: const Icon(Icons.star,
                                                      color:
                                                          Colors.amberAccent),
                                                  empty: const Icon(Icons.star,
                                                      color: Colors.white)),
                                              onRatingUpdate: (val) {}),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      SkeletonComponent(
                                        isLoad: controller.isLoadingMovie.value,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4.5,
                                        child: Row(
                                          children: [
                                            Lottie.asset(
                                                'assets/lottie/lottie_fire.json',
                                                height: 20,
                                                width: 20,
                                                fit: BoxFit.cover),
                                            const SizedBox(width: 5),
                                            TextComponent(
                                              size: 14,
                                              color:
                                                  ColorsMaterial.whiteMaterial,
                                              weight: FontWeight.w500,
                                              label:
                                                  '${controller.detailMovie.value.popularity}',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 20, right: 20),
                              child: Container(
                                height: 30,
                                child: SkeletonComponent(
                                  isLoad: controller.isLoadingMovie.value,
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  child: ListView.separated(
                                      separatorBuilder: ((context, index) =>
                                          Container(
                                            width: 10,
                                          )),
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: (controller.detailMovie.value
                                                      .genres?.length ??
                                                  0) <
                                              3
                                          ? (controller.detailMovie.value.genres
                                                  ?.length ??
                                              0)
                                          : 3,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 3, horizontal: 5),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: TextComponent(
                                              label: controller.detailMovie
                                                          .value.genres ==
                                                      null
                                                  ? ' - '
                                                  : controller
                                                          .detailMovie
                                                          .value
                                                          .genres?[index]
                                                          ?.name ??
                                                      '-',
                                              color: Colors.white),
                                        );
                                      }),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.translate,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 10),
                                      TextComponent(
                                          label: controller.detailMovie.value
                                                  .spokenLanguages?[0]?.name ??
                                              'English',
                                          color: Colors.white,
                                          weight: FontWeight.w500)
                                    ],
                                  ),
                                  const SizedBox(width: 20),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_today_outlined,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 10),
                                      TextComponent(
                                          label: controller.detailMovie.value
                                                  .releaseDate ??
                                              ' - ',
                                          color: Colors.white,
                                          weight: FontWeight.w500)
                                    ],
                                  ),
                                  const SizedBox(width: 20),
                                  Row(
                                    children: [
                                      const Icon(Icons.watch,
                                          color: Colors.white, size: 18),
                                      const SizedBox(width: 10),
                                      TextComponent(
                                          label: controller
                                                  .detailMovie.value.status ??
                                              ' - ',
                                          color: Colors.white,
                                          weight: FontWeight.w500)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: TextComponent(
                                  label:
                                      controller.detailMovie.value.overview ??
                                          ' - ',
                                  color: Colors.white.withOpacity(0.6),
                                  weight: FontWeight.w100,
                                )),
                            const SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, bottom: 20),
                              child: TextComponent(
                                label: 'Productions',
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 150,
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      separatorBuilder: (context, index) =>
                                          Container(width: 10),
                                      itemCount: controller.detailMovie.value
                                                  .productionCompanies ==
                                              null
                                          ? 0
                                          : controller
                                                  .detailMovie
                                                  .value
                                                  .productionCompanies
                                                  ?.length ??
                                              0,
                                      itemBuilder: ((context, index) =>
                                          SizedBox(
                                            width: 100,
                                            child: Column(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  height: 55,
                                                  width: 55,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: CachedNetworkImage(
                                                        imageUrl: (controller
                                                                        .detailMovie
                                                                        .value
                                                                        .productionCompanies?[
                                                                            index]
                                                                        ?.logoPath ??
                                                                    '')
                                                                .isEmpty
                                                            ? 'https://diskopukm.palembang.go.id/assets/images/default.png'
                                                            : Config.baseImage +
                                                                (controller
                                                                        .detailMovie
                                                                        .value
                                                                        .productionCompanies?[
                                                                            index]
                                                                        ?.logoPath ??
                                                                    '')),
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                TextComponent(
                                                    label: controller
                                                            .detailMovie
                                                            .value
                                                            .productionCompanies?[
                                                                index]
                                                            ?.name ??
                                                        ' - ',
                                                    size: 13,
                                                    weight: FontWeight.w200,
                                                    align: TextAlign.center,
                                                    color: Colors.white)
                                              ],
                                            ),
                                          )))),
                            )
                          ],
                        ),
                      ),
                    );
                  }))
            ],
          ),
        ),
      ),
    );
  }
}
