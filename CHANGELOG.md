## 4.0.0

* Added support for using the loader in `StatelessWidget` too
* Using [`stream_mixin`](https://pub.dev/packages/stream_mixin/) instead of state to show/hide loader
* **BREAKING CHANGE**: Use `build` instead of `screen` function
* **BREAKING CHANGE**: `ScreenLoaderApp` widget is removed, use `configScreenLoader` function instead

## 3.0.2

* Fixed: [Issue #6](https://github.com/arnold-parge/screen_loader/issues/6): Screen is always blurry

## 3.0.1

* Updated README

## 3.0.0

* Migrating to null safety

## 2.0.1

* Updated readme as per the previous version's breaking changes

## 2.0.0
* **BREAKING CHANGE**: `screenWrapper` function removed
* Now just override `screen` function instead of `build` function in your `StatefulWidget`s

## 1.1.1

* Updated readme

## 1.1.0

* **BREAKING CHANGE**: Removed state parameter from `screenWrapper` function
* Added performFuture
* Added BasicScreen in example
* Added loadingBgBlur in ScreenLoader

## 1.0.4

* Updated description

## 1.0.3

* Added example

## 1.0.2

* Updated description in pubspec.yaml

## 1.0.1

* Updated description in pubspec.yaml

## 1.0.0

* Initial release
