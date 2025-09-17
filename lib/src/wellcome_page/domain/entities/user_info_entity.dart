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
  final String? ip;
  final AddressEntity? address;
  final String? macAddress;
  final String? university;
  final BankEntity? bank;
  final CompanyEntity? company;
  final String? ein;
  final String? ssn;
  final String? userAgent;
  final CryptoEntity? crypto;
  final String? role;

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
    this.ip,
    this.address,
    this.macAddress,
    this.university,
    this.bank,
    this.company,
    this.ein,
    this.ssn,
    this.userAgent,
    this.crypto,
    this.role,
  });
}

class HairEntity {
  final String color;
  final String type;

  HairEntity({required this.color, required this.type});
}

class AddressEntity {
  final String address;
  final String city;
  final String state;
  final String stateCode;
  final String postalCode;
  final CoordinatesEntity coordinates;
  final String country;

  AddressEntity({
    required this.address,
    required this.city,
    required this.state,
    required this.stateCode,
    required this.postalCode,
    required this.coordinates,
    required this.country,
  });
}

class CoordinatesEntity {
  final double lat;
  final double lng;

  CoordinatesEntity({required this.lat, required this.lng});
}

class BankEntity {
  final String cardExpire;
  final String cardNumber;
  final String cardType;
  final String currency;
  final String iban;

  BankEntity({
    required this.cardExpire,
    required this.cardNumber,
    required this.cardType,
    required this.currency,
    required this.iban,
  });
}

class CompanyEntity {
  final String department;
  final String name;
  final String title;
  final AddressEntity address;

  CompanyEntity({
    required this.department,
    required this.name,
    required this.title,
    required this.address,
  });
}

class CryptoEntity {
  final String coin;
  final String wallet;
  final String network;

  CryptoEntity({
    required this.coin,
    required this.wallet,
    required this.network,
  });
}
