class FeedbackModel {
  String? uid;
  String? email;
  String? username;
  String? shopname;
  String? date;
  String? title;
  String? detail;

  FeedbackModel({this.uid, this.email, this.username, this.shopname, this.detail, this.title, this.date});

//send data to server
  Map<String, dynamic> toMap(){
    return {
      'Title' : title,
      'Details' : detail,
      'uid' : uid,
      'email' : email,
      'user name' : username,
      'shop name' : shopname,
      'Date' : date,

    };
  }

}