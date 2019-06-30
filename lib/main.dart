import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Info Button',
      theme: ThemeData(
        accentColor: Colors.black,
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Info Button'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  bool infoOpened = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 700),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
      ),
      body: Center(
        child: SizedBox(
          height: 300.0,
          width: 400.0,
          child: Stack(
            children: <Widget>[
              LandscapeCard(),
              AnimatedBuilder(
                animation: _controller,
                child: InfoCard(),
                builder: (ctx, child) {
                  return ClipOval(
                    clipper: InfoCardClipper(
                      animation: _controller,
                    ),
                    child: child,
                  );
                },
              ),
              Align(
                alignment: Alignment(0.97, -0.97),
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (ctx, child) {
                    return FloatingActionButton(
                      elevation: 12.0,
                      onPressed: _infoButtonClick,
                      tooltip: infoOpened ? 'Close' : 'Info',
                      child:
                          Icon(infoOpened ? Icons.close : Icons.info_outline),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _infoButtonClick() {
    if (_controller.isAnimating) {
      return;
    }
    if (_controller.status == AnimationStatus.completed) {
      _controller.reverse();
      infoOpened = false;
    } else {
      _controller.forward();
      infoOpened = true;
    }
  }
}

class LandscapeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.all(30.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Color(0xFFD0D0D0),
              height: double.infinity,
              width: double.infinity,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 30.0,
                    top: 30.0,
                    child: Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: ShapeDecoration(
                        color: Color(0xFFF2F2F2),
                        shape: CircleBorder(),
                      ),
                    ),
                  ),
                  CustomPaint(
                    painter: MountainCustomPainter(),
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Color(0xFF2F2F2F),
            height: 60.0,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Container(
        color: Colors.black,
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 100.0,
                  width: 100.0,
                  decoration: ShapeDecoration(
                    color: Color(0xFF666666),
                    shape: CircleBorder(),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 20.0,
                      width: 175.0,
                      decoration: ShapeDecoration(
                        color: Color(0xFF333333),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      height: 20.0,
                      width: 80.0,
                      decoration: ShapeDecoration(
                        color: Color(0xFF333333),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              height: 20.0,
              width: double.infinity,
              decoration: ShapeDecoration(
                color: Color(0xFF333333),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              height: 20.0,
              width: double.infinity,
              decoration: ShapeDecoration(
                color: Color(0xFF333333),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              height: 20.0,
              width: 300.0,
              decoration: ShapeDecoration(
                color: Color(0xFF333333),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MountainCustomPainter extends CustomPainter {
  final Paint mountainPaint = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    Path mountainPath = Path()
      ..moveTo(size.width * 0.45, size.height)
      ..lineTo(size.width * 0.5, size.height * 0.96)
      ..lineTo(size.width * 0.6, size.height * 0.94)
      ..lineTo(size.width * 0.725, size.height * 0.96)
      ..lineTo(size.width * 0.8, size.height * 0.91)
      ..lineTo(size.width, size.height * 0.93)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(mountainPath, mountainPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class InfoCardClipper extends CustomClipper<Rect> {
  final Animation<double> animation;

  const InfoCardClipper({@required this.animation});

  @override
  Rect getClip(Size size) {
    return Rect.fromCircle(
      center: Offset(size.width * 0.9, size.height * 0.1),
      radius: size.width * 2 * animation.value,
    );
  }

  @override
  bool shouldReclip(InfoCardClipper oldClipper) {
    return true;
  }
}
