class prodModal2 {
  
 String? pmail;
 String? email;
 String? date;
// String? time;
 String? status; 
String? purpose;
String?enddate;
  prodModal2(
      {
      this.pmail,
      this.email,
      this.date,
  //    this.time,
      this.status,
      this.purpose,
      this.enddate,
      });

  prodModal2.fromJson(Map<String, dynamic> json) {
enddate=json['enddate'];
    pmail= json['pmail'];
    email=json['umail'];
    date= json['startdate'];
   //time=json['time'];
    status = json['status'];
    purpose=json['purpose'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
 data['umail']=email.toString();
  data['enddate']=enddate.toString();
 
 data['pmail']=pmail.toString();
 data['startdate']=date.toString();
 data['status']=status.toString();
data['purpose']=purpose.toString();
     return data;
  }
}
