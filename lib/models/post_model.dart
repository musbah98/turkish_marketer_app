class PostModel {
  final String? title;
  final String? desc;
  final String? image;
  final String? country;
  final String? credits;
  final String? time;

  PostModel({
    this.title,
    this.desc,
    this.image,
    this.country,
    this.credits,
    this.time,
  });

  factory PostModel.fromJson(dynamic json) {
    // Cast json to Map<String, dynamic> before accessing its keys
    final map = json as Map<String, dynamic>;

    return PostModel(
      title: map['title'] ?? '',
      desc: map['desc'] ?? '',
      image: map['image'] ?? '',
      country: map['country'] ?? '',
      credits: map['credits'] ?? '',
      time: map['time'] ?? '',
    );
  }
}
