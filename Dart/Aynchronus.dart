// ============================================================
// ASYNCHRONOUS PROGRAMMING IN DART
// ============================================================
// Asynchrony = events that occur independently of the main
// program flow. Dart handles this via a single-threaded
// event loop + Futures + async/await.

// ============================================================
// THREADS vs ISOLATES
// ============================================================
// Thread   → shared memory, risk of race conditions
// Isolate  → separate memory heap, communicates via messages
//            Dart's safe alternative to threads

// ============================================================
// CONCURRENCY vs PARALLELISM
// ============================================================
// Concurrency → tasks overlap in TIME  (one worker, many jobs)
// Parallelism → tasks overlap in SPACE (many workers, many jobs)
//
// Dart is CONCURRENT by default (event loop on one thread).
// Dart achieves PARALLELISM only through Isolates.

// ============================================================
// SYNCHRONOUS vs ASYNCHRONOUS
// ============================================================
// Synchronous  → each line waits for the previous to finish
// Asynchronous → long tasks are scheduled; other code runs
//                meanwhile; result is handled when ready

// ============================================================
// EVENT LOOP
// ============================================================
//
//   [Your Code]
//       │
//       ▼
//  ┌─────────────────────────────────────┐
//  │            Event Loop               │
//  │                                     │
//  │  1. Microtask Queue (higher prio)   │  ← Future.value()
//  │     └─ runs to completion first     │     scheduleMicrotask()
//  │                                     │
//  │  2. Event Queue    (lower prio)     │  ← I/O, timers,
//  │     └─ one event per loop turn      │     user input
//  └─────────────────────────────────────┘
//
// Key rule: microtasks always drain before the next event.

import 'dart:isolate';

// ============================================================
// FUTURES
// ============================================================
// A Future<T> is a placeholder for a value not yet available.
//
// States:
//   ┌─────────────┐      success     ┌──────────────────────┐
//   │ Uncompleted │ ──────────────►  │ Completed with value │
//   └─────────────┘                  └──────────────────────┘
//          │              error      ┌──────────────────────┐
//          └────────────────────►    │ Completed with error │
//                                    └──────────────────────┘

// ─── Helper: simulates a network/DB call ────────────────────
Future<int> fetchData({bool shouldFail = false}) {
  return Future.delayed(
    const Duration(seconds: 1),
        () {
      if (shouldFail) throw Exception('Network error: request timed out');
      return 42;
    },
  );
}

// ============================================================
// APPROACH 1 — Callbacks (.then / .catchError / .whenComplete)
// ============================================================
// Works, but chains become hard to read ("callback hell").

void fetchWithCallbacks() {
  print('── Callback style ──');
  print('Before future');

  fetchData()
      .then((value) => print('Value: $value'))
      .catchError((error) => print('Caught: $error'))
      .whenComplete(() => print('Done\n'));

  // This runs BEFORE the future completes (non-blocking)
  print('After future registration');
}

// ============================================================
// APPROACH 2 — async / await  ✅ preferred
// ============================================================
// Reads like synchronous code; errors handled with try/catch.

Future<void> fetchWithAsyncAwait() async {
  print('── async/await style ──');
  print('Before future');

  // Execution pauses here until the Future resolves.
  // The event loop remains free to handle other tasks.
  final value = await fetchData();
  print('Value: $value'); // only runs after fetchData() completes

  print('After future\n');
}

// ============================================================
// ERROR HANDLING
// ============================================================

Future<void> handleErrors() async {
  print('── Error handling ──');

  // try/catch/finally mirrors synchronous error handling
  try {
    final value = await fetchData(shouldFail: false);
    print('Value: $value');

    // Errors thrown AFTER await are also caught
    throw Exception('Something went wrong after getting value');
  } on Exception catch (error) {
    // `on ExceptionType` catches specific types
    print('Caught Exception: $error');
  } catch (error, stackTrace) {
    // Generic catch: use stackTrace for debugging
    print('Caught unknown error: $error');
    print(stackTrace);
  } finally {
    // Always runs — use for cleanup (close DB, cancel timer, etc.)
    print('Cleanup: finally block ran\n');
  }
}

// ============================================================
// MULTIPLE FUTURES
// ============================================================

Future<void> multipleFutures() async {
  print('── Multiple futures ──');

  // ❌ Sequential — total wait = 1s + 1s = 2s
  final a = await fetchData();
  final b = await fetchData();
  print('Sequential: $a, $b');

  // ✅ Parallel — total wait = max(1s, 1s) = 1s
  final results = await Future.wait([fetchData(), fetchData()]);
  print('Parallel: ${results[0]}, ${results[1]}\n');
}

// ============================================================
// ISOLATES — true parallelism for heavy computation
// ============================================================

int heavyComputation(int input) {
  // Simulates CPU-intensive work (e.g. parsing, encryption)
  var result = 0;
  for (var i = 0; i < input; i++) result += i;
  return result;
}

Future<void> runIsolateExample() async {
  print('── Isolate example ──');

  // Isolate.run() spawns a new isolate, runs the function,
  // returns the result, then terminates the isolate.
  // No shared memory — the function must be top-level or static.
  final result = await Isolate.run(() => heavyComputation(1000000));
  print('Isolate result: $result\n');
}

// ============================================================
// MAIN
// ============================================================

Future<void> main() async {
  // Callbacks (fire-and-forget style)
  fetchWithCallbacks();

  // Awaited sequentially so output doesn't interleave
  await Future.delayed(const Duration(milliseconds: 200));
  await fetchWithAsyncAwait();
  await handleErrors();
  await multipleFutures();
  await runIsolateExample();
}