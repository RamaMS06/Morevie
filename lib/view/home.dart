import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:morevie/controller/home_controller.dart';
import 'package:morevie/service/Config.dart';
import 'package:morevie/view/trending_page.dart';
import 'package:skeletons/skeletons.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import '../utils/components.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  var homeViewModel = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Get.to(const TrendinPage());
                  },
                  content: SizedBox(
                      height: 230,
                      width: MediaQuery.of(context).size.width,
                      child: Obx(
                        () => Image.network(
                          homeViewModel.listResult.isEmpty
                              ? 'https://upload.wikimedia.org/wikipedia/commons/5/59/Empty.png?20091205084734'
                              : Config.baseImage +
                                  homeViewModel
                                      .listResult[
                                          homeViewModel.positionTrending.value]
                                      .backdropPath!,
                          loadingBuilder: ((context, child, loadingProgress) =>
                              loadingProgress == null
                                  ? child
                                  : Skeleton(
                                      isLoading: true,
                                      skeleton: SkeletonAvatar(
                                        style: SkeletonAvatarStyle(
                                            height: 270,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width),
                                      ),
                                      child: child,
                                    )),
                          fit: BoxFit.cover,
                        ),
                      )),
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
                        isLoading: homeViewModel.isLoadTrending.value,
                        skeleton: SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                              height: 25,
                              width: MediaQuery.of(context).size.width / 1.8),
                        ),
                        child: TextComponent(
                          label: homeViewModel.listResult.isEmpty
                              ? ''
                              : homeViewModel
                                          .listResult[homeViewModel
                                              .positionTrending.value]
                                          .originalTitle ==
                                      null
                                  ? homeViewModel
                                      .listResult[
                                          homeViewModel.positionTrending.value]
                                      .originalName
                                      .toString()
                                  : homeViewModel
                                      .listResult[
                                          homeViewModel.positionTrending.value]
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
                          isLoading: homeViewModel.isLoadTrending.value,
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
                                child: homeViewModel.listGenre!.isEmpty
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
                                        itemCount:
                                            homeViewModel.listGenre!.length,
                                        itemBuilder: (context, index) {
                                          return BoxTextComponent(
                                              label: TextComponent(
                                                  label: homeViewModel
                                                          .listGenre!.isEmpty
                                                      ? 'Undifined'
                                                      : homeViewModel
                                                          .listGenre![index],
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
                          itemCount: 4,
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
                                        child: SizedBox(
                                          height: 150,
                                          child: Image.network(
                                            homeViewModel.listPopular!.isEmpty
                                                ? 'https://upload.wikimedia.org/wikipedia/commons/5/59/Empty.png?20091205084734'
                                                : Config.baseImage +
                                                    homeViewModel
                                                        .listPopular![index]
                                                        .backdropPath!,
                                            loadingBuilder: ((context, child,
                                                    loadingProgress) =>
                                                loadingProgress == null
                                                    ? child
                                                    : Skeleton(
                                                        isLoading: true,
                                                        skeleton:
                                                            SkeletonAvatar(
                                                          style: SkeletonAvatarStyle(
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              height: 150),
                                                        ),
                                                        child: child)),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
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
                                                    isSkeleton: homeViewModel
                                                        .isLoadPopular.value,
                                                    child: const Icon(
                                                      Icons
                                                          .watch_later_outlined,
                                                      size: 14,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 4),
                                                  SkeletonDefaultComponent(
                                                    isSkeleton: homeViewModel
                                                        .isLoadPopular.value,
                                                    child: TextComponent(
                                                      label: homeViewModel
                                                              .listPopular!
                                                              .isEmpty
                                                          ? '-'
                                                          : DateFormat(
                                                                  'dd MMM yy')
                                                              .format(homeViewModel
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
                                              isSkeleton: homeViewModel
                                                  .isLoadPopular.value,
                                              child: Expanded(
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
                                                        label: homeViewModel
                                                                .listPopular!
                                                                .isEmpty
                                                            ? '-'
                                                            : homeViewModel
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
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  pressed: () {
                                    print('hehe');
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
