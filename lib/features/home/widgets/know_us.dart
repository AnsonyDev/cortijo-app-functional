import 'package:cortijo_app/features/home/widgets/tittle_home.dart';
import 'package:cortijo_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_player/video_player.dart';

import '../views/home_view_model.dart';

class KnowUsWidget extends StatelessWidget {
  const KnowUsWidget(
    this.model, {
    Key? key,
  }) : super(key: key);
  final HomeViewModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TittleHome(tittle: 'Conócenos'),
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.oliveGreen,
              ),
              child: AspectRatio(
                aspectRatio: 3 / 4,
                child: model.videoController.value.isInitialized
                    ? VideoPlayer(model.videoController)
                    : null,
              ),
            ),
            if (!model.videoController.value.isPlaying)
              Positioned(
                bottom: 0,
                right: 20,
                child: IconButton(
                  onPressed: () => model.videoController.play(),
                  icon: SvgPicture.asset('assets/icons/bx_play-circle.svg',
                      height: 50, width: 50),
                ),
              ),
            if (model.videoController.value.isPlaying)
              Positioned(
                  bottom: 0,
                  right: 20,
                  child: IconButton(
                      onPressed: () => model.videoController.pause(),
                      icon: const Icon(
                        Icons.pause_circle_outline_sharp,
                        color: Colors.white,
                        size: 32,
                      ))),
          ],
        ),
      ],
    );
  }
}
