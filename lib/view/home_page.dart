import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:morevie/controller/home_controller.dart';
import 'package:morevie/model/DetailMovie.dart';
import 'package:morevie/service/Config.dart';
import 'package:morevie/view/detail_movie_page.dart';
import 'package:morevie/view/detail_trending_page.dart';
import 'package:skeletons/skeletons.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import '../utils/components.dart';

class HomePage extends GetView<HomeController> {
  HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextComponent(
                  label: 'Welcome back',
                  weight: FontWeight.w200,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextComponent(
                  label: 'Trending Now',
                  size: 20,
                  weight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CardComponent(
                  pressed: () {
                    Get.to(DetailMoviePage(),
                        arguments: {"movieId": controller.idTrending.value});
                  },
                  content: Obx(() => CachedNetworkImage(
                      height: 230,
                      fit: BoxFit.cover,
                      imageUrl: controller.listResult.isEmpty
                          ? 'https://upload.wikimedia.org/wikipedia/commons/5/59/Empty.png?20091205084734'
                          : Config.baseImage +
                              controller
                                  .listResult[controller.positionTrending.value]
                                  .backdropPath!)),
                ),
              ),
              const SizedBox(height: 15),
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Skeleton(
                        isLoading: controller.isLoadTrending.value,
                        skeleton: SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                              height: 25,
                              width: MediaQuery.of(context).size.width / 1.8),
                        ),
                        child: TextComponent(
                          label: controller.listResult.isEmpty
                              ? ''
                              : controller
                                          .listResult[
                                              controller.positionTrending.value]
                                          .originalTitle ==
                                      null
                                  ? controller
                                      .listResult[
                                          controller.positionTrending.value]
                                      .originalName
                                      .toString()
                                  : controller
                                      .listResult[
                                          controller.positionTrending.value]
                                      .originalTitle
                                      .toString(),
                          color: Colors.black.withOpacity(0.6),
                          size: 18,
                          weight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Skeleton(
                          isLoading: controller.isLoadTrending.value,
                          skeleton: const SkeletonAvatar(
                              style:
                                  SkeletonAvatarStyle(height: 25, width: 100)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/ic_genre.png',
                                  height: 15,
                                  width: 15,
                                  color: Colors.black.withOpacity(0.7)),
                              const SizedBox(width: 10),
                              SizedBox(
                                height: 27.5,
                                child: controller.listGenreTrending!.isEmpty
                                    ? BoxTextComponent(
                                        label: TextComponent(
                                            label: 'Undifined',
                                            size: 12,
                                            color:
                                                Colors.black.withOpacity(0.7)),
                                      )
                                    : ListView.separated(
                                        separatorBuilder: (context, index) =>
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 7.5),
                                              child: TextComponent(
                                                label: '•',
                                                size: 18,
                                                weight: FontWeight.w100,
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: controller
                                            .listGenreTrending!.length,
                                        itemBuilder: (context, index) {
                                          return BoxTextComponent(
                                              label: TextComponent(
                                                  label: controller
                                                          .listGenreTrending!
                                                          .isEmpty
                                                      ? 'Undifined'
                                                      : controller
                                                              .listGenreTrending![
                                                          index],
                                                  size: 12,
                                                  color: Colors.black
                                                      .withOpacity(0.7)));
                                        }),
                              ),
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 15, left: 15, right: 15),
                      child: Container(
                        height: 1,
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextComponent(
                            label: 'Popular',
                            weight: FontWeight.w200,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                TextComponent(
                                  label: 'View More',
                                  weight: FontWeight.bold,
                                ),
                                const SizedBox(width: 5),
                                const Icon(Icons.arrow_right_alt_sharp)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 250,
                                  crossAxisSpacing: 5,
                                  mainAxisExtent: 300),
                          itemCount: 10,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Obx(
                                () => CardComponent(
                                  content: Stack(
                                    children: [
                                      Card(
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        child: CachedNetworkImage(
                                            height: 150,
                                            fit: BoxFit.cover,
                                            imageUrl: controller
                                                    .listPopular!.isEmpty
                                                ? 'https://upload.wikimedia.org/wikipedia/commons/5/59/Empty.png?20091205084734'
                                                : Config.baseImage +
                                                    controller
                                                        .listPopular![index]
                                                        .backdropPath!),
                                      ),
                                      Positioned(
                                        top: 135,
                                        left: 10,
                                        child: CardComponent(
                                            elevation: 0,
                                            radius: 7.5,
                                            content: Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SkeletonDefaultComponent(
                                                    width: 20,
                                                    isSkeleton: controller
                                                        .isLoadPopular.value,
                                                    child: const Icon(
                                                      Icons
                                                          .watch_later_outlined,
                                                      size: 14,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 4),
                                                  SkeletonDefaultComponent(
                                                    isSkeleton: controller
                                                        .isLoadPopular.value,
                                                    child: TextComponent(
                                                      label: controller
                                                              .listPopular!
                                                              .isEmpty
                                                          ? '-'
                                                          : DateFormat(
                                                                  'dd MMM yy')
                                                              .format(controller
                                                                  .listPopular![
                                                                      index]
                                                                  .releaseDate!),
                                                      weight: FontWeight.w100,
                                                      size: 11,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )),
                                      ),
                                      Positioned(
                                        top: 175,
                                        left: 15,
                                        right: 15,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SkeletonDefaultComponent(
                                              width: 120,
                                              isSkeleton: controller
                                                  .isLoadPopular.value,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: TextComponent(
                                                      maxLines: 2,
                                                      label: controller
                                                              .listPopular!
                                                              .isEmpty
                                                          ? '-'
                                                          : controller
                                                              .listPopular![
                                                                  index]
                                                              .title!,
                                                      weight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Icon(Icons.more_horiz)
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Obx(
                                              () => SkeletonDefaultComponent(
                                                width: 100,
                                                isSkeleton: controller
                                                    .isLoadPopular.value,
                                                child: RatingBar.builder(
                                                    direction: Axis.horizontal,
                                                    initialRating: controller
                                                            .listPopular!
                                                            .isEmpty
                                                        ? 0
                                                        : controller
                                                                .listPopular![
                                                                    index]
                                                                .voteAverage! /
                                                            3,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemSize: 18,
                                                    itemBuilder: ((context,
                                                            index) =>
                                                        const Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                        )),
                                                    onRatingUpdate:
                                                        (rating) {}),
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  pressed: () {
                                    Get.to(DetailMoviePage(), arguments: {
                                      "movieId":
                                          controller.listPopular?[index].id ?? 0
                                    });
                                  },
                                  colors: Colors.black.withOpacity(0.025),
                                  radius: 20,
                                  elevation: 0,
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
