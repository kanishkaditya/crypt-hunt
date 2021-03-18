import 'package:bountyhunt/LinkPage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: MyHomePage(title: 'Buonty Hunt'),
    routes: {
        'LinkPage':(context)=>LinkPage()
    },
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
  File _image;
  ImagePicker picker = ImagePicker();
  String api_key = 'acc_eee2dbca96b79af';
  String api_secret = 'b11b65b561971d2c0db77f75d34b2545';
  String basicAuth = 'Basic ' +
      base64Encode(
          utf8.encode('acc_eee2dbca96b79af:b11b65b561971d2c0db77f75d34b2545'));
  var data;
  Future<void> upload() async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://api.imagga.com/v2/tags'));
    request.files.add(await http.MultipartFile.fromPath('image', _image.path));
    request.headers.addAll(<String, String>{'authorization': basicAuth});
    var res = await request.send();
    data = jsonDecode(await res.stream.bytesToString());
    print(data['result']['tags']);
  }

  void takePhoto() async {
    final PickedFile = await picker.getImage(source: ImageSource.camera);
    if (PickedFile != null) {
      setState(() {
        _image = File(PickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[300],
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Image(
                  image: _image == null
                      ? AssetImage("assets/images/imager.png")
                      : FileImage(_image)),
            ),
            FlatButton(
                onPressed: () {
                  takePhoto();
                },
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.black54,
                  size: 50,
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[400],
        onPressed: () {
          int i;
          upload().then((value) async {
            for (i = 0; i < (data['result']['tags']).length; i++) {
              if (data['result']['tags'][i]['tag']['en'] == 'sofa') {
                Navigator.pushReplacementNamed(context, 'LinkPage');
                //await launch('www.google.com');
                break;
              }
            }

            if (i == (((data['result']['tags']).length) - 1)) {
              print(i);
            }
          });
        },
        tooltip: 'Upload',
        child: Icon(
          Icons.send,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
