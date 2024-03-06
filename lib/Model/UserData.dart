class UserData {
  String? image;
  String name;
  String designation;
  String location;
  String department;
  String email;
  String phoneNumber;
  String dateOfBirth;
  String about;
  String aboutJob;
  String hobbies;

  UserData({
    this.image,
    required this.name,
    required this.designation,
    required this.location,
    required this.department,
    required this.email,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.about,
    required this.aboutJob,
    required this.hobbies,
  });

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'name': name,
      'designation': designation,
      'location': location,
      'department': department,
      'email': email,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth,
      'about': about,
      'aboutJob': aboutJob,
      'hobbies': hobbies,
    };
  }
}
