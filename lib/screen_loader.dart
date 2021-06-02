library screen_loader;

import 'dart:ui';

import 'package:flutter/material.dart';

mixin ScreenLoader<T extends StatefulWidget> on State<T> {
  bool isLoading = false;
  static Widget? _globalLoader;
  static double? _globalLoadingBgBlur = 5.0;

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
  Future<T?> performFuture<T>(Function() futureCallback) async {
    this.startLoading();
    T? data = await futureCallback();
    this.stopLoading();
    return data;
  }

  /// override [loadingBgBlur] if you wish to change blur value in specific view
  double? loadingBgBlur() {
    return null;
  }

  double _loadingBgBlur() {
    return this.loadingBgBlur() ?? ScreenLoader._globalLoadingBgBlur ?? 5.0;
  }

  /// override [loader] if you wish to add custom loader in specific view
  Widget? loader() {
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

  Widget screen(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        screen(context),
        BackdropFilter(
          child: _buildLoader(),
          filter: ImageFilter.blur(
            sigmaX: this._loadingBgBlur(),
            sigmaY: this._loadingBgBlur(),
          ),
        ),
      ],
    );
  }
}

/// [ScreenLoaderApp] is used to provide global settings for the screen loader
class ScreenLoaderApp extends StatelessWidget {
  final MaterialApp app;
  final Widget? globalLoader;
  final double? globalLoadingBgBlur;

  ScreenLoaderApp({
    required this.app,
    this.globalLoader,
    this.globalLoadingBgBlur,
  });

  @override
  Widget build(BuildContext context) {
    ScreenLoader._globalLoader = this.globalLoader;
    ScreenLoader._globalLoadingBgBlur = this.globalLoadingBgBlur;
    return app;
  }
}
