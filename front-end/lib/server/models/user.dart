class UserModel {
  String id;
  String name;
  String email;
  String password;
  String affiliation;
  int yearsOfExperience;
  String bio;
  String role;

  UserModel(
    this.id,
    this.name,
    this.email,
    this.password,
    this.affiliation,
    this.yearsOfExperience,
    this.bio,
    this.role,
  );

  factory UserModel.fromJson(dynamic json) {
    return UserModel(
        json['_id'] as String,
        json['name'] as String,
        json['email'] as String,
        json['password'] as String,
        json['affiliation'] as String,
        json['yearsOfExperience'] as int,
        json['bio'] as String,
        json['role'] as String);
  }

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, password: $password, affiliation: $affiliation, yearsOfExperience: $yearsOfExperience, bio: $bio, role: $role)';
  }
}
