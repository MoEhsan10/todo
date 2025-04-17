class UserModel {
  String id;
  String fullName;
  String userName;
  String email;

  UserModel({
    required this.id,
    required this.fullName,
    required this.userName,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullName': fullName,
        'userName': userName,
        'email': email,
      };

  UserModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          fullName: json['fullName'],
          userName: json['userName'],
          email: json['email'],
        );
}
