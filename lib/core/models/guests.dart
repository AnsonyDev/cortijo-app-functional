import 'dart:io';

class Guests {
  String? firstName;
  String? lastName;
  String? email;
  DateTime? birthDate;
  String? birthDateString;
  String? gender;
  String? nationality;
  String? documentType;
  String? documentNumber;
  String? address;
  String? province;
  String? city;
  String? dni;
  String? phone;
  File? frontDocument;
  File? backDocument;
  File? signature;
  bool isIncumbent;

  Guests({
    this.firstName,
    this.lastName,
    this.email,
    this.birthDate,
    this.birthDateString,
    this.gender,
    this.nationality,
    this.documentType,
    this.documentNumber,
    this.address,
    this.province,
    this.city,
    this.dni,
    this.phone,
    this.frontDocument,
    this.backDocument,
    this.signature,
    this.isIncumbent = false,
  });

  /*bool hasNullValues() {
    return firstName == null ||
            lastName == null ||
            //email == null ||
            birthDate == null ||
            gender ==
                null /*||
        nationality == null ||
        documentType == null ||
        documentNumber == null ||
        address == null ||
        province == null ||
        city == null ||
        dni == null ||
        phone == null ||
        frontDocument == null ||
        backDocument == null ||
        signature == null*/
        ;
  }*/

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstName,
      'lastname': lastName,
      'email': email ?? "",
      'birth_date': birthDate?.toIso8601String() ?? "",
      'gender': gender,
      'nationality': nationality ?? "",
      'document_type': documentType ?? "",
      'document_number': documentNumber ?? "",
      'address': address ?? "",
      'province': province ?? "",
      'city': city ?? "",
      'dni': dni ?? "",
      'phone': phone ?? "",
      'front_document': frontDocument?.path ?? "",
      'back_document': backDocument?.path ?? "",
      'signature': signature?.path ?? "",
    };
  }

  factory Guests.fromJson(dynamic json) {
    return Guests(
      firstName: json['firstname'],
      lastName: json['lastname'],
      email: json['email'],
      birthDate: json['birth_date'] != null
          ? DateTime.parse(json['birth_date'])
          : null,
      gender: json['gender'],
      nationality: json['nationality'],
      documentType: json['document_type'],
      documentNumber: json['document_number'],
      address: json['address'],
      province: json['province'],
      city: json['city'],
      dni: json['dni'],
      phone: json['phone'],
      frontDocument: json['front_document'],
      backDocument: json['back_document'],
      signature: json['signature'],
    );
  }

  Guests isIncumbentTrue() {
    return Guests(
      firstName: firstName,
      lastName: lastName,
      email: email,
      birthDate: birthDate,
      gender: gender,
      nationality: nationality,
      documentType: documentType,
      documentNumber: documentNumber,
      address: address,
      province: province,
      city: city,
      dni: dni,
      phone: phone,
      frontDocument: frontDocument,
      backDocument: backDocument,
      signature: signature,
      isIncumbent: true,
    );
  }
}
