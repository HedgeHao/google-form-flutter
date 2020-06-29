import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class FinishPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0EBF8),
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
    );
  }
}

class FormContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = ModalRoute.of(context).settings.arguments;
    Size size = MediaQuery.of(context).size;
    double contentWidth = size.width <= 650 ? size.width : 650;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.topLeft,
          children: [
            Container(
              width: contentWidth,
              height: 150,
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
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0)),
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(top: 25, left: 12),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 32),
                )),
            Padding(
                padding: EdgeInsets.only(top: 90, left: 12),
                child: Text(
                  '我們已經收到您回覆的表單。',
                  style: TextStyle(fontSize: 16),
                )),
            Padding(
                padding: EdgeInsets.only(top: 130, left: 12),
                child: InkWell(
                    child: Text(
                      '提交其他回覆',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onTap: () async {
                      await launch('https://docs.google.com/forms/u/0/d/e/1FAIpQLSevLUgYM0t8c6herd9Chx_fvA78esneNY6kMP_1VJxOaLKIFA/formResponse');
                    })),
          ],
        ),
        Row(children: [
          Text(
            'Google 並未認可或建議這項內容。',
            style: TextStyle(color: Colors.grey),
          ),
          InkWell(
              child: Text('檢舉濫用情形', style: TextStyle(color: Colors.grey, decoration: TextDecoration.underline)),
              onTap: () async {
                await launch('https://docs.google.com/forms/u/0/d/e/1FAIpQLSevLUgYM0t8c6herd9Chx_fvA78esneNY6kMP_1VJxOaLKIFA/reportabuse?source=https://docs.google.com/forms/d/e/1FAIpQLSevLUgYM0t8c6herd9Chx_fvA78esneNY6kMP_1VJxOaLKIFA/viewform');
              }),
          Text('-', style: TextStyle(color: Colors.grey)),
          InkWell(
              child: Text('服務條款', style: TextStyle(color: Colors.grey, decoration: TextDecoration.underline)),
              onTap: () async {
                await launch('https://policies.google.com/terms');
              }),
          Text('-', style: TextStyle(color: Colors.grey)),
          InkWell(
              child: Text('隱私權政策', style: TextStyle(color: Colors.grey, decoration: TextDecoration.underline)),
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
  }
}
