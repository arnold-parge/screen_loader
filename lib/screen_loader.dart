library screen_loader;

import 'dart:ui';
import 'package:flutter/material.dart';

mixin ScreenLoader<T extends StatefulWidget> on State<T> {
  bool isLoading = false;
  static Widget _globalLoader;

  /// starts the [loader]
  startLoading() {
    this.setState(() {
      isLoading = true;
    });
  }

  /// stops the [loader]
  stopLoading() {
    this.setState(() {
      isLoading = false;
    });
  }

  /// DO NOT use this method in FutureBuilder because this methods
  /// updates the state which will make future builder to call
  /// this function again and it will go in loop
  Future<T> performFuture<T>(Function futureCallback) async {
    this.startLoading();
    T data = await futureCallback();
    this.stopLoading();
    return data;
  }

  /// override [loader] if you wish to add custom loader in specific view
  Widget loader() {
    return null;
  }

  Widget _loader() {
    return this.loader() ??
        ScreenLoader._globalLoader ??
        CircularProgressIndicator();
  }

  Widget _buildLoader() {
    if (this.isLoading) {
      return Container(
        color: Colors.transparent,
        child: Center(
          child: this._loader(),
        ),
      );
    } else {
      return Container();
    }
  }

  /// Wraps [child] as screen into [loader]
  Widget screenWrapper({@required Widget child}) {
    return Stack(
      children: <Widget>[
        child,
        BackdropFilter(
          child: _buildLoader(),
          filter: ImageFilter.blur(
            sigmaX: 5.0,
            sigmaY: 5.0,
          ),
        ),
      ],
    );
  }
}

/// [ScreenLoaderApp] is used to provide [globalLoader]
class ScreenLoaderApp extends StatelessWidget {
  final MaterialApp app;
  final Widget globalLoader;

  ScreenLoaderApp({
    @required this.app,
    this.globalLoader,
  });

  @override
  Widget build(BuildContext context) {
    ScreenLoader._globalLoader = globalLoader;
    return app;
  }
}
