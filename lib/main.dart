import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: App(),
    );
  }
}

class App extends StatefulWidget
{
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final myController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }
  void convertToSarcasm()
  {
    String text = myController.text;
    print(text);
    String newText = "";
    for(var i=0;i<text.length;i++)
      {
        if(isAlpha(text[i]))
          if(i%2==0)
            newText+=text[i].toUpperCase();
          else
            newText+=text[i].toLowerCase();
        else
          newText+=text[i];
      }
    myController.text=newText;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.red,
        title: Text('SaRcAsM FoNt'),
        centerTitle: true,

      ),
      body: Builder(
        builder: (BuildContext context) {
          return Container(
            color: Colors.white24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Flexible(
                  flex: 10,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 50.0),
                    child: TextField(
                      controller: myController,
                      decoration: InputDecoration(
                          labelText: 'Sarcasm Text',
                          fillColor: Colors.blue,
                          border: OutlineInputBorder(

                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide()
                          )
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 5,
                  child: MaterialButton(onPressed: convertToSarcasm,
                    color: Colors.blueAccent,
                    child: Text("CHANGE TEXT", style: TextStyle(
                        color: Colors.white
                    ),),
                  ),
                ),
                Flexible(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: MaterialButton(onPressed: () async {
                      await ClipboardManager.copyToClipBoard(myController.text);
                      final snackbar = SnackBar(
                        content: Text('Copied to Clipboard'),
                      );
                      Scaffold.of(context).showSnackBar(snackbar);
                    },
                      color: Colors.blueAccent,

                      child: Text("COPY TO CLIPBOARD", style: TextStyle(

                          color: Colors.white
                      ),),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
    ),
    );
  }
}
