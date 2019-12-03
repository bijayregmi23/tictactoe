import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}


class _HomepageState extends State<Homepage> {

//link up images
AssetImage circle=AssetImage('images/circle.png');
AssetImage cross=AssetImage('images/cross.png');
AssetImage edit=AssetImage('images/edit.png');

bool iscross=true;
String message;
List<String> gameState;

//initialise the state of box empty
@override
void initState(){
  super.initState();
  setState(() {
   this.gameState=[
      'empty',
      'empty',
      'empty',
      'empty',
      'empty',
      'empty',
      'empty',
      'empty',
      'empty',
   ];
   this.message='';
  });
}
//playGame Method
void playGame(int index){
    if(this.gameState[index]=='empty'){
    setState(() {
    if(this.iscross){
        this.gameState[index]='Cross';
  //      this.iscross=false;
    }
    else{
      this.gameState[index]='Circle';
  //     this.iscross=true;
    }
    this.iscross=!this.iscross;
    this.checkWin();
    });
  }
}
//reset game method
void resetGame(){
  setState(() {
   this.gameState=[
      'empty',
      'empty',
      'empty',
      'empty',
      'empty',
      'empty',
      'empty',
      'empty',
      'empty',
   ];
   this.message='';
  });
}
//get image method
AssetImage getImage(String value){
  switch (value) {
    case ('empty'): return edit;
      break;
    case ('Cross'): return cross;
      break;
    case ('Circle'): return circle;
      break;    
  }
}
// reset game automatically
timeDelay(){
  Future.delayed(const Duration(milliseconds: 2000), () {
    resetGame();
});
}
//check for win logic
checkWin(){
  if((gameState[0]!='empty') &&
      (gameState[0]==gameState[1]) &&
      (gameState[1]==gameState[2])){
        setState(() {
          this.message='${this.gameState[0]} Wins';
        });
        timeDelay();
      }
  else if((gameState[3]!='empty') &&
      (gameState[3]==gameState[4]) &&
      (gameState[4]==gameState[5])){
        setState(() {
          this.message='${this.gameState[3]} Wins';
        });
        timeDelay();
      }
  else if((gameState[6]!='empty') &&
      (gameState[6]==gameState[7]) &&
      (gameState[7]==gameState[8])){
        setState(() {
          this.message='${this.gameState[6]} Wins';
        });
        timeDelay();
      }
  else if((gameState[0]!='empty') &&
      (gameState[0]==gameState[3]) &&
      (gameState[3]==gameState[6])){
        setState(() {
          this.message='${this.gameState[0]} Wins';
        });
        timeDelay();
      }
  else if((gameState[1]!='empty') &&
      (gameState[1]==gameState[4]) &&
      (gameState[4]==gameState[7])){
        setState(() {
          this.message='${this.gameState[1]} Wins';
        });
        timeDelay();
      }
  else if((gameState[2]!='empty') &&
      (gameState[2]==gameState[5]) &&
      (gameState[5]==gameState[8])){
        setState(() {
          this.message='${this.gameState[2]} Wins';
        });
        timeDelay();
      }
  else if((gameState[0]!='empty') &&
      (gameState[0]==gameState[4]) &&
      (gameState[4]==gameState[8])){
        setState(() {
          this.message='${this.gameState[0]} Wins !';
        });
        timeDelay();
      }
  else if((gameState[2]!='empty') &&
      (gameState[2]==gameState[4]) &&
      (gameState[4]==gameState[6])){
        setState(() {
          this.message='${this.gameState[2]} Wins !';
        });
        timeDelay();
      }
  else if(!gameState.contains('empty')){
    setState(() {
      this.message='Game Draw !';
    });
        timeDelay();
  }    
}

Future <void> showExitDialog(){
  
        return showDialog(
        context: context,
        builder: (BuildContext context){
          
          return AlertDialog(

            backgroundColor: Colors.blueGrey,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            content: SizedBox(
                  height: 120,
                  width: 300,

                  child:Container(                      
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text('Close the app ?',
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                          ),
                        ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20,10,20,10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  RaisedButton(
                                    color: Color(0xFFadffbd),
                                    padding: EdgeInsets.fromLTRB(20,10,20,10),
                                    child: Text('No',
                                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                                    ),
                                    onPressed: () =>Navigator.of(context, rootNavigator: true).pop(AlertDialog),
                                  ),
                                  RaisedButton(
                                    color: Color(0xFFfcaca9),
                                    padding: EdgeInsets.fromLTRB(20,10,20,10),
                                    child: Text('Yes',
                                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                                    ),
                                    onPressed: () => exit(0),
                                  ),
                                ],
                              ),
                            )
                      ],
                  ),
                  ),
            )
          );
        }
      );  
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFFE1F5FE),
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
        backgroundColor: Color(0xFF116e4f),
        leading: IconButton(icon: Icon(Icons.close),onPressed: showExitDialog,),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(40),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                crossAxisSpacing: 7.0,
                mainAxisSpacing: 7.0,
              ),
              itemCount: this.gameState.length,
              itemBuilder: (context, i) => MaterialButton(
                  padding: EdgeInsets.all(5),
                  color: Color(0xFF78ffe4),
                  onPressed: (){
                    playGame(i);
                  },
                  child: Center(

                      child: Image(
                      image: getImage(this.gameState[i]),
                    )
                  ),
                ),
              ),
            ),
          Container(
            child: Text(this.message,
            style: TextStyle(
              color: Colors.deepOrange,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,      
              ),
            ),
            padding: EdgeInsets.all(30),
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0),
            ),
            onPressed: (){
              resetGame();
            },
            child: Text(
              'RESET',
              style: TextStyle(
                color: Colors.lightBlueAccent,
              ),
            ),
            padding: EdgeInsets.fromLTRB(40.0, 30.0, 40.0, 30.0),
            color: Colors.purple,
          ),
          Container(
            child: Text(
                'Devloped By Bijay',
                style: TextStyle(
                  color: Color(0xFFd65e22),
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              padding: EdgeInsets.fromLTRB(5, 40, 5, 30),
          ),
        ],
      ),
    );
  }
}