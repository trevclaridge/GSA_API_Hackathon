part of model;

class Agency {
  Agency(
      {required this.id,
      required this.name,
      required this.tag,
      required this.infoUrl,
      required this.mobileAppCount,
      required this.socialMediaCount});

  final int id;
  final String name;
  final String tag;
  final String infoUrl;
  final int mobileAppCount;
  final int socialMediaCount;

  factory Agency.fromJson(Map<String, dynamic> json) {
    return Agency(
      id: json['id'],
      name: json['name'],
      tag: json['tag'] ?? 'N/A',
      infoUrl: json['info_url'] ?? 'N/A',
      mobileAppCount: json['mobile_app_count'] ?? 0,
      socialMediaCount: json['social_media_count'] ?? 0,
    );
  }

  void fillSocialMedias() {
    if (this.socialMediaCount != 0) {
      API().fetchSocialMedias(this.id);
    }
  }
}
