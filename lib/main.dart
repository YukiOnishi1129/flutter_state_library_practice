import 'package:flutter/material.dart';
import 'package:flutter_state_library_practice/screen/my_home_page.dart';

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
      home: const MyHomePage(),
    );
  }
}

// class MyHomePageState extends ChangeNotifier {
//   int counter = 0;
//
//   void increment() {
//     counter++;
//     notifyListeners();
//   }
//
//   void reBuild() {
//     notifyListeners();
//   }
// }

// StatefulWidget
// StatefulWidgetをextendsしたclassと、State<>を継承したStateClassの2つで構成される
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => MyHomePageState();
// }

// クラス名: 先頭に「_」がついてるとprivateになる
// class MyHomePageState extends State<MyHomePage> {
//   //StatefulWidgetは一つのclassで、状態、ロジック、UIを定義できる
//   //子供のclassにロジック、状態を渡していける。 (Reactのpropみたいな感じ)
//   //子供はStateLessWidget
//   //子供のWidgetが多くなりそこに状態やロジックを渡していくことで、階層が深くなり管理がしにくくなるのがデメリット (Reactのバケツリレーと一緒の課題)
//
//   //State classで状態を定義
//   //状態
//   // int counter = 0;
//   //
//   // //ロジック
//   // void incrementCounter() {
//   //   setState(() {
//   //     counter++;
//   //   });
//   // }
//
//   // BLoCパターン: stateとロジックを別の処理で管理する
//   late MyHomePageLogic myHomePageLogic;
//
//   @override
//   void initState() {
//     super.initState();
//     myHomePageLogic = MyHomePageLogic();
//   }
//
//   //見た目 (UI)
//   @override
//   Widget build(BuildContext context) {
//     print('MyHomePageStateをビルド');
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             // constで定義することで、再描画しなくて良いことを指定する
//             const WidgetA(),
//             WidgetB(myHomePageLogic),
//             WidgetC(myHomePageLogic),
//           ],
//         ),
//       ),
//     );
//   }
// }

// BLoCパターン
// class MyHomePageLogic {
//   MyHomePageLogic() {
//     _counterController.sink.add(_counter);
//   }
//
//   final StreamController<int> _counterController = StreamController();
//   int _counter = 0;
//
//   Stream<int> get count => _counterController.stream;
//
//   void increment() {
//     _counter++;
//     _counterController.sink.add(_counter);
//   }
//
//   void dispose() {
//     _counterController.close();
//   }
// }

// class MyHomePageInheritedWidget extends InheritedWidget {
//   const MyHomePageInheritedWidget(
//       {Key? key,
//       required Widget child,
//       required this.data,
//       required this.counter})
//       : super(key: key, child: child);
//
//   final MyHomePageState data;
//   final int counter;
//
//   //MyHomePageStateとupdateShouldNotifyはInheritedWidgetを定義する上での決まり文句
//
//   static MyHomePageState of(BuildContext context, {bool listen = true}) {
//     if (listen) {
//       return (context
//               .dependOnInheritedWidgetOfExactType<MyHomePageInheritedWidget>())!
//           .data;
//     } else {
//       return (context
//               .getElementForInheritedWidgetOfExactType<
//                   MyHomePageInheritedWidget>()!
//               .widget as MyHomePageInheritedWidget)
//           .data;
//     }
//   }
//
//   @override
//   bool updateShouldNotify(MyHomePageInheritedWidget oldWidget) {
//     return counter != oldWidget.counter;
//   }
// }
