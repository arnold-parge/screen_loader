# screen_loader

Using `showDialog` for showing loader is a **BAD IDEA**. You may end up messing the navigation stack sue to pushing and poping the loader. Hence, I have come up with an easy to use mixin `ScreenLoader`, which will hadle the loading on the screen. You can customise the loading as well, check below how.

## Installation

Add dependency in pubspec.yaml:
```
screen_loader: ^1.0.0
```

## Basic Usage

Extend your screen(`StatefulWidget`) with `ScreenLoader`. Use `this.startLoading(this)` to start loading and use `this.stopLoading(this)` to stop loading. That's it!

```

class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> with ScreenLoader {

  _getData() {
    // start loading
    this.startLoading(this);
    
    // do some future stuff
    Future.delayed(Duration(seconds: 3));
    
    //stop loading
    this.stopLoading(this);
  }

  Widget _buildBody() {
    return Center(
      child: MaterialButton(
        child: Text('Get Data'),
        onPressed: this._getData,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sample ScreenLoader'),
      ),
      // wrap your body in `screenWrapper`
      body: this.screenWrapper(
        this._buildBody(),
      ),
    );
  }
}

```

## Override Loader

Simply overide `loader()` method in your `_ScreenState` class

```
loader() {
    // here any widget would do
    return AlertDialog(
        title: Text('Wait.. Loading data..'),
    );
}
```

## Override Loader Gobally

```

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenLoaderApp(
      app: MaterialApp(
        title: AppStrings.yapChat,
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

```

## Priority of loaders

- **Local loader**: the one you override in the `_ScreenState` class
- **Global loader**: the one you specify in `ScreenLoaderApp`. Note: if you don't override `local()`, this loader will be used.
- **Default loader**: if you don't specify global loader or override local loader, this loader will be used

### PS 
PRs are welcome. Please raise issue if you face any.
