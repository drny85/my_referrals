import 'package:flutter/material.dart';

const kUrl = "https://intense-coast-64168.herokuapp.com";
//const kUrl = 'http://localhost:3000';
const Map<String, String> kHeaders = {
  "Content-type": "application/json",
  "x-auth-token":
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1YzQ2NjE1YzhkMGEzYTQ4YTA4MTkwMGEiLCJyb2xlcyI6eyJpc0FkbWluIjpmYWxzZSwiYWN0aXZlIjp0cnVlLCJjb2FjaCI6ZmFsc2V9LCJlbWFpbCI6InJvYmVydC5tZWxlbmRlekBkcmFzY29zYWxlcy5jb20iLCJpYXQiOjE1NzUwNTI4MTN9.W6GuYOc8sl5q9mMuFUxB-bC-3kPTUxQTRy-NWHpMP4o"
  // or whatever
};

const kTextStyleDetails = TextStyle(fontSize: 18);
const kReferralCardTextStyle = TextStyle(fontSize: 16.0);
