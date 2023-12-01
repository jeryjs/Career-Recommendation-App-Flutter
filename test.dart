import 'dart:convert';


void main() {
  var json = "['Data Science for Beginners': 'Get started with data analysis and visualization!', 'Web Development Bootcamp': 'Build your own …";
  var decoded = jsonDecode(json);

  print(decoded);
}