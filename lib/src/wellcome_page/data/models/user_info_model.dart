// user_model.dart
import '../../domain/entities/user_info_entity.dart';

class UserInfoModel extends UserEntity {
  UserInfoModel({
    super.id,
    super.firstName,
    super.lastName,
    super.maidenName,
    super.age,
    super.gender,
    super.email,
    super.phone,
    super.username,
    super.password,
    super.birthDate,
    super.image,
    super.bloodGroup,
    super.height,
    super.weight,
    super.eyeColor,
    super.hair,
    super.ip,
    super.address,
    super.macAddress,
    super.university,
    super.bank,
    super.company,
    super.ein,
    super.ssn,
    super.userAgent,
    super.crypto,
    super.role,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      maidenName: json['maidenName'],
      age: json['age'],
      gender: json['gender'],
      email: json['email'],
      phone: json['phone'],
      username: json['username'],
      password: json['password'],
      birthDate: json['birthDate'],
      image: json['image'],
      bloodGroup: json['bloodGroup'],
      height: (json['height'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      eyeColor: json['eyeColor'],
      hair: HairModel.fromJson(json['hair']),
      ip: json['ip'],
      address: AddressModel.fromJson(json['address']),
      macAddress: json['macAddress'],
      university: json['university'],
      bank: BankModel.fromJson(json['bank']),
      company: CompanyModel.fromJson(json['company']),
      ein: json['ein'],
      ssn: json['ssn'],
      userAgent: json['userAgent'],
      crypto: CryptoModel.fromJson(json['crypto']),
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "firstName": firstName,
      "lastName": lastName,
      "maidenName": maidenName,
      "age": age,
      "gender": gender,
      "email": email,
      "phone": phone,
      "username": username,
      "password": password,
      "birthDate": birthDate,
      "image": image,
      "bloodGroup": bloodGroup,
      "height": height,
      "weight": weight,
      "eyeColor": eyeColor,
      "hair": (hair as HairModel).toJson(),
      "ip": ip,
      "address": (address as AddressModel).toJson(),
      "macAddress": macAddress,
      "university": university,
      "bank": (bank as BankModel).toJson(),
      "company": (company as CompanyModel).toJson(),
      "ein": ein,
      "ssn": ssn,
      "userAgent": userAgent,
      "crypto": (crypto as CryptoModel).toJson(),
      "role": role,
    };
  }
}

class HairModel extends HairEntity {
  HairModel({required super.color, required super.type});

  factory HairModel.fromJson(Map<String, dynamic> json) =>
      HairModel(color: json['color'], type: json['type']);

  Map<String, dynamic> toJson() => {"color": color, "type": type};
}

class AddressModel extends AddressEntity {
  AddressModel({
    required super.address,
    required super.city,
    required super.state,
    required super.stateCode,
    required super.postalCode,
    required super.coordinates,
    required super.country,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    address: json['address'],
    city: json['city'],
    state: json['state'],
    stateCode: json['stateCode'],
    postalCode: json['postalCode'],
    coordinates: CoordinatesModel.fromJson(json['coordinates']),
    country: json['country'],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "city": city,
    "state": state,
    "stateCode": stateCode,
    "postalCode": postalCode,
    "coordinates": (coordinates as CoordinatesModel).toJson(),
    "country": country,
  };
}

class CoordinatesModel extends CoordinatesEntity {
  CoordinatesModel({required super.lat, required super.lng});

  factory CoordinatesModel.fromJson(Map<String, dynamic> json) =>
      CoordinatesModel(
        lat: (json['lat'] as num).toDouble(),
        lng: (json['lng'] as num).toDouble(),
      );

  Map<String, dynamic> toJson() => {"lat": lat, "lng": lng};
}

class BankModel extends BankEntity {
  BankModel({
    required super.cardExpire,
    required super.cardNumber,
    required super.cardType,
    required super.currency,
    required super.iban,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
    cardExpire: json['cardExpire'],
    cardNumber: json['cardNumber'],
    cardType: json['cardType'],
    currency: json['currency'],
    iban: json['iban'],
  );

  Map<String, dynamic> toJson() => {
    "cardExpire": cardExpire,
    "cardNumber": cardNumber,
    "cardType": cardType,
    "currency": currency,
    "iban": iban,
  };
}

class CompanyModel extends CompanyEntity {
  CompanyModel({
    required super.department,
    required super.name,
    required super.title,
    required super.address,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
    department: json['department'],
    name: json['name'],
    title: json['title'],
    address: AddressModel.fromJson(json['address']),
  );

  Map<String, dynamic> toJson() => {
    "department": department,
    "name": name,
    "title": title,
    "address": (address as AddressModel).toJson(),
  };
}

class CryptoModel extends CryptoEntity {
  CryptoModel({
    required super.coin,
    required super.wallet,
    required super.network,
  });

  factory CryptoModel.fromJson(Map<String, dynamic> json) => CryptoModel(
    coin: json['coin'],
    wallet: json['wallet'],
    network: json['network'],
  );

  Map<String, dynamic> toJson() => {
    "coin": coin,
    "wallet": wallet,
    "network": network,
  };
}
