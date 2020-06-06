import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'story_brain.dart';
import 'package:flutter/animation.dart';

void main() => runApp(Destini());

class Destini extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: StoryPage(),
    );
  }
}

class StoryPage extends StatefulWidget {
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> with TickerProviderStateMixin {
  StoryBrain storyBrain = StoryBrain();

  AnimationController controller;
  Animation animation;
  final AudioCache player = AudioCache();
  _asyncAnimation() async {
    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    //this will start the animation
    await controller.forward();
  }

  _playSound() {
    final AudioCache player = AudioCache();
    player.loop('mistery.wav');
  }

  @override
  initState() {
    super.initState();
    _asyncAnimation();
    _playSound();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/forest.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4), BlendMode.darken)),
        ),
        padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 15.0),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 12,
                child: Center(
                  child: FadeTransition(
                    opacity: animation,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        storyBrain.getStory(),
                        style: TextStyle(fontSize: 25.0, letterSpacing: 2.0),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: RaisedButton(
                  color: Colors.transparent,
                  onPressed: () {
                    //Choice 1 made by user.
                    setState(() {
                      storyBrain.nextStory(1);
                      _asyncAnimation();
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFE57373),
                            Color(0xFFD32F2F),
                            Color(0xFFD50000),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(color: Colors.white, spreadRadius: 2)
                        ],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0))),
                    child: Text(
                      storyBrain.getChoice1(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                flex: 2,
                child: Visibility(
                  visible: storyBrain.buttonShouldBeVisible(),
                  child: RaisedButton(
                    color: Colors.transparent,
                    onPressed: () {
                      //Choice 2 made by user.
                      setState(() {
                        storyBrain.nextStory(2);
                        _asyncAnimation();
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFFDD835),
                              Color(0xFFF9A825),
                              Color(0xFFFF6F00),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(color: Colors.white, spreadRadius: 2)
                          ],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0))),
                      child: Text(
                        storyBrain.getChoice2(),
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
