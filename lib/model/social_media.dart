part of model;

class SocialMedia {
  SocialMedia(
      {required this.organization,
      required this.id,
      required this.account,
      required this.serviceKey,
      required this.shortDescription,
      required this.serviceUrl});

  final int id;
  final String organization;
  final String account;
  final String serviceKey;
  final String shortDescription;
  final String serviceUrl;

  factory SocialMedia.fromJson(Map<String, dynamic> json) {
    return SocialMedia(
      organization: json['organization'],
      id: json['id'],
      account: json['account'],
      serviceKey: json['service_key'] ?? 'N/A',
      shortDescription: json['short_description'] ?? 'N/A',
      serviceUrl: json['service_url'] ?? 0,
    );
  }
}
