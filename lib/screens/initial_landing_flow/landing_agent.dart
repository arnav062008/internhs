import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internhs/screens/initial_landing_flow/landing_page.dart';
import 'package:internhs/screens/initial_landing_flow/our_story_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../constants/device.dart';
import '../../util/header.dart';
import 'what_we_do.dart';

class LandingAgent extends StatefulWidget {
  final int index;
  LandingAgent({Key? key, this.index = 0}) : super(key: key);

  @override
  State<LandingAgent> createState() => _LandingAgentState();
}

class _LandingAgentState extends State<LandingAgent> {
  final PageController _pageController = PageController();
  int ind = 0;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (_pageController.hasClients) {
        _pageController.animateToPage(widget.index,
            duration: const Duration(seconds: 1), curve: Curves.easeInOutCubic);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  NotificationListener<ScrollNotification> _pageView() {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        // Check if we're at the top or bottom of the page view
        bool isAtTop =
            notification.metrics.atEdge && notification.metrics.pixels == 0;
        bool isAtBottom = notification.metrics.atEdge &&
            notification.metrics.pixels == notification.metrics.maxScrollExtent;

        // Handle overscroll
        if (notification is OverscrollNotification &&
            (isAtTop || isAtBottom)) {}
        return false;
      },
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: _pageController,
        itemCount: 3,
        pageSnapping: false,
        scrollBehavior:
            const CupertinoScrollBehavior().copyWith(overscroll: true),
        physics: const AlwaysScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            ind = index;
          });
        },
        itemBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return LandingPage(
                pageController: _pageController,
              );
            case 1:
              return const OurStoryPage();
            case 2:
              return const WhatWeDoPage();
            default:
              return LoadingAnimationWidget.twoRotatingArc(
                color: Colors.white,
                size: 15,
              );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            _pageView(),
            Positioned(
              left: 0,
              top: 0,
              child: Column(
                children: [
                  SizedBox(
                    height: height(context) * 0.015,
                  ),
                  const BuildHeader(),
                  SizedBox(
                    height: height(context) * 0.015,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
