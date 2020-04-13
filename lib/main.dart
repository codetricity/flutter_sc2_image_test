import 'package:flutter/material.dart';
import 'package:imagetest/download_ready.dart';
import 'last_file.dart';
import 'get_exposure_delay.dart';
import 'set_exposure_delay_five.dart';
import 'set_exposure_delay_zero.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'THETA SC2 Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'THETA SC2 Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String url = 'https://picsum.photos/200';
  Color selfTimerButtonColor = Colors.blueGrey;

  void _getPicture() async {
    await downloadReady();
    String tempUrl = await lastFile();
    setState(() {
      url = tempUrl;
    });
  }

  void _getExposureDelay() async {
    int currentExposureDelay = await getExposureDelay();
    if (currentExposureDelay == 0 ) {
      print('setting exposure delay');
      await setExposureDelayFive();
    } else {
      print('disabling exposure delay');
      await setExposureDelayZero();
    }
    setState(() {
      if (currentExposureDelay == 0) {
        selfTimerButtonColor = Colors.blue;
        print(currentExposureDelay);
      } else {
        selfTimerButtonColor = Colors.blueGrey;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(url),
            Text(
              'hello',
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(
              height: 100.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FloatingActionButton(
                  tooltip: 'Self-Timer',
                  onPressed: _getExposureDelay,
                  backgroundColor: selfTimerButtonColor,
                  child: Icon(
                    Icons.timer,
                  ),
                ),
                FloatingActionButton(
                  onPressed: _getPicture,
                  tooltip: 'Take Picture',
                  child: Icon(Icons.camera_enhance),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
