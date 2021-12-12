library screen_loader;

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:stream_mixin/stream_mixin.dart';

void configScreenLoader({
  required Widget? loader,
  required double bgBlur,
}) {
  GlobalScreenLoader.loader = loader;
  GlobalScreenLoader.bgBlur = bgBlur;
}

abstract class GlobalScreenLoader {
  static Widget? loader;
  static double bgBlur = 5.0;
}

class ScreenLoaderStream with StreamMixin<bool> {
  @override
  bool get lastUpdate => false;
}

mixin ScreenLoader {
  final ScreenLoaderStream _screenLoaderStream = ScreenLoaderStream();

  /// starts the [loader]
  startLoading() {
    _screenLoaderStream.update(true);
  }

  /// stops the [loader]
  stopLoading() {
    _screenLoaderStream.update(false);
  }

  /// To avoid use of [startLoading] and [stopLoading] you use use
  /// [performFuture] which will show the loader until the passed future call
  /// is done executing
  Future<U?> performFuture<U>(Function futureCallback) async {
    startLoading();
    U? data = await futureCallback();
    stopLoading();
    return data;
  }

  /// override [loadingBgBlur] if you wish to change blur value in specific view
  double? loadingBgBlur() {
    return null;
  }

  double _loadingBgBlur() {
    return loadingBgBlur() ?? GlobalScreenLoader.bgBlur;
  }

  /// override [loader] if you wish to add custom loader in specific view
  Widget? loader() {
    return null;
  }

  Widget _loader() {
    return loader() ??
        GlobalScreenLoader.loader ??
        const CircularProgressIndicator();
  }

  Widget _buildLoader() {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: _loader(),
      ),
    );
  }

  Widget loadableWidget({required Widget child}) {
    return Stack(
      children: <Widget>[
        child,
        StreamBuilder<bool>(
          initialData: false,
          stream: _screenLoaderStream.onChange,
          builder: (ctx, snap) {
            if (!(snap.data ?? false)) {
              return const SizedBox();
            } else {
              return BackdropFilter(
                child: _buildLoader(),
                filter: ImageFilter.blur(
                  sigmaX: _loadingBgBlur(),
                  sigmaY: _loadingBgBlur(),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
