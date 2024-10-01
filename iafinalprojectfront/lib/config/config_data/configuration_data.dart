class ConfigurationData {
  ConfigurationData({
    this.baseUrl = "http://localhost:34545",
    this.contentType = "application/json",
    this.debugging = false,
  });

  String baseUrl;
  final String contentType;

  final bool debugging;

  ConfigurationData copyWith({
    String? baseUrl,
    String? contentType,
    bool? debugging,
  }) {
    return ConfigurationData(
      baseUrl: baseUrl ?? this.baseUrl,
      contentType: contentType ?? this.contentType,
      debugging: debugging ?? this.debugging,
    );
  }
}