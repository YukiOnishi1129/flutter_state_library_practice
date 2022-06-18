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
  State<MyHomePage> createState() => MyHomePageState();
}

// クラス名: 先頭に「_」がついてるとprivateになる
class MyHomePageState extends State<MyHomePage> {
  //StatefulWidgetは一つのclassで、状態、ロジック、UIを定義できる
  //子供のclassにロジック、状態を渡していける。 (Reactのpropみたいな感じ)
  //子供はStateLessWidget
  //子供のWidgetが多くなりそこに状態やロジックを渡していくことで、階層が深くなり管理がしにくくなるのがデメリット (Reactのバケツリレーと一緒の課題)

  //State classで状態を定義
  //状態
  int counter = 0;

  //ロジック
  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  //見た目 (UI)
  @override
  Widget build(BuildContext context) {
    print('MyHomePageStateをビルド');
    return MyHomePageInheritedWidget(
      data: this,
      counter: counter,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              // constで定義することで、再描画しなくて良いことを指定する
              WidgetA(),
              WidgetB(),
              WidgetC(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyHomePageInheritedWidget extends InheritedWidget {
  const MyHomePageInheritedWidget(
      {Key? key,
      required Widget child,
      required this.data,
      required this.counter})
      : super(key: key, child: child);

  final MyHomePageState data;
  final int counter;

  //MyHomePageStateとupdateShouldNotifyはInheritedWidgetを定義する上での決まり文句

  static MyHomePageState of(BuildContext context, {bool listen = true}) {
    if (listen) {
      return (context
              .dependOnInheritedWidgetOfExactType<MyHomePageInheritedWidget>())!
          .data;
    } else {
      return (context
              .getElementForInheritedWidgetOfExactType<
                  MyHomePageInheritedWidget>()!
              .widget as MyHomePageInheritedWidget)
          .data;
    }
  }

  @override
  bool updateShouldNotify(MyHomePageInheritedWidget oldWidget) {
    return counter != oldWidget.counter;
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
  const WidgetB({Key? key}) : super(key: key);
  // 渡される値を定義

  @override
  Widget build(BuildContext context) {
    print('WidgetBをビルド');
    //InheritedWidgetで状態を取得する方法
    final MyHomePageState state = MyHomePageInheritedWidget.of(context);
    return Text(
      '${state.counter}',
      style: Theme.of(context).textTheme.headline4,
    );
  }
}

class WidgetC extends StatelessWidget {
  const WidgetC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('WidgetCをビルド');
    final MyHomePageState state =
        MyHomePageInheritedWidget.of(context, listen: false);
    return ElevatedButton(
      onPressed: () {
        state.incrementCounter();
      },
      child: const Text('カウント'),
    );
  }
}
