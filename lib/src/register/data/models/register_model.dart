import '../../domain/entities/register_entity.dart';

class UserModel extends UserEntity {
  UserModel({
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
    super.domain,
    super.ip,
    super.address,
    super.macAddress,
    super.university,
    super.bank,
    super.company,
    super.ein,
    super.ssn,
    super.userAgent,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
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
    height: (json['height'] != null)
        ? (json['height'] as num).toDouble()
        : null,
    weight: (json['weight'] != null)
        ? (json['weight'] as num).toDouble()
        : null,
    eyeColor: json['eyeColor'],
    hair: HairModel.fromJson(json['hair']),
    domain: json['domain'],
    ip: json['ip'],
    address: AddressModel.fromJson(json['address']),
    macAddress: json['macAddress'],
    university: json['university'],
    bank: BankModel.fromJson(json['bank']),
    company: CompanyModel.fromJson(json['company']),
    ein: json['ein'],
    ssn: json['ssn'],
    userAgent: json['userAgent'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'firstName': firstName,
    'lastName': lastName,
    'maidenName': maidenName,
    'age': age,
    'gender': gender,
    'email': email,
    'phone': phone,
    'username': username,
    'password': password,
    'birthDate': birthDate,
    'image': image,
    'bloodGroup': bloodGroup,
    'height': height,
    'weight': weight,
    'eyeColor': eyeColor,
    'hair': (hair as HairModel).toJson(),
    'domain': domain,
    'ip': ip,
    'address': (address as AddressModel).toJson(),
    'macAddress': macAddress,
    'university': university,
    'bank': (bank as BankModel).toJson(),
    'company': (company as CompanyModel).toJson(),
    'ein': ein,
    'ssn': ssn,
    'userAgent': userAgent,
  };
}

class HairModel extends HairEntity {
  HairModel({super.color, super.type});

  factory HairModel.fromJson(Map<String, dynamic> json) =>
      HairModel(color: json['color'], type: json['type']);

  Map<String, dynamic> toJson() => {'color': color, 'type': type};
}

class AddressModel extends AddressEntity {
  AddressModel({
    super.address,
    super.city,
    required super.coordinates,
    super.postalCode,
    super.state,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    address: json['address'],
    city: json['city'],
    coordinates: CoordinatesModel.fromJson(json['coordinates']),
    postalCode: json['postalCode'],
    state: json['state'],
  );

  Map<String, dynamic> toJson() => {
    'address': address,
    'city': city,
    'coordinates': (coordinates as CoordinatesModel).toJson(),
    'postalCode': postalCode,
    'state': state,
  };
}

class CoordinatesModel extends CoordinatesEntity {
  CoordinatesModel({super.lat, super.lng});

  factory CoordinatesModel.fromJson(Map<String, dynamic> json) =>
      CoordinatesModel(
        lat: (json['lat'] != null) ? (json['lat'] as num).toDouble() : null,
        lng: (json['lng'] != null) ? (json['lng'] as num).toDouble() : null,
      );

  Map<String, dynamic> toJson() => {'lat': lat, 'lng': lng};
}

class BankModel extends BankEntity {
  BankModel({
    super.cardExpire,
    super.cardNumber,
    super.cardType,
    super.currency,
    super.iban,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
    cardExpire: json['cardExpire'],
    cardNumber: json['cardNumber'],
    cardType: json['cardType'],
    currency: json['currency'],
    iban: json['iban'],
  );

  Map<String, dynamic> toJson() => {
    'cardExpire': cardExpire,
    'cardNumber': cardNumber,
    'cardType': cardType,
    'currency': currency,
    'iban': iban,
  };
}

class CompanyModel extends CompanyEntity {
  CompanyModel({
    required super.address,
    super.department,
    super.name,
    super.title,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
    address: AddressModel.fromJson(json['address']),
    department: json['department'],
    name: json['name'],
    title: json['title'],
  );

  Map<String, dynamic> toJson() => {
    'address': (address as AddressModel).toJson(),
    'department': department,
    'name': name,
    'title': title,
  };
}
