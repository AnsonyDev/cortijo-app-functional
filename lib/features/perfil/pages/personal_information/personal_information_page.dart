import 'package:cortijo_app/core/data/user_repository.dart';
import 'package:cortijo_app/core/locator.dart';
import 'package:cortijo_app/core/models/user_details_response.dart';
import 'package:cortijo_app/features/home/widgets/tittle_home.dart';
import 'package:cortijo_app/theme/colors.dart';
import 'package:cortijo_app/theme/text_style.dart';
import 'package:cortijo_app/widgets/app_header.dart';
import 'package:cortijo_app/widgets/app_textfield.dart';
import 'package:cortijo_app/widgets/my_network_image.dart';
import 'package:cortijo_app/widgets/my_shimmer/my_shimmer.dart';
import 'package:cortijo_app/widgets/my_spacer/my_spacer.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class PersonalInformationPage extends StatelessWidget {
  const PersonalInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fillerColor,
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const AppHeader(),
              const SizedBox(height: 15),
              const TittleHome(tittle: 'Información personal'),
              FutureBuilder(
                  future: locator<UserRepository>().getDetails(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Column(
                          children: List.generate(
                              3,
                              (_) => const MyShimmer(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 8,
                                    ),
                                    height: 60,
                                    borderRadius: 25,
                                  )));
                    } else {
                      final data = snapshot.data;
                      if (data == null) {
                        return const SizedBox();
                      }
                      return Column(children: [
                        _guestsItem(data.user!),
                        ...List.generate(
                          data.guests?.length ?? 0,
                          (i) => _guestsItem(data.guests![i], i: i),
                        )
                      ]);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _guestsItem(GuestDetails guests, {int? i}) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(25),
        child: ExpansionTile(
          maintainState: true,
          collapsedBackgroundColor: Colors.white,
          leading: SvgPicture.asset('assets/icons/icon-perfil.svg'),
          trailing: const Icon(Icons.arrow_drop_down_circle_sharp),
          title: Text(
            i == null ? guests.firstname ?? '' : 'Huésped ${i + 1}',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.white,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          expandedAlignment: Alignment.centerLeft,
          childrenPadding: const EdgeInsets.symmetric(horizontal: 15),
          children: [
            Text(
              'Información personal',
              style: AppTextStyle.cardTitleStyle.copyWith(fontSize: 14),
            ),
            const SizedBox(height: 15),
            AppTextField(
              label: 'Nombre',
              hinText: 'Nombre',
              initialValue: guests.firstname,
              enabled: false,
            ),
            const SizedBox(height: 10),
            AppTextField(
              label: 'Apellidos',
              hinText: 'Apellidos',
              initialValue: guests.lastname,
              enabled: false,
            ),
            const SizedBox(height: 10),
            AppTextField(
              label: 'Email',
              hinText: 'Email',
              initialValue: guests.email,
              enabled: false,
            ),
            const SizedBox(height: 10),
            AppTextField(
              label: 'Fecha de nacimiento',
              hinText: 'Fecha de nacimiento',
              initialValue: guests.birthDate ??
                  '' /* != null
                  ? DateFormat("dd-MM-yyyy")
                      .parse(guests.birthDate!)
                      .toIso8601String()
                  : ' '*/
              ,
              enabled: false,
            ),
            const SizedBox(height: 10),
            AppTextField(
              label: 'Sexo',
              hinText: 'Sexo',
              initialValue: guests.gender,
              enabled: false,
            ),
            const SizedBox(height: 10),
            AppTextField(
              label: 'Dirección',
              hinText: 'Dirección',
              initialValue: guests.address,
              enabled: false,
            ),
            const SizedBox(height: 10),
            AppTextField(
              label: 'Ciudad',
              hinText: 'Ciudad',
              initialValue: guests.city,
              enabled: false,
            ),
            const SizedBox(height: 10),
            AppTextField(
              label: 'Provincia',
              hinText: 'Provincia',
              initialValue: guests.province,
              enabled: false,
            ),
            const SizedBox(height: 10),
            AppTextField(
              label: 'Teléfono',
              hinText: 'Teléfono',
              initialValue: guests.phone,
              enabled: false,
            ),
            const SizedBox(height: 15),
            const Divider(thickness: 1.5),
            const SizedBox(height: 15),
            Text(
              'Información del documento',
              style: AppTextStyle.cardTitleStyle.copyWith(fontSize: 14),
            ),
            const SizedBox(height: 15),
            AppTextField(
              label: 'Nacionalidad',
              hinText: 'Nacionalidad',
              initialValue: guests.nationality,
              enabled: false,
            ),
            const SizedBox(height: 10),
            AppTextField(
              label: 'DNI',
              hinText: 'DNI',
              initialValue: guests.dni,
              enabled: false,
            ),
            const SizedBox(height: 10),
            AppTextField(
              label: 'Tipo de documento',
              hinText: 'Tipo de documento',
              initialValue: guests.documentType,
              enabled: false,
            ),
            const SizedBox(height: 10),
            AppTextField(
              label: 'Número de documento',
              hinText: 'Número de documento',
              initialValue: guests.documentNumber,
              enabled: false,
            ),
            if (guests.documents?.isNotEmpty ?? false) ...[
              const SizedBox(height: 15),
              ...guests.documents!
                  .map((e) =>
                      _imgDoc(e.filename!, title: _titleImg(e.type ?? '')))
                  .toList(),
              // _imgDoc(guests.documents),
            ],
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  String _titleImg(String origin) {
    switch (origin) {
      case "front_document":
        return "Frontal del documento";
      case "back_document":
        return "Trasero del documento";
      case "signature":
        return "Firma";
      default:
        return "";
    }
  }

  Widget _imgDoc(String img, {String? title}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? "",
          style: AppTextStyle.cardTitleStyle.copyWith(fontSize: 14),
        ),
        spacerS,
        DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(12),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: MyNetworkImage(
              image: img,
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        spacerM,
      ],
    );
  }
}
