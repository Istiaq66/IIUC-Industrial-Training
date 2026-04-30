// lowerCamelCase → variables, functions
// 👉 userName, totalPrice
// UpperCamelCase → class names
// 👉 UserModel, ApiService
// UPPER_CASE → constants (const)
// 👉 const PI = 3.14;


void main() {

  // ---------- num (can hold both int and double) ----------
  num numberValue = 10;
  print("num (int): $numberValue");

  numberValue = 10.5;
  print("num (double): $numberValue");


  // ---------- int (whole number) ----------
  int age = 25;
  print("int age: $age");


  // ---------- double (decimal number) ----------
  double price = 99.99;
  print("double price: $price");


  // ---------- String (text) ----------
  String name = "Istiaq Ahmed";
  print("String name: $name");


  // ---------- bool (true/false) ----------
  bool isLoggedIn = true;
  print("bool isLoggedIn: $isLoggedIn");


  // ---------- List (ordered collection) ----------
  List<int> numbers = [1, 2, 3];
  print("List numbers: $numbers");


  // ---------- Map (key-value pair) ----------
  Map<String, String> user = {
    "name": "Istiaq",
    "city": "Chattogram"
  };
  print("Map user: $user");


  // ---------- Set (unique values only) ----------
  Set<int> uniqueNumbers = {1, 2, 2, 3, 1};
  print("Set uniqueNumbers: $uniqueNumbers");


  // ---------- dynamic (can change type) ----------
  dynamic data = "Hello";
  print("dynamic (String): $data");

  data = 100;
  print("dynamic (int): $data");


  // ---------- var (type inferred, fixed) ----------
  var city = "Dhaka";
  print("var city: $city");


  // ---------- Object (parent of all types) ----------
  Object any = "Text";
  print("Object (String): $any");

  any = 50;
  print("Object (int): $any");


  // ---------- Null Safety ----------
  String? nickname; // nullable
  print("nullable String nickname: $nickname");

  nickname = "Boby";
  print("updated nickname: $nickname");


  // ---------- Non-nullable ----------
  String country = "Bangladesh";
  print("non-nullable country: $country");


  // ---------- late (initialize later) ----------
  late String language;
  language = "Dart";
  print("late language: $language");
}