//-----------------------profile following text----------------
import 'package:flutter/material.dart';

profileCardText2(text) => Text(text);

profileText1(text) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, right: 15),
    child: Text(
      text,
      style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold,fontFamily: "kanit",color: Colors.black54),
    ),
  );
}