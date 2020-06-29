import 'package:flutter/foundation.dart';

class User {
  final String id;
  final String email;
  final String companyId;
  
  User({
    @required this.id, 
    @required this.email, 
    @required this.companyId, 
  });

  User.fromJson(Map<String, dynamic> json) 
      : id = json['uid'],
        email = json['email'],
        companyId = json['companyId'];
  
  Map<String, dynamic> toJson() => 
  {
    'uid': id,
    'email': email,
    'companyId': companyId,
  };
}