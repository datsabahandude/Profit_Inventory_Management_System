class UserModel {
  String? uid;
  String? email;
  String? username;
  String? shopname;
  String? joindate;

  UserModel({this.uid, this.email, this.username, this.shopname, this.joindate});

  //retrieve data from server
factory UserModel.fromMap(map){
  return UserModel(
    uid: map['uid'],
    email: map['email'],
    username: map['user name'],
    shopname: map['shop name'],
    joindate: map['Joined at']
  );
}
//send data to server
Map<String, dynamic> toMap(){
  return {
    'uid' : uid,
    'email' : email,
    'user name' : username,
    'shop name' : shopname,
    'Joined at' : joindate,
  };
}

}