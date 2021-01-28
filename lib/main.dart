import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  static const title = 'Flutter App';
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: title,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      );
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(App.title)),
        body: Center(child: ClickImage(imageAsset: 'assets/kitten_blog.jpg', width: 100)),
      );
}

class ClickImage extends StatelessWidget {
  final String imageAsset;
  final double width;
  const ClickImage({@required this.imageAsset, @required this.width});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => Navigator.push<void>(
          context,
          MaterialPageRoute(builder: (context) => FullScreenImage(imageAsset: imageAsset)),
        ),
        child: Hero(
          tag: imageAsset,
          child: Container(width: width, child: Image.asset(imageAsset)),
        ),
      );
}

// from https://stackoverflow.com/questions/60846054/how-open-image-in-full-screen-when-we-click-on-any-image-in-list-in-flutter
class FullScreenImage extends StatelessWidget {
  final String imageAsset;
  const FullScreenImage({@required this.imageAsset});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black87,
        body: FocusScope(
          autofocus: true,
          child: Focus(
            onKey: (node, event) {
              print(event.logicalKey);
              if (event.logicalKey == LogicalKeyboardKey.escape) Navigator.pop(context);
            },
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Center(
                child: Hero(
                  tag: imageAsset,
                  child: Image.asset(imageAsset, width: MediaQuery.of(context).size.width, fit: BoxFit.contain),
                ),
              ),
            ),
          ),
        ),
      );
}
