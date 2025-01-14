import 'package:cortijo_app/core/utils/validators.dart';
import 'package:cortijo_app/features/intro_authentication/widgets/set_password_widget.dart';
import 'package:cortijo_app/features/intro_authentication/widgets/sign_up_widget.dart';
import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../../widgets/app_bottons.dart';
import '../../../widgets/app_checkboxlisttile.dart';
import '../../../widgets/app_textfield.dart';
import '../intro_authentication_view_model.dart';
import 'auth_widget.dart';
import 'bottom_sheet.dart';

class Password extends StatefulWidget {
  const Password(this.model, {Key? key}) : super(key: key);

  final IntroAuthanticationViewModel model;

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
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
            const Text(
              'Contraseña',
              style: TextStyle(
                  fontFamily: 'Quiza Pro',
                  fontSize: 30,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            StatefulBuilder(
              builder: (_, setState) {
                return AppTextField(
                  hinText: 'Contraseña',
                  onChanged: (v) => widget.model.password = v,
                  keyboardType: TextInputType.visiblePassword,
                  validator: validateData,
                  obscureText: widget.model.showPassword,
                  suffixIcon: IconButton(
                    onPressed: () => setState(() =>
                        widget.model.showPassword = !widget.model.showPassword),
                    icon: Icon(
                      widget.model.showPassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  modalBottomSheet(context, SetPassword(widget.model));
                },
                child: const Text(
                  '¿Olvidaste tu contraseña?',
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            StatefulBuilder(
              builder: (_, setState) {
                return AppCheckBoxListTile(
                  onChanged: (value) =>
                      setState(() => widget.model.keepSavedData = value!),
                  value: widget.model.keepSavedData,
                  tittle: 'Mantener mis datos guardados',
                );
              },
            ),
            AppButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() {});
                  FocusScope.of(context).requestFocus(FocusNode());
                  await widget.model.initSession().then((value) {
                    if (!value) {
                      Navigator.pop(context);
                      modalBottomSheet(
                          context, AuthenticationWidget(widget.model));
                    }
                  });
                  setState(() {});
                }
              },
              text: 'Iniciar Sesión',
              isLoading: widget.model.busy,
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
                      style:
                          TextStyle(color: AppColors.oliveGreen, fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      modalBottomSheet(context, SignUp(widget.model));
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
