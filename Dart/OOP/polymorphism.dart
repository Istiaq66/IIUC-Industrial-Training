// Poly = Many
// Morphism = Forms/Behaviors

// =========================
// Compile-time Polymorphism
// =========================

class MathUtils {
  /*
  Dart does not support traditional method overloading
  like Java or C++.

  You cannot create multiple methods with the same name
  and different parameter counts/types.

  Example (Invalid):

  num add(int a, int b) {
    return a + b;
  }

  num add(int a, int b, int c) { // ERROR
    return a + b + c;
  }

  Instead, Dart uses optional parameters.
  */

  num add(int a, int b, [int? c]) {
    if (c != null) {
      return a + b + c;
    }

    return a + b;
  }
}

// =========================
// Runtime Polymorphism
// =========================

class Animal {
  String? name;
  String? color;

  void eat() {
    print('munch');
  }
}

class Dog extends Animal {
  int? breed;

  @override
  void eat() {
    print('chomp chomp');
  }
}

void main() {
  var dog = Dog();

  dog.eat();
}