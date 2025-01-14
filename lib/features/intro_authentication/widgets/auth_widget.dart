import 'package:cortijo_app/core/utils/validators.dart';
import 'package:cortijo_app/features/intro_authentication/widgets/bottom_sheet.dart';
import 'package:cortijo_app/features/intro_authentication/widgets/password_widget.dart';
import 'package:cortijo_app/widgets/app_bottons.dart';
import 'package:cortijo_app/widgets/app_textfield.dart';
import 'package:cortijo_app/widgets/app_title.dart';
import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../intro_authentication_view_model.dart';
import 'sign_up_widget.dart';

class AuthenticationWidget extends StatefulWidget {
  const AuthenticationWidget(this.model, {super.key});

  final IntroAuthanticationViewModel model;

  @override
  State<AuthenticationWidget> createState() => _AuthenticationWidgetState();
}

class _AuthenticationWidgetState extends State<AuthenticationWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AppTitle(text: 'Inicia sesión'),
            const SizedBox(height: 30),
            const Text(
              'Ingresa el correo asociado a tu reserva / cuenta',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            AppTextField(
              hinText: 'Email',
              onChanged: widget.model.email,
              validator: validateEmail,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            AppButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  Navigator.pop(context);
                  modalBottomSheet(context, Password(widget.model));
                }
              },
              text: 'Continuar',
              color: AppColors.oliveGreen,
              colorText: AppColors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '¿No tienes cuenta?',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  child: const Text(
                    'Registrate',
                    style: TextStyle(color: AppColors.oliveGreen, fontSize: 16),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    modalBottomSheet(context, SignUp(widget.model));
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
