import 'dart:async';
import 'dart:convert';
import 'package:healing_hand/PatientPages/PatientSignupPage.dart';
import 'package:healing_hand/modelclass/appoinment.dart';
import 'package:healing_hand/modelclass/prodmodal.dart';
import 'package:healing_hand/modelclass/review.dart';
import 'package:healing_hand/modelclass/userer.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

//import '.dart';

var dd;
var category = "Wall Painting";

class httpServices13 {
  var y = 0;
  final String baseUrl = "https://handy.ludokingatm.com/";
  final String baseUrl1 =
      "https://handy.ludokingatm.com/productshowapi1.php?category=";

  sid() {
    return y;
  }

  Future<List<prodModal>> getAllPost(String key) async {
   // print(key);
    Response res = await get(Uri.parse(
        "http://siddharth1212-63364.portmap.host:63364/healinghand/doctorlist.php?key=$key"));
    if (res.statusCode == 200) {
      print("abhishek");
      List<dynamic> data = jsonDecode(res.body);
      List<prodModal> allPost =
          data.map((dynamic item) => prodModal.fromJson(item)).toList();
     //     print(allPost[6].product1.toString());
     y=allPost.length;
     print(allPost[0].email);
     
      return allPost;
    } else {
      throw "Something Went Wrong";
    }
  }
Future<List<prodModal2>> getAllPost2(String key) async {
    print("haan");
   // print(key);
    Response res = await get(Uri.parse(
        "http://siddharth1212-63364.portmap.host:63364/healinghand/getappoinment.php"));
    if (res.statusCode == 200) {
      //Map<String,dynamic> data1 = jsonDecode(res.body);
      List<dynamic> data = jsonDecode(res.body);
      List<prodModal2> allPost =
          data.map((dynamic item) => prodModal2.fromJson(item)).toList();
          print("gggg");
     //     print(allPost[6].product1.toString());
     y=allPost.length;
     print(y);
      return allPost;
    } else {
      print("gh");
      throw "Something Went Wrong";
    }
  }

  Future<List<prodModal1>> getAllPost3(var e) async {
    Response res = await get(
        Uri.parse("http://siddharth1212-63364.portmap.host:63364/healinghand/getreview.php?key="+e));
    if (res.statusCode == 200) {
      //Map<String,dynamic> data1 = jsonDecode(res.body);

      List<dynamic> data = jsonDecode(res.body);
      List<prodModal1> allPost =
          data.map((dynamic item) => prodModal1.fromJson(item)).toList();
     // print(allPost[0].category);
      y = allPost.length;
      return allPost;
    } else {
      throw "Something Went Wrong";
    }
  }
  Future<List<prodModal3>> getAllPost5(var e) async {
    Response res = await get(
        Uri.parse("http://siddharth1212-63364.portmap.host:63364/healinghand/getuser.php?email="+e));
    if (res.statusCode == 200) {
      //Map<String,dynamic> data1 = jsonDecode(res.body);

      List<dynamic> data = jsonDecode(res.body);
      List<prodModal3> allPost =
          data.map((dynamic item) => prodModal3.fromJson(item)).toList();
     // print(allPost[0].category);
      y = allPost.length;
      return allPost;
    } else {
      throw "Something Went Wrong";
    }
  }

  Future<List<prodModal1>> getAllPost4(var e) async {
    Response res = await get(
        Uri.parse("http://handycraf.000webhostapp.com/helping_hand/getreviews.php?key="+e));
    if (res.statusCode == 200) {
      //Map<String,dynamic> data1 = jsonDecode(res.body);

      List<dynamic> data = jsonDecode(res.body);
      List<prodModal1> allPost =
          data.map((dynamic item) => prodModal1.fromJson(item)).toList();
     // print(allPost[0].category);
      y = allPost.length;
      return allPost;
    } else {
      throw "Something Went Wrong";
    }
  }

  // Future<List<usermeme>> getAllPost1(var ss) async {
  //   Response res = await get(Uri.parse( "https://handycraf.000webhostapp.com/memeapp/fetchuser.php?key="+ss));
  //   if (res.statusCode == 200) {
  //     print(ss);
  //     List<dynamic> data = jsonDecode(res.body);
  //     List<usermeme> allPost =
  //         data.map((dynamic item) => usermeme.fromJson(item)).toList();
    
  //     y = allPost.length;
  //     print(allPost[0].name);
  //     return allPost;
  //   } else {
  //     throw "Something Went Wrong";
  //   }
  // }

  Future deleterecord(String pid) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse("http://handy.ludokingatm.com/productdeleteapi.php"));
    request.fields.addAll({
      'id': pid,
    });
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final q = await response.stream.bytesToString();
      print(q);
      return 0;
    } else {
      print(response.reasonPhrase);
      final g = response.reasonPhrase;
      return 1;
    }
  }

  Future saverec (String email,String phoneno,String date,String time,String status,String purpose) async {
     print(email);
        print(remember);
        print(date);
        print(time);
        print(purpose);
    var request = http.MultipartRequest(
        'POST', Uri.parse("http://siddharth1212-63364.portmap.host:63364/healinghand/appoinment.php"));
    
       
        
    request.fields['umail'] = email;
    request.fields['pmail'] = remember;
    request.fields['startdate'] = date;
  request.fields['enddate']=time;
  request.fields['status']=status;
  request.fields['purpose']=purpose;
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final q = await response.stream.bytesToString();
      print(q);
      return 0;
    } else {
      print(response.reasonPhrase);
      final g = response.reasonPhrase;
      return 1;
    }
  }

  Future saverec1(String pmail,String umail,String review) async {
    print("kkk");
    print(sid);
    var request = http.MultipartRequest('POST',
        Uri.parse("http://siddharth1212-63364.portmap.host:63364/healinghand/addreview.php"));
    //var pic = await http.MultipartFile.fromPath("photos1", product1);
    //request.files.add(pic);

    
    request.fields['pmail'] = pmail;
    request.fields['umail'] = umail;
    request.fields['review'] = review;
    
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final q = await response.stream.bytesToString();

      print(q);
      return 0;
    } else {
      print(response.reasonPhrase);
      final g = response.reasonPhrase;
      return 1;
    }
  }
}
