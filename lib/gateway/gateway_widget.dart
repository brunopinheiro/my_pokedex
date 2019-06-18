import 'package:flutter/animation.dart';
import "package:flutter/material.dart";
import 'package:my_pokedex/http_client.dart';

class GatewayWidget extends StatefulWidget {
  final _GatewayWidgetState _state;
  GatewayWidget(String host, HttpClient httpClient) : _state = _GatewayWidgetState(host, httpClient);

  @override
  _GatewayWidgetState createState() => _state;
}

enum _GatewayFetchingState {
  loading,
  complete,
  error
}

class _GatewayWidgetState extends State<GatewayWidget> {
  final String _host;
  final HttpClient _httpClient;
  final _GatewayView _view = _GatewayView();
  _GatewayFetchingState _fetchingState;

  _GatewayWidgetState(String host, HttpClient httpClient): _host = host, _httpClient = httpClient; 

  @override
  void initState(){
    _fetchGatewayData(); 
    super.initState();
  }

  void _fetchGatewayData() {
    _fetchingState = _GatewayFetchingState.loading;

    _httpClient
      .get("$_host")
      .listen(
        (_) => {},
        cancelOnError: true,
        onError: (_) => setState(() { _fetchingState = _GatewayFetchingState.error; }),
        onDone: () => setState(() { _fetchingState = _GatewayFetchingState.complete; })
      );
  }

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      body: _bodyView(),
      backgroundColor: Colors.red[300]
    );
  }

  Widget _bodyView() {
    switch(_fetchingState) {
      case _GatewayFetchingState.loading: return _view.loadingWidget();
      case _GatewayFetchingState.error: return _view.retryWidget(_fetchGatewayData);
      case _GatewayFetchingState.complete: return _view.doneWidget(); 
      default: return _view.retryWidget(_fetchGatewayData);
    }
  }
}

class _GatewayView {
  Widget loadingWidget() {
    return Center(child: 
      Row(
        children: <Widget>[
          CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white)),
          Container(width: 10), 
          Text('loading...', style: TextStyle(color: Colors.white))
          ], 
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min
      )
    );
  }

  Widget doneWidget() {
    return Center(child: 
      Text("we're done!", style: TextStyle(color: Colors.white))
    );
  }

  Widget retryWidget(Function retryCallback) {
    return Center(
      child: Column(children: <Widget>[
        Text("Couldn't fetch API data. Please try again", style: TextStyle(color: Colors.white)),
        IconButton(icon: Icon(Icons.replay, color: Colors.white), onPressed: retryCallback)
      ], mainAxisAlignment: MainAxisAlignment.center)
    );
  }
}