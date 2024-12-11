import 'package:hedyety/Repository/local_database.dart';

class UserModel {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? password;
  bool? prefrence; // notification on/ off

  UserModel({this.name, this.email, this.phone, this.password, this.prefrence});

  static LocalDatabse mydb = LocalDatabse();

  static updateuser(String name, 
  //String email, 
  int pref, int id) async {
    try {
      //  'EMAIL' = "$email",
      int res = await mydb.updateData(
          '''UPDATE 'USERS' SET 'NAME' = "$name",
          'PREFERENCE' = "$pref" WHERE ID= "$id"''');
      print("the value is $res");
    } catch (e) {
      print("Error updating user :( $e");
    }
  }

  static addContact(String name, String phone) async {
    try {
      int res = await mydb.insertData(
          '''INSERT INTO 'USERS' ('NAME','PHONE') VALUES ("$name","$phone")''');
      print('success in addContact $res');
    } catch (e) {
      print(e);
    }
  }

  static getUserByEmail(String email) async {
    try {
      var res = await mydb
          .readData('''SELECT "ID"  FROM USERS WHERE EMAIL="$email"''');
      return res;
    } catch (e) {
      print('error in getUserByEmail $e');
      return null;
    }
  }

  static getUserById(int id) async {
    try {
      List<Map> res =
          await mydb.readData('''SELECT * FROM 'USERS' WHERE ID="$id"''');
      print('getUser $res, id $id');
      return res;
    } catch (e) {
      print('error in getUserById $e');
      return null;
    }
  }

  static getFriends(currentUid) async {
    print('getFriends $currentUid');
    try {
      var res = await mydb.readData(
          '''SELECT FRIENDID FROM 'FRIENDS' WHERE USERID="$currentUid"''');
      List<dynamic> friendIds = res.map((e) {
        return (e['FRIENDID'] as int);
      }).toList();
      print(friendIds);
      List<Map> res2;
      if (friendIds.isNotEmpty) {
        String friendIdList = friendIds.join(', ');
        res2 = await mydb
            .readData('SELECT * FROM USERS WHERE ID IN ($friendIdList)');
      } else {
        res2 = []; // or handle the empty case as needed
      }
      return res2;
    } catch (e) {
      print('error in getFriends $e');
      return null;
    }
  }

  static addUser(
      String username, String email, String phone, String uid) async {
    try {
      int pref = 1;
      int res = await mydb.insertData(
          '''INSERT INTO 'USERS' ('NAME','EMAIL', 'PHONE', 'UID', 'PREFERENCE') VALUES ("$username","$email","$phone","$uid","$pref")''');
      print('addUser $res');
      return res;
    } catch (e) {
      print('error in getFriends $e');
      return null;
    }
  }

  static addFriend(String name, String email, String phone, int id) async {
    try {
      int response = await mydb.insertData(
          '''INSERT INTO 'USERS' ('NAME','EMAIL','PHONE') VALUES ("$name","$email","$phone")''');
      int res = await mydb.insertData(
          '''INSERT INTO 'FRIENDS' ('USERID','FRIENDID') VALUES ("$id","$response")''');
      print("the value is $response");
      return response;
      // '''INSERT INTO 'BC' ('NAME','COMPANY-NAME','EMAIL') VALUES ("${Name.text}","${CompanyName.text}","${Email.text}")''');
    } catch (e) {
      print("Error adding friend :(" + e.toString());
      return null;
    }
  }

  toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'prefrence': true,
    };
  }
}