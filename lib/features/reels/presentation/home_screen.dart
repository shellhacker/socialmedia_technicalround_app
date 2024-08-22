import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia_technicalround_app/configs/colors.dart';
import 'package:socialmedia_technicalround_app/configs/theme.dart';
import '../application/bloc/reels_bloc.dart';
import 'widgets/video_card.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final ScrollController scrollController = ScrollController();

  // List<Datum> feachedResponse = [];
  onScroll(BuildContext context) {
    print(
        "+++++++++++++++++++-----------------------+++++++++++++++++++++++++++++++++");

    final blocProvider = context.read<ReelsBloc>();

    if (blocProvider.isLoadingMore) return;
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      // final blocProvider = BlocProvider.of<ReelsBloc>(context);

      blocProvider.add(GetReels(request: blocProvider.count.toString()));

      // blocProvider.scrollListner(context);
    } else {
      print("++++++++++++++++++++++++++++++++++++++++++++++++++++");
    }
  }

  @override
  Widget build(BuildContext context) {
    final blocProvider = BlocProvider.of<ReelsBloc>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      blocProvider.add(GetReels(request: blocProvider.count.toString()));
      scrollController.addListener(() => onScroll(context));
    });
    return Scaffold(
        appBar: AppBar(
            leading: Row(children: [
              const SizedBox(width: 8),
              Image.asset('assets/images/ic_logo.png', width: 30, height: 30)
            ]),
            title: Row(children: [
              Image.asset("assets/images/ic_notification.png",
                  width: 20, height: 20),
              const SizedBox(width: 12),
              Image.asset("assets/images/ic_search.png", width: 20, height: 20)
            ]),
            actions: [
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: AppColors.backgroundColor),
                  child: Row(children: [
                    Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: AppColors.whiteColor, width: 1),
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.blackColor.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 10))
                            ],
                            image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    "assets/images/img_profile.jpeg")))),
                    const SizedBox(width: 6),
                    Text("Shabanas",
                        style: AppTheme.blackTextStyle
                            .copyWith(fontWeight: AppTheme.bold, fontSize: 12)),
                    const SizedBox(width: 2),
                    Image.asset("assets/images/ic_checklist.png", width: 16),
                    const SizedBox(width: 4)
                  ]))
            ]),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
            child: BlocBuilder<ReelsBloc, ReelsState>(
              builder: (context, state) {
                if (state is ReelsCompleted) {
                  return Column(children: [
                    Expanded(
                        child: SizedBox(
                            child: ListView.separated(
                                controller: scrollController,
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                separatorBuilder: (context, index) {
                                  return const SizedBox();
                                },
                                itemCount: state.isLoadingMore
                                    ? state.responseData.length + 1
                                    : state.responseData.length,
                                itemBuilder: (context, index) {
                                  if (index < state.responseData.length) {
                                    return VideoCard(
                                        index: index,
                                        post: blocProvider
                                            .feachedResponse[index]);
                                  } else {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                })))
                  ]);
                } else if (state is ReelsInitial &&
                    blocProvider.feachedResponse.isNotEmpty) {
                  return Center(
                    child: Text("Reels Not Available"),
                  );
                } else if (state is ReelsLoading &&
                    blocProvider.feachedResponse.isEmpty) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Column(children: [
                  Expanded(
                      child: SizedBox(
                          child: ListView.separated(
                              controller: scrollController,
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              separatorBuilder: (context, index) {
                                return const SizedBox();
                              },
                              itemCount: blocProvider.isLoadingMore
                                  ? blocProvider.feachedResponse.length + 1
                                  : blocProvider.feachedResponse.length,
                              itemBuilder: (context, index) {
                                if (index <
                                    blocProvider.feachedResponse.length) {
                                  return VideoCard(
                                      index: index,
                                      post:
                                          blocProvider.feachedResponse[index]);
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              })))
                ]);
              },
            )));
  }
}
