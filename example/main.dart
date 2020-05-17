import 'package:flutter/material.dart';
import 'package:screen_loader/screen_loader.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenLoaderApp(
      app: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Screen Loader',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Screen(),
      ),
      globalLoader: AlertDialog(
        title: Text('Gobal Loader..'),
      ),
      globalLoadingBgBlur: 20.0,
    );
  }
}

class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> with ScreenLoader<Screen> {
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
  Widget screen(BuildContext context) {
    return Scaffold(
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
    );
  }
}

class BasicScreen extends StatefulWidget {
  @override
  _BasicScreenState createState() => _BasicScreenState();
}

class _BasicScreenState extends State<BasicScreen>
    with ScreenLoader<BasicScreen> {
  @override
  Widget screen(BuildContext context) {
    return Scaffold(
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
    );
  }
}

class NetworkService {
  static Future getData() async {
    return await Future.delayed(Duration(seconds: 2));
  }
}
