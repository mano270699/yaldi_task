// user_entity.dart
class UserEntity {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? maidenName;
  final int? age;
  final String? gender;
  final String? email;
  final String? phone;
  final String? username;
  final String? password;
  final String? birthDate;
  final String? image;
  final String? bloodGroup;
  final double? height;
  final double? weight;
  final String? eyeColor;
  final HairEntity? hair;
  final String? domain;
  final String? ip;
  final AddressEntity? address;
  final String? macAddress;
  final String? university;
  final BankEntity? bank;
  final CompanyEntity? company;
  final String? ein;
  final String? ssn;
  final String? userAgent;

  UserEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.maidenName,
    this.age,
    this.gender,
    this.email,
    this.phone,
    this.username,
    this.password,
    this.birthDate,
    this.image,
    this.bloodGroup,
    this.height,
    this.weight,
    this.eyeColor,
    this.hair,
    this.domain,
    this.ip,
    this.address,
    this.macAddress,
    this.university,
    this.bank,
    this.company,
    this.ein,
    this.ssn,
    this.userAgent,
  });
}

class HairEntity {
  final String? color;
  final String? type;

  HairEntity({this.color, this.type});
}

class AddressEntity {
  final String? address;
  final String? city;
  final CoordinatesEntity coordinates;
  final String? postalCode;
  final String? state;

  AddressEntity({
    this.address,
    this.city,
    required this.coordinates,
    this.postalCode,
    this.state,
  });
}

class CoordinatesEntity {
  final double? lat;
  final double? lng;

  CoordinatesEntity({this.lat, this.lng});
}

class BankEntity {
  final String? cardExpire;
  final String? cardNumber;
  final String? cardType;
  final String? currency;
  final String? iban;

  BankEntity({
    this.cardExpire,
    this.cardNumber,
    this.cardType,
    this.currency,
    this.iban,
  });
}

class CompanyEntity {
  final AddressEntity address;
  final String? department;
  final String? name;
  final String? title;

  CompanyEntity({
    required this.address,
    this.department,
    this.name,
    this.title,
  });
}
