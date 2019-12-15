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
    );
  }
}

class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> with ScreenLoader {
  loader() {
    return AlertDialog(
      title: Text('Wait.. Loading data..'),
    );
  }

  _getData() async {
    this.startLoading(this);
    await Future.delayed(Duration(seconds: 3));
    this.stopLoading(this);
  }

  Widget _buildBody() {
    return Center(
      child: Image.network(
          'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQgQu8nlAEzW63m0pKcq9csbtk-3ni_QlvW4uy6DgeaWbO4Fze1'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ScreenLoader Example'),
      ),
      body: this.screenWrapper(
        this._buildBody(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: this._getData,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
