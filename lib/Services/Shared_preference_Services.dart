import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceServices{

 static Future<void> SaveEmail(String email) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('user_email', email);
 }
 static Future<String?> GetString() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('user_email');
 }
 static Future<void> SaveUid(String uid) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('user_uid', uid);
 }
 static Future<String?> GetUid() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('user_uid');
 }

}