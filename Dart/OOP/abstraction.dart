// ============================================================
// ABSTRACTION IN DART
// ============================================================
// Abstraction = hiding complex implementation details and
// exposing only what's necessary to the outside world.
//
// Dart achieves abstraction via:
//   1. Abstract classes  → define WHAT, not HOW
//   2. Interfaces        → every class is implicitly an interface
//   3. Private members   → hide internal details with (_)

// ============================================================
// ABSTRACT CLASS — defines the "contract"
// ============================================================
// Cannot be instantiated directly.
// Subclasses MUST implement all abstract methods.

abstract class Human {
  // ── Private fields — hidden from outside ──────────────────
  String? _name; // only accessible within this class
  int? _age;

  // ── Constructor ───────────────────────────────────────────
  Human(this._name, this._age);

  // ── Encapsulated access (getters/setters) ─────────────────
  String? get name => _name;
  int? get age => _age;

  set name(String? value) {
    if (value == null || value.trim().isEmpty) {
      throw ArgumentError('Name cannot be empty');
    }
    _name = value;
  }

  set age(int? value) {
    if (value != null && value < 0) {
      throw ArgumentError('Age cannot be negative');
    }
    _age = value;
  }

  // ── Concrete method — shared by all subclasses ────────────
  // Subclasses inherit this; no need to re-implement.
  void breathe() => print('$_name is breathing');

  // ── Abstract methods — WHAT to do, not HOW ────────────────
  // Every subclass defines its own version of these.
  void work();   // no body — just the contract
  void sleep();
  String describe();

  // ── toString override ─────────────────────────────────────
  @override
  String toString() => 'Human(name: $_name, age: $_age)';
}

// ============================================================
// CONCRETE CLASSES — define the HOW
// ============================================================

class Doctor extends Human {
  final String _specialty; // Doctor-specific detail

  Doctor(String name, int age, this._specialty) : super(name, age);

  // Implementing the abstract contract
  @override
  void work() => print('$name is diagnosing patients');

  @override
  void sleep() => print('$name sleeps after a 12-hour shift');

  @override
  String describe() => '$name is a Doctor specializing in $_specialty';

  // Doctor-only method — not part of the abstract contract
  void prescribe(String medicine) {
    print('$name prescribed: $medicine');
  }
}

class Student extends Human {
  final String _major;

  Student(String name, int age, this._major) : super(name, age);

  @override
  void work() => print('$name is studying $_major');

  @override
  void sleep() => print('$name sleeps at 3am after cramming');

  @override
  String describe() => '$name is a Student majoring in $_major';

  // Student-only method
  void attendLecture(String subject) {
    print('$name is attending: $subject lecture');
  }
}

class Athlete extends Human {
  final String _sport;

  Athlete(String name, int age, this._sport) : super(name, age);

  @override
  void work() => print('$name is training for $_sport');

  @override
  void sleep() => print('$name sleeps 9 hours for recovery');

  @override
  String describe() => '$name is an Athlete competing in $_sport';

  void compete() => print('$name is competing in a $_sport match');
}

// ============================================================
// ABSTRACTION IN ACTION
// ============================================================
// The caller only interacts with the Human interface.
// It doesn't care HOW each type works internally.

void makeHumanWork(Human human) {
  // We call work() without knowing if it's a Doctor,
  // Student, or Athlete — that detail is abstracted away.
  print(human.describe());
  human.breathe(); // inherited concrete method
  human.work();    // each type handles this differently
  human.sleep();
  print('');
}

void main() {
  final doctor  = Doctor('Sarah', 35, 'Cardiology');
  final student = Student('Ali', 20, 'Computer Science');
  final athlete = Athlete('Jordan', 25, 'Basketball');

  // All three are treated uniformly as `Human`
  final List<Human> humans = [doctor, student, athlete];
  humans.forEach(makeHumanWork);

  // ── Type-specific methods still accessible ─────────────────
  print('── Specific behaviors ──');
  doctor.prescribe('Aspirin 500mg');
  student.attendLecture('Data Structures');
  athlete.compete();

  // ── Encapsulation protection ───────────────────────────────
  print('\n── Setter validation ──');
  try {
    doctor.name = ''; // triggers validation
  } catch (e) {
    print('Caught: $e');
  }

  try {
    student.age = -5; // triggers validation
  } catch (e) {
    print('Caught: $e');
  }
}