class UserData {
  int id;
  String? username;
  String? firstname;
  String? lastname;
  String? email;
  String? status;
  String? address;
  String? province;
  String? city;
  String? dni;
  String? phone;
  String? description;
  String? dateEntry;
  String? dateExit;
  String? qrCode;
  String? pin;
  String? notDisturb;
  String? birthDate;
  String? gender;
  String? nationality;
  String? documentType;
  String? documentNumber;
  List<dynamic>? documents;

  UserData({
    required this.id,
    this.username,
    this.firstname,
    this.lastname,
    this.email,
    this.status,
    this.address,
    this.province,
    this.city,
    this.dni,
    this.phone,
    this.description,
    this.dateEntry,
    this.dateExit,
    this.qrCode,
    this.pin,
    this.notDisturb,
    this.birthDate,
    this.gender,
    this.nationality,
    this.documentType,
    this.documentNumber,
    this.documents,
  });

  factory UserData.fromJson(dynamic json) => UserData(
        id: json["id"] as int,
        username: json["username"] as String?,
        firstname: json["firstname"] as String?,
        lastname: json["lastname"] as String?,
        email: json["email"] as String?,
        status: json["status"] as String?,
        address: json["address"] as String?,
        province: json["province"] as String?,
        city: json["city"] as String?,
        dni: json["dni"] as String?,
        phone: json["phone"] as String?,
        description: json["description"] as String?,
        dateEntry: json["date_entry"] as String?,
        dateExit: json["date_exit"] as String?,
        qrCode: json["qr_code"] as String?,
        pin: json["pin"] as String?,
        notDisturb: json["not_disturb"].toString(),
        birthDate: json["birth_date"] as String?,
        gender: json["gender"] as String?,
        nationality: json["nationality"] as String?,
        documentType: json["document_type"] as String?,
        documentNumber: json["document_number"] as String?,
        documents: json["documents"] == null
            ? []
            : List<dynamic>.from(json["documents"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "status": status,
        "address": address,
        "province": province,
        "city": city,
        "dni": dni,
        "phone": phone,
        "description": description,
        "date_entry": dateEntry,
        "date_exit": dateExit,
        "qr_code": qrCode,
        "pin": pin,
        "not_disturb": notDisturb,
        "birth_date": birthDate,
        "gender": gender,
        "nationality": nationality,
        "document_type": documentType,
        "document_number": documentNumber,
        "documents": documents == null
            ? []
            : List<dynamic>.from(documents!.map((x) => x)),
      };
}
