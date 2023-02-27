class DeviceModel {
  DeviceModel.fromJson(Map<String, dynamic> json) {
    countryCode = json['countryCode'] as String;
    countryName = json['country'] as String;
    ip = json['query'] as String;
    isp = json['isp'] as String;
    region = json['region'] as String;
    regionName = json['regionName'] as String;
    timeZone = json['timezone'] as String;
  }

  String? countryCode;
  String? countryName;
  String? ip;
  String? isp;
  String? region;
  String? regionName;
  String? timeZone;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['countryCode'] = countryCode;
    data['country'] = countryName;
    data['query'] = ip;
    data['isp'] = isp;
    data['region'] = region;
    data['regionName'] = regionName;
    data['timezone'] = timeZone;
    return data;
  }
}
