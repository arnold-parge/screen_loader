library screen_loader;

import 'dart:ui';
import 'package:flutter/material.dart';

class ScreenLoader {
  bool isLoading = false;
  static Widget _globalLoader;

  /// starts the [loader]
  startLoading(State state) {
    state.setState(() {
      isLoading = true;
    });
  }

  /// stops the [loader]
  stopLoading(State state) {
    state.setState(() {
      isLoading = false;
    });
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
  Widget screenWrapper(Widget child) {
    return Stack(
      children: <Widget>[
        child,
        BackdropFilter(
          child: _buildLoader(),
          filter: ImageFilter.blur(
            sigmaX: 2.0,
            sigmaY: 2.0,
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
