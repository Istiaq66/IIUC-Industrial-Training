class Human {
  // Private fields - the underscore makes them private
  String _name;
  int _age;

  // Constructor
  Human(this._name, this._age);

  // Getter - lets you READ the value from outside
  String get name => _name;
  int get age => _age;

  // Setter - lets you WRITE the value from outside
  set name(String value) {
    if (value.isEmpty) {
      print('Name cannot be empty!');
    } else {
      _name = value;
    }
  }

  set age(int value) {
    if (value < 0) {
      print('Age cannot be negative!');
    } else {
      _age = value;
    }
  }

  void introduce() {
    print('Hi, my name is $_name and I am $_age years old.');
  }
}