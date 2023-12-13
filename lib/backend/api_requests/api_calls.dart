import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

class MedwereTVCall {
  static Future<ApiCallResponse> call({
    List<int>? codTvList,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'MedwereTV',
      apiUrl: 'https://api.medware.com.br/MedwareTv/',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'codTv': 1,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic url(dynamic response) => getJsonField(
        response,
        r'''$[:].URL''',
        true,
      );
  static dynamic tempo(dynamic response) => getJsonField(
        response,
        r'''$[:].Tempo''',
        true,
      );
  static dynamic tv(dynamic response) => getJsonField(
        response,
        r'''$[:].Tv''',
        true,
      );
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}
