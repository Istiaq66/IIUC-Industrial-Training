//! FUNCTION
// Functions are "self contained" modules of code that accomplish a specific task.

// add numbers (WITHOUT FUNCTION)


// DRY (don't repeat yourself)
// Here is the basic workflow of a function
// input -> function (do something) -> output
// Arguments are those which we pass through functions
// Parameters are definition of these functions

// Normal function (sync)
int ADD(int A, int B) { // 👈 parameters
  return A + B;
}

// Async function (Future)
Future<String> FETCH_DATA() async {
  await Future.delayed(Duration(seconds: 2)); // simulate API call
  return "Data loaded";
}

// Stream (multiple values over time)
Stream<int> COUNT_STREAM() async* {
  for (int i = 1; i <= 5; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i; // emit value
  }
}

void main() async {
  print(ADD(2, 3)); // 5 // 👈 arguments

  // Future usage
  String DATA = await FETCH_DATA();
  print(DATA);

  // Stream usage
  await for (int VALUE in COUNT_STREAM()) {
    print(VALUE);
  }
}