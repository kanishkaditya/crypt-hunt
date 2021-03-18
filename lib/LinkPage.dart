import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LinkPage extends StatelessWidget {
  final String link = 'link';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Padding(padding:EdgeInsets.only(top: 100),child: Image.asset('assets/images/c.png'))
            ,Padding(padding:EdgeInsets.only(top:400,left:110),
              child: Text('Riddle solved',style: TextStyle(fontSize: 30,fontFamily:'Countryside' ),),
    ),
            Padding(padding: EdgeInsets.only(top:500,left:180),
    child:Row(children:[
      Text(link),
      InkWell(onTap: (){
        Clipboard.setData(ClipboardData(text:link))
            .then((value) => {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Text copied, kindly paste this link in your browser'),backgroundColor: Colors.amber,))
        });
      },
          child: ImageIcon(AssetImage('assets/images/copy.png'),)
      )
    ]))
          ],

        ),
      );
  }
}
