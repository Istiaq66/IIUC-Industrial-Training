import 'human.dart';

void main() {
  // Create a human
  var human = Human('Istiaq', 20);

  // Read using getters
  print(human.name); // Istiaq
  print(human.age);  // 20

  // Update using setters
  human.name = 'Ali';
  human.age  = 25;

  human.introduce(); // Hi, my name is Ali and I am 25 years old.

  // Setter validation kicks in
  human.age  = -5;   // Age cannot be negative!
  human.name = '';   // Name cannot be empty!
}

/*
┌─────────────────────────────────────────┐
│              Human class                │
│                                         │
│  PRIVATE (hidden)   PUBLIC (visible)    │
│  ─────────────────  ─────────────────   │
│  _name         ──►  get name            │
│  _age          ──►  get age             │
│                ◄──  set name            │
│                ◄──  set age             │
└─────────────────────────────────────────┘
outside code never touches
_name or _age directly

 */