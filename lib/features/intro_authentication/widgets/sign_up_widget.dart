import 'package:cortijo_app/core/utils/validators.dart';
import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../../widgets/app_bottons.dart';
import '../../../widgets/app_textfield.dart';
import '../intro_authentication_view_model.dart';
import 'auth_widget.dart';
import 'bottom_sheet.dart';

class SignUp extends StatefulWidget {
  const SignUp(this.model, {Key? key}) : super(key: key);

  final IntroAuthanticationViewModel model;

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(30),
      physics: const BouncingScrollPhysics(),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Regístrate',
              style: TextStyle(
                fontFamily: 'Quiza Pro',
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            AppTextField(
              hinText: 'Nombre',
              validator: validateData,
              onChanged: widget.model.name,
            ),
            const SizedBox(height: 12),
            AppTextField(
              hinText: 'Apellido',
              validator: validateData,
              onChanged: widget.model.lastName,
            ),
            const SizedBox(height: 12),
            AppTextField(
              hinText: 'Email',
              validator: validateEmail,
              onChanged: widget.model.email,
            ),
            const SizedBox(height: 12),
            StatefulBuilder(
              builder: (context, setState) {
                return AppTextField(
                  hinText: 'Contraseña',
                  validator: (value) {
                    return validatePasswordConfirm(
                        value, widget.model.passwordConfirm);
                  },
                  obscureText: widget.model.showPasswordSignUp,
                  onChanged: (v) => widget.model.password = v,
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => widget.model
                        .showPasswordSignUp = !widget.model.showPasswordSignUp),
                    icon: Icon(
                      widget.model.showPasswordSignUp
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            StatefulBuilder(
              builder: (context, setState) {
                return AppTextField(
                  hinText: 'Confirmar contraseña',
                  validator: (value) {
                    return validatePasswordConfirm(
                        value, widget.model.password);
                  },
                  onChanged: (v) => widget.model.passwordConfirm = v,
                  obscureText: widget.model.showPasswordSignUpComfirm,
                  suffixIcon: IconButton(
                    onPressed: () => setState(() =>
                        widget.model.showPasswordSignUpComfirm =
                            !widget.model.showPasswordSignUpComfirm),
                    icon: Icon(
                      widget.model.showPasswordSignUpComfirm
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            StatefulBuilder(
              builder: (context, setState) {
                return CheckboxListTile(
                  onChanged: (value) =>
                      setState(() => widget.model.acceptTermins = value!),
                  value: widget.model.acceptTermins,
                  title: const Text(
                      'Estoy de acuerdo con la política de privacidad y Términos de uso.'),
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: AppColors.white,
                  contentPadding: EdgeInsets.zero,
                  checkColor: AppColors.oliveGreen,
                  checkboxShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                );
              },
            ),
            const SizedBox(height: 10),
            AppButton(
              onPressed: () async {
                if (_formKey.currentState!.validate() &&
                    widget.model.acceptTermins) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  setState(() {});
                  await widget.model.register();
                  setState(() {});
                }
              },
              text: 'Registrarme',
              isLoading: widget.model.busy,
              color: AppColors.oliveGreen,
              colorText: AppColors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '¿Ya tienes cuenta?',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                TextButton(
                    child: const Text(
                      'Inicia sesión',
                      style:
                          TextStyle(color: AppColors.oliveGreen, fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      modalBottomSheet(
                          context, AuthenticationWidget(widget.model));
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
