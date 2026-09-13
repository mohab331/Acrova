import '../base_request_model.dart';

class SignUpRequestModel extends BaseRequestModel {
  final String? phone;
  final String? password;
  final String? name;
  final String? email;
  final String? address;
  final String? nationalID;
  final String? dateOfBirth;
  final int? cityID;
  final int? carTypeID;
  final int? providerID;
  final String? firebaseTokenKey;

  final String? countryISO;
  final String? country;
  final String? phoneKey;

  const SignUpRequestModel({
    this.phone,
    this.password,
    this.name,
    this.email,
    this.address,
    this.nationalID,
    this.dateOfBirth,
    this.cityID,
    this.carTypeID,
    this.providerID,
    this.firebaseTokenKey,
    this.countryISO,
    this.country,
    this.phoneKey,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'password': password,
      'name': name,
      'email': email,
      'address': address,
      'nationalID': nationalID,
      'dob': dateOfBirth,
      'cityID': cityID,
      'carTypeID': carTypeID,
      'providerID': providerID,
      'firebaseTokenKey': firebaseTokenKey,
      'countryISO': countryISO,
      'country': country,
      'phoneKey': phoneKey,
    };
  }

  @override
  List<Object?> get props => [
    phone,
    password,
    name,
    email,
    address,
    nationalID,
    dateOfBirth,
    cityID,
    carTypeID,
    providerID,
    firebaseTokenKey,
    countryISO,
    country,
    phoneKey,
  ];

  @override
  String toString() {
    return 'SignUpRequestModel('
        'phone: $phone, '
        'name: $name, '
        'email: $email'
        ')';
  }
}
