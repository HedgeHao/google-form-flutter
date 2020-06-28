class QuestionModel {
  String title;
  List<Ques> ques;

  QuestionModel({this.title, this.ques});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['ques'] != null) {
      ques = new List<Ques>();
      json['ques'].forEach((v) {
        ques.add(new Ques.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.ques != null) {
      data['ques'] = this.ques.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ques {
  String content;
  List<String> options;
  bool mustAnswer;

  Ques({this.content, this.options, this.mustAnswer});

  Ques.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    options = json['options'].cast<String>();
    mustAnswer = json['mustAnswer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['options'] = this.options;
    data['mustAnswer'] = this.mustAnswer;
    return data;
  }
}
