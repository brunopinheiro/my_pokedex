import 'package:flutter/animation.dart';
import "package:flutter/material.dart";
import 'package:my_pokedex/http_client.dart';

class GatewayWidget extends StatefulWidget {
  final _GatewayWidgetState _state;
  GatewayWidget(String host, HttpClient httpClient) : _state = _GatewayWidgetState(host, httpClient);

  @override
  _GatewayWidgetState createState() => _state;
}

class _GatewayWidgetState extends State<GatewayWidget> {
  final String _host;
  final HttpClient _httpClient;
  final _GatewayView _view = _GatewayView();
  bool _loading;

  _GatewayWidgetState(String host, HttpClient httpClient): _host = host, _httpClient = httpClient; 

  @override
  void initState(){
    _loading = true;

    _httpClient
      .get("$_host")
      .listen(
        (_) => {},
        onDone: _showDoneWidget
      );

    super.initState();
  }

  void _showDoneWidget() {
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      body: _loading ? _view.loadingWidget() : _view.doneWidget(),
      backgroundColor: Colors.red[300]
    );
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
}