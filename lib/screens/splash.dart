import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo/screens/homePage.dart';

class Splash extends StatefulWidget {
  Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // check();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Future<bool> askpermission() async {
    const platformMethodChannel =
        const MethodChannel('com.example.todos.callLogs');
    try {
      final dynamic result =
          await platformMethodChannel.invokeMethod('getpermissionscall');
      print(result);

      try {
        final dynamic result = await platformMethodChannel
            .invokeMethod('getpermissionscontactsread');
        print(result);

        try {
          final dynamic result = await platformMethodChannel
              .invokeMethod('getpermissionscontactswrite');
          print(result);
          return true;
        } catch (e) {
          return false;
        }

        return result;
      } on PlatformException catch (e) {
        return false;
      }
    } on PlatformException catch (e) {
      // contact = ["Can't fetch ${e.message}."];
      return false;
    }
  }

  // check() async {
  //   bool a = await askpermission();
  //   if (a) {
  //     Navigator.of(context)
  //         .push(MaterialPageRoute(builder: (context) => HomePage()));
  //   } else {
  //     print("Check denied");
  //   }
  // }
}
