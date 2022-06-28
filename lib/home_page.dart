import 'dart:async';
import 'package:bird_game/barriers.dart';
import 'package:bird_game/bird.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  static double birdYaxis=0;
  double time=0;
  double height=0;
  double initialHeight=birdYaxis;
  bool gameHasStarted=false;
  static double barrierXOne=2;
  double barrierXTwo=barrierXOne+2;
  double score=0;
  double highScore=0;
  void jump(){
    setState(() {
      time =0;
      initialHeight=birdYaxis;
    });
  }
  void startGame(){
    gameHasStarted=true;
    Timer.periodic(const Duration(milliseconds: 60), (timer) {
      time +=0.05;
      height= -4.9 *time * time +2.8 *time;
      setState(() {
        birdYaxis =initialHeight-height;
      });
      setState(() {
        if(barrierXOne<-2){
          barrierXOne+=4;
        }
        else{
          barrierXOne-=0.05;
        }
      });
      setState(() {
        if(barrierXTwo<-2){
          barrierXTwo+=4;
        }
        else{
          barrierXTwo-=0.05;
        }
      });
      if (birdYaxis >1){
        timer.cancel();
        gameHasStarted=false;
      }
    });
  }
  void _showDialog(){
    showDialog(
      context :context,
      builder: (BuildContext context){
        return AlertDialog(
          backgroundColor: Colors.brown,
          title: const Text('Game over',style: TextStyle(color: Colors.white),),
          content: Text(
              'score$score',
            style: const TextStyle(color: Colors.white),
              ),
          actions: [
            TextButton(
                onPressed: (){
                  if(score>highScore){
                    highScore=score;
                  }
                  initState();
                  setState((){
                    gameHasStarted=false;
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('Play again',style: TextStyle(color: Colors.white),)),

          ],
        );
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(gameHasStarted){
          jump();
        }
        else{
          startGame();
        }
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'images/color.jpg',
              ),
              fit: BoxFit.cover,
            )
          ),
          child: Column(
            children: [
              Expanded(
                  flex: 4,
                  child: Stack(
                    children: [
                      AnimatedContainer(
                        alignment: Alignment(0,birdYaxis),
                        duration: const Duration(milliseconds: 0),
                        child: const MyBird(),
                      ),
                      AnimatedContainer(
                        alignment: Alignment(barrierXOne,1.1),
                        duration: const Duration(milliseconds: 0),
                        child: MyBarriers(
                          size: 200.0,
                        ),
                      ),
                      AnimatedContainer(
                        alignment: Alignment(barrierXOne,-1.1),
                        duration: const Duration(milliseconds: 0),
                        child: MyBarriers(
                          size: 200.0,
                        ),
                      ),
                      AnimatedContainer(
                        alignment: Alignment(barrierXTwo,1.1),
                        duration: const Duration(milliseconds: 0),
                        child: MyBarriers(
                          size: 150.0,
                        ),
                      ),
                      AnimatedContainer(
                        alignment: Alignment(barrierXTwo,-1.1),
                        duration: const Duration(milliseconds: 0),
                        child: MyBarriers(
                          size: 250.0,
                        ),
                      ),
                    ],
                  )
              ),
              Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Score',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            '0',
                            style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'High Score',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            '10',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
