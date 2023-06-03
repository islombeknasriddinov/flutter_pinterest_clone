class NetworkRequest {
  final String api;
  final Map<String, dynamic> _params = {};

  NetworkRequest(this.api);

  NetworkRequest addParams(Map<String, dynamic> params) {
    _params.addAll(params);
    return this;
  }

  Map<String, dynamic> get params => _params;
}
