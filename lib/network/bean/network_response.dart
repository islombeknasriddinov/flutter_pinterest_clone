class NetworkResponse {
  final String api;
  final int statusCode;
  final String requestType;
  final dynamic response;

  NetworkResponse({
    required this.api,
    required this.statusCode,
    required this.requestType,
    required this.response,
  }) {
    print(toString());
  }

  String get errorText => statusCode != 200 ? response.toString() : "";

  bool get isSuccessful => statusCode == 200;

  List<dynamic> getListResponse() {
    final data = response;
    if (data is List && data.isNotEmpty) {
      return data;
    } else {
      return [];
    }
  }

  Map<String, dynamic> getMapResponse() {
    final data = response;
    if (data is Map && data.isNotEmpty) {
      return data as Map<String, dynamic>;
    } else {
      return {};
    }
  }

  @override
  String toString() {
    String label = "----------------------- $NetworkResponse -----------------------";
    String strSuccess =
        "api : $api \n status code : $statusCode \n request type : $requestType \n isSuccessful : $isSuccessful \n response : $response";
    String strError =
        "api : $api \n status code : $statusCode \n request type : $requestType \n error text : $errorText \n isSuccessful : $isSuccessful";
    String endLine = "----------------------------------------------------------------";

    String result = isSuccessful ? strSuccess : strError;
    return "$label \n $result \n $endLine";
  }
}
