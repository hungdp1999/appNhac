class DeviceRequest {
  DeviceRequest({required this.ip});

  DeviceRequest.fromJson(Map<String, dynamic> json) {
    ip = json['ip'] as String;
  }

  String? ip;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['ip'] = ip;
    return data;
  }
}
