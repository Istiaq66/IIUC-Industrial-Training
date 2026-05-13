# Object-Oriented Programming
### A practical guide for Dart developers

---

## Part 1 — The four pillars of OOP

Every OOP language — including Dart — is built on four core ideas. Think of them as the rules of the game before you play.

### Abstraction
Hide complexity behind a simple interface. You press a button on a TV remote without knowing what's happening inside it. In code, objects, classes, and methods let you work with complex systems through simple controls.

### Encapsulation
Keep data private inside a class and expose only what others need. This protects your data from being accidentally changed from outside the class, and lets you reuse objects safely.

### Inheritance
New classes can borrow attributes and behaviour from existing ones. Instead of rewriting the same logic, you build on top of work already done.

### Polymorphism
The same method name can behave differently depending on context. There are two forms:
- **Method overloading** — the code itself implies different meanings.
- **Method overriding** — a subclass replaces a parent's method with its own version.

---

## Part 2 — `extends` vs `implements` in Dart

These two keywords look similar but solve very different problems. Mixing them up is one of the most common mistakes in Dart.

| Keyword      | Inherits code? | Must re-implement? | Best for                          |
|--------------|----------------|--------------------|-----------------------------------|
| `extends`    | Yes            | No (optional)      | Reusing and customising behaviour |
| `implements` | No             | Yes — everything   | Enforcing a shared API contract   |

### `extends` — inheriting behaviour

When you extend a class, you get all of its existing code for free. You only override what you want to change.

```dart
class Animal {
  void sleep() {
    print("Sleeping...");
  }
}

class Dog extends Animal {
  void bark() {
    print("Woof!");
  }
  // Dog also has sleep() inherited from Animal — no need to rewrite it
}
```

### `implements` — following a contract

When you implement a class, you borrow its *shape* (method names and signatures) but **none** of its code. You must write every method yourself from scratch.

```dart
abstract class AuthService {
  Future<void> login(String username, String password);
  Future<void> logout();
}

// Must implement BOTH methods — no shortcuts
class FirebaseAuthService implements AuthService {
  @override
  Future<void> login(String username, String password) async {
    // your logic here
  }

  @override
  Future<void> logout() async {
    // your logic here
  }
}
```

---

## Part 3 — Abstract class vs Interface

Dart has **no `interface` keyword**. Instead, any class can act as an interface when used with `implements`. But abstract classes and interfaces are still different concepts.

### Abstract class — a partially built blueprint

An abstract class can contain:
- **Abstract methods** — declared but with no body; subclasses must implement them.
- **Concrete methods** — fully implemented; subclasses inherit them for free.
- Fields, constructors, and state.

```dart
abstract class Animal {
  // No body — subclass MUST implement this
  void makeSound();

  // Already implemented — subclass gets it for free
  void sleep() {
    print("Sleeping...");
  }
}

class Dog extends Animal {
  @override
  void makeSound() {
    print("Bark!");
  }
  // sleep() is inherited automatically
}
```

> Think of it like a **house with some rooms already built**. You move in and finish the rest yourself.

### Interface — a strict contract, nothing included

When any class (or abstract class) is used with `implements`, it acts as an interface. You get the contract — the list of what must exist — but zero implementation. You write everything yourself.

```dart
class Animal {
  void makeSound() {}
}

class Dog implements Animal {
  @override
  void makeSound() {
    print("Bark!"); // Must be written — the original is ignored
  }
}
```

> Think of it like a **blank floor plan**. You can see where each room goes, but you build every wall yourself.

### Comparison table

| Feature                  | Abstract class      | Interface (`implements`) |
|--------------------------|---------------------|--------------------------|
| Methods                  | Abstract + concrete | Must override all        |
| Code reuse               | Yes                 | No                       |
| Can hold state (fields)? | Yes                 | Not meaningfully         |
| Constructors             | Yes                 | No                       |
| Purpose                  | Shared base + logic | Strict API contract      |

---

## Part 4 — Abstract class vs Interface (deep dive)

### Are they the same thing?

No. They are related concepts, but they behave differently in Dart.

- **Abstract class** → defines WHAT to do + SOME of HOW to do it
- **Interface** → defines ONLY WHAT to do (a contract, nothing more)

### Abstract class

An abstract class can contain all of the following:
- Abstract methods (no body — subclass must implement)
- Concrete methods (with body — subclass inherits for free)
- Variables (state)
- Constructors

```dart
abstract class Animal {
  void makeSound(); // WHAT — must be implemented by subclass

  void sleep() {
    print("Sleeping"); // HOW — already implemented
  }
}
```

> **Key idea:** Abstract class = partially implemented blueprint

### Interface in Dart

Dart does not have a separate `interface` keyword. Instead, any class can act as an interface using `implements`.

```dart
class Animal {
  void makeSound() {}
}

class Dog implements Animal {
  @override
  void makeSound() {
    print("Bark");
  }
}
```

When using `implements`, two rules always apply:
- You **must** override everything.
- Even existing method implementations are completely ignored.

### Comparison table

| Feature        | Abstract class      | Interface (`implements`) |
|----------------|---------------------|--------------------------|
| Methods        | Abstract + concrete | Must override all        |
| Code reuse     | Yes                 | No                       |
| State (fields) | Yes                 | Not meaningful           |
| Constructors   | Yes                 | No                       |
| Purpose        | Base + shared logic | Strict contract          |

### Real-life analogy

**Abstract class** — a partially built house. Some rooms are already finished; you complete the rest.

**Interface** — a blueprint only. Nothing is built — you construct everything yourself.

### Dart insight

| Keyword      | What it means             |
|--------------|---------------------------|
| `extends`    | Inheritance + code reuse  |
| `implements` | Full contract enforcement |

An abstract class in Dart can play both roles — use it with `extends` for inheritance, or with `implements` as a pure interface. The keyword you choose decides the behaviour.

---

## Part 5 — One-line reminders

| Concept        | Remember it as...                                         |
|----------------|-----------------------------------------------------------|
| `extends`      | "I want to *be* this class and inherit its behaviour."    |
| `implements`   | "I want to *look like* this class but write my own code." |
| Abstract class | A partial blueprint — some logic is already provided.     |
| Interface      | A strict contract — you build everything from scratch.    |

> **Key insight:** An abstract class in Dart can act as *both*. Use it with `extends` for inheritance, or with `implements` as a pure contract. The keyword you choose decides the behaviour.