import 'package:flutter/material.dart';
import 'recipe.dart';
import 'RecipeDetail.dart';

void main() {
  runApp(RecipeApp());
}

class RecipeApp extends StatelessWidget {

  // 1
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 2
      title: 'Recipe Calculator',
      theme: ThemeData(
        // 3
        primaryColor: Colors.white,
        accentColor: Colors.black
      ),
      // 4
      home: MyHomePage(title: 'Recipe Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: Recipe.samples.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return RecipeDetail(Recipe.samples[index]);
                    }
                ));
              },
              child: buildRecipeCard(Recipe.samples[index]),
            );
          }
      )
    );
  }
}

Widget buildRecipeCard(Recipe recipe) {
  return Card(
    elevation: 2.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0)
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Image(image: AssetImage(recipe.imageUrl)),
          SizedBox(
            height: 14.0,
          ),
          Text(recipe.label,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
            fontFamily: "Palatino"
          ))
        ],
      ),
    ),
  );
}