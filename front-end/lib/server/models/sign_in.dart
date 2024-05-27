class SignInModel {
  final String id;
  final String role;
  final String name;
  const SignInModel({
    required this.id,
    required this.role,
    required this.name,
  });

  factory SignInModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'role': String role,
        'name': String name,
      } =>
        SignInModel(
          id: id,
          role: role,
          name: name,
        ),
      _ => throw const FormatException('Failed to parse SignInModel'),
    };
  }
}
