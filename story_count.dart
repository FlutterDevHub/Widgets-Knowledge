import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Story Count Horizontal List',
      home: const MyClass(),
    );
  }
}

class MyClass extends StatelessWidget {
  const MyClass({super.key});

  final List<Map<String, dynamic>> users = const [
    {
      'isAdd': true,
      'storyCount': 0,
      'seenCount': 0,
      'image':
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200',
    },
    {
      'isAdd': false,
      'storyCount': 3,
      'seenCount': 1,
      'image':
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200',
    },
    {
      'isAdd': false,
      'storyCount': 2,
      'seenCount': 0,
      'image':
          'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?w=200',
    },
    {
      'isAdd': false,
      'storyCount': 5,
      'seenCount': 2,
      'image':
          'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=200',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: users.length,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemBuilder: (context, index) {
              final user = users[index];
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    user['isAdd']
                        ? CircleAvatar(
                          radius: 28,
                          backgroundImage: NetworkImage(user['image']),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.black,
                              child: const Icon(
                                Icons.add,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                        : StoryCount(
                          radius: 28,
                          numberOfStatus: user['storyCount'],
                          indexOfSeenStatus: user['seenCount'],
                          spacing: 12,
                          strokeWidth: 2,
                          centerImageUrl: user['image'],
                          padding: 3,
                          unSeenColor: Colors.deepOrange,
                          seenColor: Colors.grey,
                        ),
                    if (!user['isAdd'] && user['storyCount'] > 0)
                      Positioned(
                        top: -4,
                        right: -4,
                        child: CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.red,
                          child: Text(
                            '${user['storyCount']}',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class StoryCount extends StatelessWidget {
  final int numberOfStatus;
  final int indexOfSeenStatus;
  final double spacing;
  final double radius;
  final double padding;
  final String centerImageUrl;
  final double strokeWidth;
  final Color seenColor;
  final Color unSeenColor;

  StoryCount({
    this.numberOfStatus = 10,
    this.indexOfSeenStatus = 0,
    this.spacing = 10.0,
    this.radius = 50,
    this.padding = 5,
    required this.centerImageUrl,
    this.strokeWidth = 4,
    this.seenColor = Colors.grey,
    this.unSeenColor = Colors.blue,
  }) : assert(centerImageUrl != null, "Please provide centerImageUrl");

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: radius * 2,
            height: radius * 2,
            child: CustomPaint(
              painter: Arc(
                alreadyWatch: indexOfSeenStatus,
                numberOfArc: numberOfStatus,
                spacing: spacing,
                strokeWidth: strokeWidth,
                seenColor: seenColor,
                unSeenColor: unSeenColor,
              ),
            ),
          ),
          CircleAvatar(
            radius: radius - padding,
            backgroundImage: NetworkImage(centerImageUrl),
          ),
        ],
      ),
    );
  }
}

class Arc extends CustomPainter {
  final int numberOfArc;
  final int alreadyWatch;
  final double spacing;
  final double strokeWidth;
  final Color seenColor;
  final Color unSeenColor;
  Arc({
    required this.numberOfArc,
    required this.alreadyWatch,
    required this.spacing,
    required this.strokeWidth,
    required this.seenColor,
    required this.unSeenColor,
  });

  double doubleToAngle(double angle) => angle * pi / 180.0;

  void drawArcWithRadius(
    Canvas canvas,
    Offset center,
    double radius,
    double angle,
    Paint seenPaint,
    Paint unSeenPaint,
    double start,
    double spacing,
    int number,
    int alreadyWatch,
  ) {
    for (var i = 0; i < number; i++) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        doubleToAngle((start + ((angle + spacing) * i))),
        doubleToAngle(angle),
        false,
        alreadyWatch - 1 >= i ? seenPaint : unSeenPaint,
      );
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2.0, size.height / 2.0);
    final double radius = size.width / 2.0;
    double angle = numberOfArc == 1 ? 360.0 : (360.0 / numberOfArc - spacing);
    var startingAngle = 270.0;

    Paint seenPaint =
        Paint()
          ..strokeCap = StrokeCap.round
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke
          ..color = seenColor;

    Paint unSeenPaint =
        Paint()
          ..strokeCap = StrokeCap.round
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke
          ..color = unSeenColor;

    drawArcWithRadius(
      canvas,
      center,
      radius,
      angle,
      seenPaint,
      unSeenPaint,
      startingAngle,
      spacing,
      numberOfArc,
      alreadyWatch,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
