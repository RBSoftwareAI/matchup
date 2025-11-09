/// Modèle représentant un profil utilisateur
class Profile {
  final String id;
  final String name;
  final int age;
  final String jobTitle;
  final double distanceKm;
  final List<String> interests;
  final String photo;
  final DateTime createdAt;
  final String gender;

  const Profile({
    required this.id,
    required this.name,
    required this.age,
    required this.jobTitle,
    required this.distanceKm,
    required this.interests,
    required this.photo,
    required this.createdAt,
    required this.gender,
  });
}
