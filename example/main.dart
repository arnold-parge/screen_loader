import 'package:flutter/material.dart';
import 'package:screen_loader/screen_loader.dart';

void main() {
  configScreenLoader(
    loader: AlertDialog(
      title: Text('Gobal Loader..'),
    ),
    bgBlur: 20.0,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Screen Loader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Screen(),
    );
  }
}

class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

/// A Stateful screen
class _ScreenState extends State<Screen> with ScreenLoader {
  @override
  loader() {
    return AlertDialog(
      title: Text('Wait.. Loading data..'),
    );
  }

  @override
  loadingBgBlur() => 10.0;

  Widget _buildBody() {
    return Center(
      child: Icon(
        Icons.home,
        size: MediaQuery.of(context).size.width,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return loadableWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Text('ScreenLoader Example'),
        ),
        body: _buildBody(),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await this.performFuture(NetworkService.getData);
          },
          child: Icon(Icons.refresh),
        ),
      ),
    );
  }
}

/// A Stateless screen
class BasicScreen extends StatelessWidget with ScreenLoader {
  BasicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return loadableWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Basic ScreenLoader Example'),
        ),
        body: Center(
          child: Icon(
            Icons.home,
            size: MediaQuery.of(context).size.width,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await this.performFuture(NetworkService.getData);
          },
          child: Icon(Icons.refresh),
        ),
      ),
    );
  }
}

class NetworkService {
  static Future getData() async {
    return await Future.delayed(Duration(seconds: 2));
  }
}
