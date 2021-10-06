import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Counter(),
      child: MyApp(),
    ),
  );
}

class Counter with ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    if (_count != 0) {
      _count--;
      notifyListeners();
    }
  }

  void isVisible(bool _isVisible) {
    if (_isVisible) {
      _isVisible = !_isVisible;
      notifyListeners();
    } else {
      _isVisible = true;
      notifyListeners();
    }
  }
}

class VisibleButton with ChangeNotifier {
  void isVisible(bool _isVisible) {
    if (_isVisible) {
      _isVisible = !_isVisible;
      notifyListeners();
    } else {
      _isVisible = true;
      notifyListeners();
    }
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provider Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [Count()],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(child: VButton()),
          ],
        ),
      ),
    );
  }
}

class Count extends StatelessWidget {
  const Count({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "${context.watch<Counter>().count}",
      key: const Key('counterState'),
      style: Theme.of(context).textTheme.headline4,
    );
  }
}

class VButton extends StatelessWidget {
  const VButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool _isVisible = true;
    if (context.watch<Counter>().count < 1) {
      return Visibility(
          visible: _isVisible,
          child: Consumer<Counter>(
            builder: (context, counter, child) => ElevatedButton(
                onPressed: () {
                  counter.increment();
                  counter.isVisible(_isVisible);
                },
                child: Text("Add to Cart")),
          ));
    } else if (context.watch<Counter>().count >= 1) {
      return Visibility(
        visible: _isVisible,
        child: Consumer<Counter>(
            builder: (context, counter, child) => Container(
                    child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ElevatedButton(
                        onPressed: () {
                          counter.increment();
                          counter.isVisible(_isVisible);
                        },
                        child: Icon(Icons.add)),
                    ElevatedButton(
                        onPressed: () {
                          counter.decrement();
                          counter.isVisible(_isVisible);
                        },
                        child: Icon(Icons.remove)),
                  ],
                ))),
      );
    } else {
      return Text("It broke");
    }
  }
}
