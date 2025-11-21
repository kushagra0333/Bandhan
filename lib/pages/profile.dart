class Profile {
  final String image;
  final String name;
  final String age;
  final String city;
  final String job;
  final bool isAd;
  final String? adDescription;

  Profile({
    required this.image,
    required this.name,
    required this.age,
    required this.city,
    required this.job,
    this.isAd = false,
    this.adDescription,
  });
}