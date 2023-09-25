class SendLocationBodyDto {
  final double lat;
  final double lang;
  SendLocationBodyDto({required this.lat, required this.lang});

  Map<String, dynamic> toJson() {
    return {
      'lat': lat.toString(),
      'lang': lang.toString(),
    };
  }
}
