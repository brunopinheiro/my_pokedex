import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:my_pokedex/api.dart';
import 'package:my_pokedex/generation.dart';
import 'package:my_pokedex/generation_list.dart';

class GenerationWidget extends StatefulWidget {
  final GenerationWidgetState _state;
  GenerationWidget(Api api): _state = new GenerationWidgetState(api);

  @override
  GenerationWidgetState createState() => _state;
}

class GenerationWidgetState extends State<GenerationWidget> {
  final Api _api;
  GenerationWidgetViewState _viewState;
  StreamSubscription _fetchSubscription;
  Generation _generation;

  GenerationWidgetState(Api api): _api = api;

  @override
  void initState() {
    super.initState();
    _viewState = GenerationWidgetViewState.loading;
    fetchFirstGeneration();
  }

  void fetchFirstGeneration() {
    _fetchSubscription = _api
      .request('generation', '1')
      .map((response) => jsonDecode(response))
      .map((mappedResponse) => Generation.fromJson(mappedResponse))
      .listen(
        (generation) => setState(() { _viewState = GenerationWidgetViewState.success; _generation = generation; }),
        onError: (_) => setState(() { _viewState = GenerationWidgetViewState.error; })
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pokédex')),
      body: getBody(),
      );
  }

  Widget getBody() {
    switch(_viewState) {
      case GenerationWidgetViewState.error: return getErrorStateWidget(); 
      case GenerationWidgetViewState.success: return getListStateWidget();
      default: return getLoadingStateWidget(); 
    }
  }

  Widget getErrorStateWidget() {
    return Column(
      children: [
        Text('Something went wrong. Please, try again'),
        IconButton(icon: Icon(Icons.replay), onPressed: (){
          setState(() { _viewState = GenerationWidgetViewState.loading; });
          fetchFirstGeneration();
        })
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  Widget getListStateWidget() {
    return GenerationList(_generation);
  }

  Widget getLoadingStateWidget() {
    return Row(
      children: [
        CircularProgressIndicator(),
        Container(width: 10),
        Text('Loading...')
      ],
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
    );
  }

  @override
  void dispose() {
    _fetchSubscription.cancel();
    super.dispose();
  }
}

enum GenerationWidgetViewState {
  loading,
  success,
  error
}
