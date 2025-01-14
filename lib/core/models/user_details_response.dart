class UserDetailsRespose {
  String? response;
  GuestDetails? user;
  List<GuestDetails>? guests;

  UserDetailsRespose({
    this.response,
    this.user,
    this.guests,
  });

  factory UserDetailsRespose.fromJson(dynamic json) => UserDetailsRespose(
        response: json["response"],
        user: json["user"] == null ? null : GuestDetails.fromJson(json["user"]),
        guests: json["guests"] == null
            ? []
            : List<GuestDetails>.from(
                json["guests"]!.map((x) => GuestDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "user": user?.toJson(),
        "guests": guests == null
            ? []
            : List<dynamic>.from(guests!.map((x) => x.toJson())),
      };
}

class GuestDetails {
  int? id;
  String? firstname;
  String? lastname;
  String? email;
  String? birthDate;
  String? gender;
  String? nationality;
  String? documentType;
  String? documentNumber;
  String? address;
  String? province;
  String? city;
  String? dni;
  String? phone;
  String? dateEntry;
  String? dateExit;
  List<Document>? documents;

  GuestDetails({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.birthDate,
    this.gender,
    this.nationality,
    this.documentType,
    this.documentNumber,
    this.address,
    this.province,
    this.city,
    this.dni,
    this.phone,
    this.dateEntry,
    this.dateExit,
    this.documents,
  });

  factory GuestDetails.fromJson(Map<String, dynamic> json) => GuestDetails(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        birthDate: json["birth_date"],
        gender: json["gender"],
        nationality: json["nationality"],
        documentType: json["document_type"],
        documentNumber: json["document_number"],
        address: json["address"],
        province: json["province"],
        city: json["city"],
        dni: json["dni"],
        phone: json["phone"],
        dateEntry: json[
            "date_entry"] /*== null
            ? null
            : DateTime.parse(json["date_entry"])*/
        ,
        dateExit: json[
            "date_exit"] /*== null
            ? null
            : DateTime.parse(json["date_exit"])*/
        ,
        documents: json["documents"] == null
            ? []
            : List<Document>.from(
                json["documents"]!.map((x) => Document.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "birth_date": birthDate,
        "gender": gender,
        "nationality": nationality,
        "document_type": documentType,
        "document_number": documentNumber,
        "address": address,
        "province": province,
        "city": city,
        "dni": dni,
        "phone": phone,
        "date_entry": dateEntry,
        /*"${dateEntry!.year.toString().padLeft(4, '0')}-${dateEntry!.month.toString().padLeft(2, '0')}-${dateEntry!.day.toString().padLeft(2, '0')}",*/
        "date_exit": dateExit,
        /*"${dateExit!.year.toString().padLeft(4, '0')}-${dateExit!.month.toString().padLeft(2, '0')}-${dateExit!.day.toString().padLeft(2, '0')}",*/
        "documents": documents == null
            ? []
            : List<dynamic>.from(documents!.map((x) => x.toJson())),
      };
}

class Document {
  String? type;
  String? name;
  String? filename;

  Document({
    this.type,
    this.name,
    this.filename,
  });

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        type: json["type"],
        name: json["name"],
        filename: json["filename"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "name": name,
        "filename": filename,
      };
}

// class UserDetail {
//   String? username;
//   String? firstname;
//   String? lastname;
//   String? email;
//   String? phone;
//   String? description;
//   String? pin;
//   String? birthDate;
//   String? gender;
//   String? nationality;
//   String? documentType;
//   String? documentNumber;
//   List<dynamic>? documents;

//   UserDetail({
//     this.username,
//     this.firstname,
//     this.lastname,
//     this.email,
//     this.phone,
//     this.description,
//     this.pin,
//     this.birthDate,
//     this.gender,
//     this.nationality,
//     this.documentType,
//     this.documentNumber,
//     this.documents,
//   });

//   factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
//         username: json["username"],
//         firstname: json["firstname"],
//         lastname: json["lastname"],
//         email: json["email"],
//         phone: json["phone"],
//         description: json["description"],
//         pin: json["pin"],
//         birthDate: json["birth_date"],
//         gender: json["gender"],
//         nationality: json["nationality"],
//         documentType: json["document_type"],
//         documentNumber: json["document_number"],
//         documents: json["documents"] == null
//             ? []
//             : List<dynamic>.from(json["documents"]!.map((x) => x)),
//       );

//   Map<String, dynamic> toJson() => {
//         "username": username,
//         "firstname": firstname,
//         "lastname": lastname,
//         "email": email,
//         "phone": phone,
//         "description": description,
//         "pin": pin,
//         "birth_date": birthDate,
//         "gender": gender,
//         "nationality": nationality,
//         "document_type": documentType,
//         "document_number": documentNumber,
//         "documents": documents == null
//             ? []
//             : List<dynamic>.from(documents!.map((x) => x)),
//       };
// }
