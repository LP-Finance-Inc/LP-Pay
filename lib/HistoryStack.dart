import "dart:collection" show Queue;

final underlyingQueue = Queue<int>();

int get length => underlyingQueue.length;
bool get isEmpty => underlyingQueue.isEmpty;
bool get isNotEmpty => underlyingQueue.isNotEmpty;

void clear() {
  print("clear called");

  underlyingQueue.clear();
  print(length);
}

int peek() {
  if (isEmpty) {
    return 0;
  }
  return underlyingQueue.last;
}

int pop() {
  if (isEmpty) {
    throw StateError("Cannot pop() on empty stack.");
  }

  return underlyingQueue.removeLast();
}

void push(final int element) {
  if (isNotEmpty) {
    if ((peek() != element) && !underlyingQueue.contains(element)) {
      underlyingQueue.addLast(element);
      print(length);
    }
  } else {
    underlyingQueue.addLast(element);
    print(length);
  }
}
