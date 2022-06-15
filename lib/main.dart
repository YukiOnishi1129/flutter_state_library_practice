import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

// StatefulWidget
// StatefulWidgetをextendsしたclassと、State<>を継承したStateClassの2つで構成される
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //StatefulWidgetは一つのclassで、状態、ロジック、UIを定義できる
  //子供のclassにロジック、状態を渡していける。 (Reactのpropみたいな感じ)
  //子供はStateLessWidget
  //子供のWidgetが多くなりそこに状態やロジックを渡していくことで、階層が深くなり管理がしにくくなるのがデメリット (Reactのバケツリレーと一緒の課題)

  //State classで状態を定義
  //状態
  int _counter = 0;

  //ロジック
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  //見た目 (UI)
  @override
  Widget build(BuildContext context) {
    print('MyHomePageStateをビルド');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // constで定義することで、再描画しなくて良いことを指定する
            const WidgetA(),
            WidgetB(_counter),
            WidgetC(_incrementCounter),
          ],
        ),
      ),
    );
  }
}

class WidgetA extends StatelessWidget {
  const WidgetA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('WidgetAをビルド');
    return const Text(
      'You have pushed the button this many times:',
    );
  }
}

class WidgetB extends StatelessWidget {
  // 親のWidgetから値を渡せるように
  //constructorに定義
  const WidgetB(this.counter, {Key? key}) : super(key: key);
  // 渡される値を定義
  final int counter;

  @override
  Widget build(BuildContext context) {
    print('WidgetBをビルド');
    return Text(
      '$counter',
      style: Theme.of(context).textTheme.headline4,
    );
  }
}

class WidgetC extends StatelessWidget {
  const WidgetC(this.increment, {Key? key}) : super(key: key);
  final Function increment;

  @override
  Widget build(BuildContext context) {
    print('WidgetCをビルド');
    return ElevatedButton(
      onPressed: () {
        increment();
      },
      child: const Text('カウント'),
    );
  }
}
