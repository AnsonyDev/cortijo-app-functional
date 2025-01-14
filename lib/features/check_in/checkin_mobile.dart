part of checkin_view;

class _CheckInMobile extends StatefulWidget {
  final CheckInViewModel model;

  const _CheckInMobile(this.model);

  @override
  State<_CheckInMobile> createState() => _CheckInMobileState();
}

class _CheckInMobileState extends State<_CheckInMobile> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MyTapToHideKeyboard(
      child: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const AppHeader(),
                const SizedBox(height: 15),
                const TittleHome(tittle: 'Check in'),
                ...List.generate(
                  widget.model.guests.length,
                  (i) => _guestsItem(i),
                ),
                const SizedBox(height: 30),
                Center(
                  child: AppButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        widget.model.checkIn(context);
                      }
                    },
                    isLoading: widget.model.busy,
                    // disabled: widget.model.guests.any((e) => e.hasNullValues()),
                    text: 'Continuar',
                    color: AppColors.oliveGreen,
                    colorText: Colors.white,
                    minWidth: MediaQuery.of(context).size.width * .90,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _guestsItem(int i) {
    // widget.model.guests[i];
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
            widget.model.guests[i].isIncumbent
                ? widget.model.guests[i].firstName ?? ''
                : 'Huésped ${i + 1}',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.white,
          // tilePadding: const EdgeInsets.all(10),
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
              label: 'Nombre*',
              hinText: 'Nombre',
              initialValue: widget.model.guests[i].firstName,
              enabled: !widget.model.guests[i].isIncumbent,
              onChanged: (value) => widget.model.changeFirstName(i, value!),
              validator: validateData,
            ),
            const SizedBox(height: 10),
            AppTextField(
              label: 'Apellidos*',
              hinText: 'Apellidos',
              initialValue: widget.model.guests[i].lastName,
              enabled: !widget.model.guests[i].isIncumbent,
              onChanged: (value) => widget.model.changeLastName(i, value!),
              validator: validateData,
            ),
            const SizedBox(height: 10),
            AppTextField(
              label: 'Email',
              hinText: 'Email',
              initialValue: widget.model.guests[i].email,
              enabled: //(!widget.model.guests[i].isIncumbent &&
                  widget.model.guests[i].email !=
                      LocalDataRepository().user?.email,
              onChanged: (value) => widget.model.changeEmail(i, value!),
              keyboardType: TextInputType.emailAddress,
              // validator: validateEmail,
            ),
            const SizedBox(height: 10),
            AppTextField(
              label: 'Fecha de nacimiento*',
              hinText: 'Fecha de nacimiento',
              initialValue: widget.model.guests[i].birthDate != null
                  ? DateFormat.yMd().format(widget.model.guests[i].birthDate!)
                  : null,
              enabled: !widget.model.guests[i].isIncumbent,
              onChanged: (value) => widget.model.changeBirthDay(i, value!),
              keyboardType: TextInputType.datetime,
              validator: validateData,
            ),
            const SizedBox(height: 10),

            DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: "Sexo*",
                isDense: false,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                filled: true,
                fillColor: AppColors.fillerColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.fillerColor),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.oliveGreen),
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              hint: Text(
                widget.model.guests[i].gender ?? "Sexo",
                style: const TextStyle(color: Colors.black),
              ),

              items: widget.model.genders.map((e) {
                return DropdownMenuItem<Gender>(
                  value: e,
                  child: Text(e.label),
                );
              }).toList(),

              value: widget.model.genderSelected,

              onChanged: (value) => widget.model.changeGenre(i, value!),
              isExpanded: true,
              borderRadius: BorderRadius.circular(15),
              dropdownColor: AppColors.fillerColor,
              validator: (value) => validateData(value?.value ?? ""),
              // underline: SizedBox.shrink(),
            ),
            // ),

            /*AppTextField(
              label: 'Sexo*',
              hinText: 'Sexo',
              initialValue: widget.model.guests[i].gender,
              enabled: !widget.model.guests[i].isIncumbent,
              onChanged: (value) => widget.model.changeGenre(i, value!),
              validator: validateData,
            ),*/
            const SizedBox(height: 10),
            AppTextField(
              label: 'Dirección',
              hinText: 'Dirección',
              initialValue: widget.model.guests[i].address,
              enabled: !widget.model.guests[i].isIncumbent,
              onChanged: (value) => widget.model.changeAddress(i, value!),
              // validator: validateData,
            ),
            const SizedBox(height: 10),
            AppTextField(
              label: 'Ciudad',
              hinText: 'Ciudad',
              initialValue: widget.model.guests[i].city,
              enabled: !widget.model.guests[i].isIncumbent,
              onChanged: (value) => widget.model.changeCity(i, value!),
              // validator: validateData,
            ),
            const SizedBox(height: 10),
            AppTextField(
              label: 'Provincia',
              hinText: 'Provincia',
              initialValue: widget.model.guests[i].province,
              enabled: !widget.model.guests[i].isIncumbent,
              onChanged: (value) => widget.model.changeProvince(i, value!),
              // validator: validateData,
            ),
            const SizedBox(height: 10),
            AppTextField(
              label: 'Teléfono',
              hinText: 'Teléfono',
              initialValue: widget.model.guests[i].phone,
              enabled: !widget.model.guests[i].isIncumbent,
              onChanged: (value) => widget.model.changePhone(i, value!),
              keyboardType: TextInputType.phone,
              // validator: validateData,
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
              initialValue: widget.model.guests[i].nationality,
              enabled: !widget.model.guests[i].isIncumbent,
              onChanged: (value) => widget.model.changeNationality(i, value!),
              // validator: validateData,
            ),
            const SizedBox(height: 10),
            AppTextField(
              label: 'DNI',
              hinText: 'DNI',
              initialValue: widget.model.guests[i].dni,
              enabled: !widget.model.guests[i].isIncumbent,
              onChanged: (value) => widget.model.changeDNI(i, value!),
              // validator: validateData,
            ),
            const SizedBox(height: 10),
            AppTextField(
              label: 'Tipo de documento',
              hinText: 'Tipo de documento',
              initialValue: widget.model.guests[i].documentType,
              enabled: !widget.model.guests[i].isIncumbent,
              onChanged: (value) => widget.model.changeDocumentType(i, value!),
              // validator: validateData,
            ),
            const SizedBox(height: 10),
            AppTextField(
              label: 'Número de documento',
              hinText: 'Número de documento',
              initialValue: widget.model.guests[i].documentNumber,
              enabled: !widget.model.guests[i].isIncumbent,
              keyboardType: TextInputType.number,
              onChanged: (value) =>
                  widget.model.changeDocumentNumber(i, value!),
              // validator: validateData,
            ),
            const SizedBox(height: 15),
            _CameraButton(
              img: widget.model.guests[i].frontDocument,
              text: "Adjunta foto del frontal del documento de identidad",
              onTap: () => widget.model.loadFromtDocumet(i),
            ),
            const SizedBox(height: 15),
            _CameraButton(
              img: widget.model.guests[i].backDocument,
              text: "Adjunta foto del trasero del documento de identidad",
              onTap: () => widget.model.loadBackDocumet(i),
            ),
            const SizedBox(height: 15),
            Text(
              'Firma',
              style: AppTextStyle.cardTitleStyle.copyWith(fontSize: 14),
            ),
            const SizedBox(height: 10),
            MySignatureWidget(
              onDrawEndSignature: (signature) =>
                  widget.model.loadSignature(i, signature),
              onDeleteSignature: () => widget.model.deleteSignature(i),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}

class _CameraButton extends StatelessWidget {
  const _CameraButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.img,
  }) : super(key: key);

  final String text;
  final File? img;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: SizedBox(
            width: double.infinity,
            height: 220,
            child: img != null
                ? Image.file(
                    img!,
                    fit: BoxFit.cover,
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/icon-camara.png',
                          height: 40, width: 50),
                      spacerM,
                      Text(
                        text,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class MySignatureWidget extends StatefulWidget {
  const MySignatureWidget(
      {required this.onDrawEndSignature,
      required this.onDeleteSignature,
      super.key});

  final Function(File) onDrawEndSignature;
  final Function() onDeleteSignature;

  @override
  State<MySignatureWidget> createState() => _MySignatureWidgetState();
}

class _MySignatureWidgetState extends State<MySignatureWidget> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 1.5,
    penColor: Colors.blue[900]!,
    exportBackgroundColor: Colors.white,
    exportPenColor: Colors.blue[900],
  );
  bool signIsEmpty = true;
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _controller.onDrawEnd = () {
        Future.delayed(const Duration(milliseconds: 800), () {
          _controller.toPngBytes(height: 1024, width: 1024).then((value) async {
            if (value == null) return;
            File dataTemp = await uint8ListToFile(value);
            widget.onDrawEndSignature(dataTemp);
          });
        });
      };
      if (_controller.value.isEmpty) {
        widget.onDeleteSignature.call();
      }
    });
  }

  @override
  void dispose() {
    // IMPORTANT to dispose of the controller
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(12),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: SizedBox(
              width: double.infinity,
              height: 220,
              child: Signature(
                key: const Key('signature'),
                controller: _controller,
                height: 250,
                backgroundColor: Colors.grey[100]!,
              ),
            ),
          ),
        ),
        spacerS,
        _buttons()
      ],
    );
  }

  Widget _buttons() {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          MaterialButton(
            color: AppColors.oliveGreen70,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            onPressed: () {
              setState(() => _controller.undo());
            },
            child: const Icon(
              Icons.undo,
              color: Colors.white,
            ),
          ),
          MaterialButton(
            color: AppColors.oliveGreen70,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            onPressed: () {
              setState(() => _controller.redo());
            },
            child: const Icon(
              Icons.redo,
              color: Colors.white,
            ),
          ),
          MaterialButton(
            color: AppColors.oliveGreen70,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            onPressed: () {
              widget.onDeleteSignature.call();
              setState(() => _controller.clear());
            },
            child: const Icon(
              Icons.clear,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
