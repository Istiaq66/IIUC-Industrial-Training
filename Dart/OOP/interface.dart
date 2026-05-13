/*
============================================================
INTERFACE IN DART
============================================================
In Dart, there is NO separate "interface" keyword.
Any class can act as an interface using "implements".
Key idea:
Interface = contract (ONLY WHAT to do, no implementation)
When a class implements another class:
→ It must override ALL methods
→ Even concrete methods are ignored
*/

// ============================================================
// INTERFACE (CONTRACT)
// ============================================================

abstract class Worker {
  void work();
  void sleep();
  String role();
}

// ============================================================
// IMPLEMENTATION CLASSES
// ============================================================

class Engineer implements Worker {
  final String name;

  Engineer(this.name);

  @override
  void work() {
    print('$name is writing code');
  }

  @override
  void sleep() {
    print('$name sleeps 6 hours');
  }

  @override
  String role() {
    return 'Engineer';
  }

  // Extra method (not part of interface)
  void buildApp() {
    print('$name is building an app');
  }
}

class Teacher implements Worker {
  final String name;

  Teacher(this.name);

  @override
  void work() {
    print('$name is teaching students');
  }

  @override
  void sleep() {
    print('$name sleeps 7 hours');
  }

  @override
  String role() {
    return 'Teacher';
  }

  void teachSubject(String subject) {
    print('$name teaches $subject');
  }
}

// ============================================================
// USING INTERFACE (POLYMORPHISM)
// ============================================================

void processWorker(Worker worker) {
  print('Role: ${worker.role()}');
  worker.work();
  worker.sleep();
  print('');
}

// ============================================================
// MAIN FUNCTION
// ============================================================

void main() {
  final engineer = Engineer('Sadiq');
  final teacher = Teacher('Rahim');

  List<Worker> workers = [engineer, teacher];

  workers.forEach(processWorker);

  // Type-specific behavior
  print('── Specific methods ──');
  engineer.buildApp();
  teacher.teachSubject('Math');
}
