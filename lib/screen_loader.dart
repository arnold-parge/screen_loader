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

final ScreenLoaderStream _screenLoaderStream = ScreenLoaderStream();

mixin ScreenLoader {
  bool get isLoading => _screenLoaderStream.lastUpdate;

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
  double loadingBgBlur() {
    return GlobalScreenLoader.bgBlur;
  }

  /// override [loader] if you wish to add custom loader in specific view
  Widget? loader() {
    return GlobalScreenLoader.loader ?? const CircularProgressIndicator();
  }

  Widget _buildLoader() {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: loader(),
      ),
    );
  }

  Widget loadableWidget({required Widget child}) => Loadable(
        child: child,
        loader: _buildLoader(),
        blurSigma: loadingBgBlur(),
      );
}

class Loadable extends StatelessWidget {
  final Widget child;
  final Widget loader;
  final double blurSigma;

  const Loadable({
    required this.child,
    required this.loader,
    required this.blurSigma,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        StreamBuilder<bool>(
          initialData: false,
          stream: _screenLoaderStream.onChange,
          builder: (ctx, snap) {
            if (!(snap.data ?? false)) {
              return const SizedBox.shrink();
            } else {
              return BackdropFilter(
                child: loader,
                filter: ImageFilter.blur(
                  sigmaX: blurSigma,
                  sigmaY: blurSigma,
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
