import 'package:cortijo_app/features/intro_authentication/widgets/sign_up_widget.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/validators.dart';
import '../../../theme/colors.dart';
import '../../../widgets/app_bottons.dart';
import '../../../widgets/app_checkboxlisttile.dart';
import '../../../widgets/app_textfield.dart';
import '../intro_authentication_view_model.dart';
import 'bottom_sheet.dart';

class SetPassword extends StatefulWidget {
  const SetPassword(this.model, {Key? key}) : super(key: key);

  final IntroAuthanticationViewModel model;

  @override
  State<SetPassword> createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
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
              'Recuperar contraseña',
              style: TextStyle(
                  fontFamily: 'Quiza Pro',
                  fontSize: 30,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),

            AppTextField(
              hinText: 'Email',
              validator: validateEmail,
              keyboardType: TextInputType.emailAddress,
              onChanged: widget.model.email,
            ),
            const SizedBox(height: 12),
            // StatefulBuilder(
            //   builder: (_, setState) {
            //     return AppTextField(
            //       hinText: 'Contraseña',
            //       obscureText: widget.model.showSetPassword,
            //       suffixIcon: IconButton(
            //         onPressed: () => setState(() => widget
            //             .model.showSetPassword = !widget.model.showSetPassword),
            //         icon: Icon(
            //           widget.model.showSetPassword
            //               ? Icons.visibility_off_outlined
            //               : Icons.visibility_outlined,
            //         ),
            //       ),
            //     );
            //   },
            // ),
            // const SizedBox(height: 20),
            // StatefulBuilder(
            //   builder: (_, setState) {
            //     return AppTextField(
            //       hinText: 'Confirmar contraseña',
            //       obscureText: widget.model.showSetPasswordConfirm,
            //       suffixIcon: IconButton(
            //         onPressed: () => setState(() =>
            //             widget.model.showSetPasswordConfirm =
            //                 !widget.model.showSetPasswordConfirm),
            //         icon: Icon(
            //           widget.model.showSetPasswordConfirm
            //               ? Icons.visibility_off_outlined
            //               : Icons.visibility_outlined,
            //         ),
            //       ),
            //     );
            //   },
            // ),
            const SizedBox(height: 10),
            StatefulBuilder(
              builder: (_, setState) {
                return AppCheckBoxListTile(
                  onChanged: (value) =>
                      setState(() => widget.model.acceptTermins2 = value!),
                  value: widget.model.acceptTermins2,
                  tittle:
                      'Estoy de acuerdo con la política de privacidad y Términos de uso.',
                );
              },
            ),
            const SizedBox(height: 10),
            AppButton(
              onPressed: () async {
                if (_formKey.currentState!.validate() &&
                    widget.model.acceptTermins2) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  setState(() {});
                  await widget.model.forgotPassword();
                  setState(() {});
                }
              },
              text: 'Continua',
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
