import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

import 'package:google_forms_ui/models.dart';

List<int> selectedAnswer;
double contentWidth;

void main() {
  runApp(MyApp());
}

Future<QuestionModel> loadData(BuildContext context) async {
  String content = await DefaultAssetBundle.of(context).loadString('assets/data.json');
  return QuestionModel.fromJson(json.decode(content));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '資訊安全評量',
        home: Scaffold(
          backgroundColor: Colors.grey[100],
          body: Row(
            children: [
              Spacer(),
              SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: FormContent(),
              )),
              Spacer(),
            ],
          ),
        ));
  }
}

class FormContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    contentWidth = size.width <= 650 ? size.width : 650;
    return FutureBuilder(
        future: loadData(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            QuestionModel q = snapshot.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    Container(
                      width: contentWidth,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.purple[800],
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Container(
                          width: contentWidth,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0)),
                          ),
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 25, left: 12),
                        child: Text(
                          q.title,
                          style: TextStyle(fontSize: 32),
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 80, left: 12),
                        child: Text(
                          '* 必填',
                          style: TextStyle(fontSize: 16, color: Colors.red),
                        ))
                  ],
                ),
                QuestionList(q.ques),
                Container(
                    width: contentWidth,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          color: Colors.purple,
                          child: Text('提交', style: TextStyle(color: Colors.white)),
                          onPressed: () {},
                        ),
                        Spacer()
                      ],
                    )),
                Row(children: [
                  Text(
                    'Google 並未認可或建議這項內容。',
                    style: TextStyle(color: Colors.grey),
                  ),
                  InkWell(
                      child: Text('檢舉濫用情形', style: TextStyle(color: Colors.grey)),
                      onTap: () async {
                        await launch(
                            'https://docs.google.com/forms/u/0/d/e/1FAIpQLSevLUgYM0t8c6herd9Chx_fvA78esneNY6kMP_1VJxOaLKIFA/reportabuse?source=https://docs.google.com/forms/d/e/1FAIpQLSevLUgYM0t8c6herd9Chx_fvA78esneNY6kMP_1VJxOaLKIFA/viewform');
                      }),
                  Text('。'),
                  InkWell(
                      child: Text('服務條款', style: TextStyle(color: Colors.grey)),
                      onTap: () async {
                        await launch('https://policies.google.com/terms');
                      }),
                  Text('。'),
                  InkWell(
                      child: Text('隱私權政策', style: TextStyle(color: Colors.grey)),
                      onTap: () async {
                        await launch('https://policies.google.com/privacy');
                      }),
                ]),
                InkWell(
                    child: Text('Google 表單', style: TextStyle(color: Colors.grey, fontSize: 24)),
                    onTap: () async {
                      await launch('https://www.google.com/forms/about/?utm_source=product&utm_medium=forms_logo&utm_campaign=forms');
                    })
              ],
            );
          } else {
            return Container();
          }
        });
  }
}

class QuestionList extends StatelessWidget {
  final List<Ques> q;

  QuestionList(this.q) {
    selectedAnswer = List<int>(this.q.length);
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return Column(
        children: q.map((e) {
      return Question(e, index);
    }).toList());
  }
}

class Question extends StatelessWidget {
  final Ques ques;
  final int quesIndex;

  Question(this.ques, this.quesIndex);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Container(
            width: contentWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    Text(this.ques.content),
                    SelectionGroup(this.ques.options, quesIndex),
                  ],
                ))));
  }
}

class SelectionGroup extends StatefulWidget {
  final List<String> selections;
  final int ques_num;

  SelectionGroup(this.selections, this.ques_num);

  SelectionGroupState createState() => SelectionGroupState();
}

class SelectionGroupState extends State<SelectionGroup> {
  int groupValue;

  void initState() {
    super.initState();
    this.groupValue = -1;
  }

  void updateGroupValue(int v) {
    print('Radio Click:' + v.toString());
    setState(() {
      selectedAnswer[widget.ques_num] = v;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    for (int i = 0; i < widget.selections.length; i++) {
      widgets.add(Row(
        children: [
          Radio(
              value: i, // start from 1
              groupValue: selectedAnswer[widget.ques_num] == null ? '' : selectedAnswer[widget.ques_num],
              activeColor: Colors.purple,
              onChanged: (value) {
                updateGroupValue(value);
              }),
          Text(widget.selections[i])
        ],
      ));
    }
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.start,
      children: widgets,
    );
  }
}
