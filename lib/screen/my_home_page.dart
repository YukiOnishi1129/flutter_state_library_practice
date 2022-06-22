import 'package:flutter/material.dart';
import 'package:flutter_state_library_practice/state/my_home_state.dart';
import 'package:flutter_state_library_practice/view_model/my_home_view_model.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('MyHomePageをビルド');
    return StateNotifierProvider<MyHomePageStateNotifier, MyHomePageState>(
      create: (context) => MyHomePageStateNotifier(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutterラボ'),
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
    final int counter = context.watch<MyHomePageState>().counter;
    // final int counter =
    //     context.select<MyHomePageState, int>((state) => state.counter);

    //InheritedWidgetで状態を取得する方法
    // final MyHomePageState state = MyHomePageInheritedWidget.of(context);
    return Text(
      '${counter}',
      style: Theme.of(context).textTheme.headline4,
    );
  }
}

class WidgetC extends StatelessWidget {
  const WidgetC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('WidgetCをビルド');
    final Function increment =
        context.read<MyHomePageStateNotifier>().increment;
    // final MyHomePageState state =
    //     MyHomePageInheritedWidget.of(context, listen: false);
    return ElevatedButton(
      onPressed: () {
        increment();
      },
      child: const Text('カウント'),
    );
  }
}
