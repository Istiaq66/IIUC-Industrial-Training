// int phoneNumber = null;

void main() {

  //! nullability

  // 👉 Nullability means whether a variable can hold null or not.

  // In Dart, every variable is either:

  // 1. Non-nullable (cannot be null)
  // 2. Nullable (can be null)

  String? name;

  // -------------------------------
  // 1. Null-aware assignment (??=)
  // -------------------------------
  // Name: "Assign if null operator"

  name ??= "Guest User";
  print("??= operator: $name");


  // -------------------------------
  // 2. Null-coalescing operator (??)
  // -------------------------------
  // Name: "Default value operator"

  String? city;
  String displayCity = city ?? "Dhaka";

  print("?? operator: $displayCity");


  // -------------------------------
  // 3. Null-aware access (?.)
  // -------------------------------
  // Name: "Safe access operator"

  String? message;

  print("?. operator: ${message?.length}"); // null (no crash)

  message = "Hello Dart";
  print("?. operator: ${message.length}");


  // -------------------------------
  // 4. Null assertion operator (!)
  // -------------------------------
  // Name: "Force unwrap operator"

  String? country;

  print("! operator: ${country!.length}");
}


// 🔥 Real-life analogy
// ?? → backup value
// ??= → fill empty box
// ?. → check before opening box
// ! → force open without checking