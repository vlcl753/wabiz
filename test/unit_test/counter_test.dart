import 'package:flutter_test/flutter_test.dart';

class Counter {
  int value = 0;

  void increment() => value++;

  void decrement() => value--;
}

void main() {
  test("카운터 값이 증가하는 테스트", () {
    final counter = Counter();
    counter.increment();
    expect(counter.value, 1);
  });

  group("카운터 클래스 테스트 그룹 (증가와 감소 테스트)", () {
    test("초기 인스턴스화 되었을때의 값은 0입니다.", () {
      expect(Counter().value, 0);
    });
    test("카운터의 increment()를 수행하여 value값을 1 증가하는 테스트",(){
      final counter = Counter();
      counter.increment();
      expect(counter.value, 1);
    });
  });
}
