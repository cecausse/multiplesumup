class Merchant {
  final String merchantName;
  final String clientId;
  final String clientSecret;
  final String affiliateKey;
  final String path;
  final String merchantId;
  String refreshToken;
  Merchant(
      {required this.path,
      required this.merchantName,
      required this.clientId,
      required this.clientSecret,
      required this.affiliateKey,
      required this.refreshToken,
      required this.merchantId});
  Merchant.fromData(Map<String, dynamic> data)
      : merchantName = data['merchantName'],
        clientId = data['clientId'],
        clientSecret = data['clientSecret'],
        affiliateKey = data['affiliateKey'],
        refreshToken = data['refreshToken'],
        path = data['path'],
        merchantId = data['merchantId'];

  Map<String, dynamic> toJson() {
    return {
      'merchantName': merchantName,
      'clientId': clientId,
      'clientSecret': clientSecret,
      'affiliateKey': affiliateKey,
      'refreshToken': refreshToken,
      'path': path,
      'merchantId': merchantId
    };
  }

  updateRefresh(String updateRefreshToken) {
    refreshToken = updateRefreshToken;
  }
}
