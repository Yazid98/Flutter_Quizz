import 'package:flutter/material.dart';
import 'package:flutter_quizz/custom_text.dart';
import 'package:flutter_quizz/question.dart';

import 'datas.dart';

class QuizzPage extends StatefulWidget{
  @override
  QuizzPageState createState() => QuizzPageState();
}

class QuizzPageState extends State<QuizzPage>{
  List<Question> questions = Datas().listeQuestions;
  int index = 0;
  int score = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final Question question = questions[index];
   return Scaffold(
      appBar: AppBar(
        title: Text('Score : $score'),
      ),
     body: Center(
       child: Card(
         margin: EdgeInsets.all(8),
         child: Padding(
           padding: EdgeInsets.all(8),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Custom_text_style( data: "Question numéro ${index +1} / ${questions.length}", color: Colors.blue, style: FontStyle.italic,),
               Custom_text_style(data: question.question, size: 21, weight: FontWeight.bold,),
               Image.asset(question.getImage()),
               Row(
                 mainAxisSize: MainAxisSize.max,
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   reponsebtn(false),
                   reponsebtn(true)
                 ],
               )
             ],
           ),
         )
       ),
     ),
   );
  }

  ElevatedButton reponsebtn(bool b){
    return ElevatedButton(
        onPressed: (){
          checkAnswer(b);
        },
        child: Text((b) ? "VRAI": "FAUX"),
        style: ElevatedButton.styleFrom(primary: (b) ? Colors.greenAccent : Colors.redAccent),
    );
  }

  checkAnswer(bool answer){
    final question = questions[index];
    bool bonneReponse = (question.reponse == answer);

    if(bonneReponse){
      setState(() {
        score++;
      });
    }
    showAnswerExplication(bonneReponse);
  }

  Future<void> showAnswerExplication(bool bonneReponse) async {
    String title = (bonneReponse)? "C'est gagné !" : "Raté !";
    String imageToShow = (bonneReponse)? "vrai.jpg": "faux.jpg";
    String path = "images/$imageToShow";
    Question question = questions[index];
   return await showDialog(
       barrierDismissible: false,
       context: context,
       builder: (BuildContext context){
        return SimpleDialog(
          title: Custom_text_style(data: title,),
          children: [
            Image.asset(path),
            Custom_text_style(data: question.explication),
            TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                  toNextQuestion();
                },
                child: Custom_text_style( data: "Passer à la question suivante !",))
          ],
        );
       });
  }

  Future<void> showResult() async {
    return await showDialog(
      barrierDismissible: false,
        context: context,
        builder: (BuildContext context ){
          return AlertDialog(
            title: Custom_text_style(data: "C'est fini !",),
            content: Custom_text_style(data: "Votre score est de : $score points",),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Custom_text_style(data: "OK",) )
            ],
          );
        });
  }

  void toNextQuestion(){
    if (index < questions.length -1 ){
      index++;
      setState(() {
      });
    }else{
      showResult();
    }
  }
}