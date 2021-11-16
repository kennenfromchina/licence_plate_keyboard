import 'package:cool_ui/cool_ui.dart';
import 'package:flutter/material.dart';
import 'package:licence_plate_keyboard/licence_plate_keyboard.dart';
import 'package:licence_plate_keyboard_example/custom_keyboard.dart';

void main() {
  LicencePlateKeyboard.register();
  runMockApp(KeyboardRootWidget(child: MyApp())); // 新的
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return WeuiToastConfig(
      data: WeuiToastConfigData(successText: '测试ConfigData'),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title = ''}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              title: Text("CustomKeyboardEvent"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CustomKeyboardDemo()));
              },
            ),
          ],
        ));
  }
}
