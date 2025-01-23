import 'package:cortijo_app/features/home/widgets/tittle_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../theme/colors.dart';

class PlaylistCortijo extends StatelessWidget {
  const PlaylistCortijo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TittleHome(tittle: 'Playlist Retiros'),
        GestureDetector(
          onTap: () => launchUrlString(
              'https://open.spotify.com/playlist/6hm93VVek2wMos2OtIu1nQ?si=d77af3deb3164561&pt=35226e47fd94a6f245ab8c48360920ec',
              mode: LaunchMode.externalApplication),
          child: Container(
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.grey,
            ),
            height: 120,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Container(
                    padding: const EdgeInsets.all(33),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        width: 3,
                        color: AppColors.white,
                      ),
                      color: Colors.grey,
                      image: const DecorationImage(
                          image: AssetImage('assets/imgs/playlistImg.jpg'),
                          fit: BoxFit.cover),
                    ),
                    child: SvgPicture.asset('assets/icons/bx_play-circle.svg',
                        width: 20),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(height: 5),
                      Text(
                        'Experiencia Cortijo',
                        style: TextStyle(color: AppColors.white, fontSize: 18),
                      ),
                      Text(
                        'Los Agustinos Cortijo',
                        style: TextStyle(color: AppColors.white),
                      ),
                      Spacer(),
                      Text(
                        'Accede a la playlist',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5)
                    ],
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(height: 10),
                    SvgPicture.asset('assets/icons/spotify.svg', height: 20),
                    const Spacer(),
                    SvgPicture.asset(
                      'assets/icons/arrow-next.svg',
                      height: 16,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
                const SizedBox(width: 10),
              ]),
            ),
          ),
        )
      ],
    );
  }
}
