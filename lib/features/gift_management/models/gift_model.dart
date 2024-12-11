import 'package:hedyety/Repository/local_database.dart';

class GiftModel {
  int? id;
  String? name;
  String? description;
  String? category;
  String? price;
  String? status;
  int? eventId;
  static LocalDatabse mydb = LocalDatabse();

  static addGift(String name, String description, String category, String price,
      int eventId) async {
    try {
      int res = await mydb.insertData(
          '''INSERT INTO 'GIFTS' ('NAME','DESCRIPTION', 'CATEGORY', 'PRICE', 'EVENTSID')
        VALUES ("${name}","${description}",
        "${category}", "${price}", "${eventId}")''');

      return res;
    } catch (e) {
      print('error in add Event $e');
      return null;
    }
  }

  static editGift(String name, String description, String category,
      String price, int eventId) async {
    try {
      int res = await mydb.updateData('''UPDATE 'GIFTS' SET 
                              'NAME' = "${name}",
                              'DESCRIPTION' = "${description}",
                              'CATEGORY' = "${category}", 
                              'PRICE' = "${price}"
                              WHERE ID= "${eventId}"''');
      return res;
    } catch (e) {
      print('error in add Event $e');
      return null;
    }
  }

  static getGifts(eventId) async {
    try {
      List<Map> res = await mydb.readData("SELECT * FROM 'GIFTS' WHERE EVENTSID = $eventId");
      return res;
    } catch (e) {
      print('error in getGifts $e');
    }
  }

   static deleteGift(int id) async {
    try {
      int res = await mydb.deleteData("DELETE FROM GIFTS WHERE ID=$id");
      return res;
    } catch (e) {
      print('error in deleteGift$e');
      return null;
    }
  }

}