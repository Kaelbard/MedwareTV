import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_web_view.dart';
import '/flutter_flow/instant_timer.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Timer _timer;
  var dataTime = 5;
  var currentURL = 0;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());
    _model.instantTimer = InstantTimer.periodic(
      duration: const Duration(seconds: 5),
      callback: (timer) async {
        // Faz um chamado na API
        final homePageMedwereTVResponse =
            await _model.apiRequestCompleter?.future ?? MedwereTVCall.call();
        // Atualiza o índice do URL do vídeo
        setState(() {
          currentURL += 1;
        });
        // Verifica se o índice atingiu o número de itens
        if (currentURL == 15) {
          // Reinicia o índice
          currentURL = 0;
        }
      },
      startImmediately: true,
      arguments: [],
    );
  }

  @override
  void dispose() {
    _model.dispose();
    // Cancel the timer in the dispose method
    _timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return FutureBuilder<ApiCallResponse>(
      future: _model.apiRequestCompleter?.future ?? MedwereTVCall.call(),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 100.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }

        final homePageMedwereTVResponse = snapshot.data!;

        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: SafeArea(
              top: true,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Wrap(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: FlutterFlowWebView(
                                content: (MedwereTVCall.url(
                                  homePageMedwereTVResponse.jsonBody,
                                ) as List)
                                    .map<String>((s) => s.toString())
                                    .toList()[currentURL]
                                    .toString(),
                                bypass: false,
                                verticalScroll: false,
                                horizontalScroll: false,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
