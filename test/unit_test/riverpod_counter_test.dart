import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

final counterProvider = StateProvider(
  (ref) => 0,
);

class Listener extends Mock {
  void call(int? previous, int value);
}

void main() {
  test("Rivcerpod StateProvicder (counterProvider)테스트",(){
    final container = ProviderContainer();
    expect(container.read(counterProvider), 0);
  });

  group("Mock Test", (){
    final counter = ProviderContainer();
    addTearDown(counter.dispose);

    final listener = Listener();
    counter.listen(counterProvider,listener.call,fireImmediately: true);
    
    verify(listener(null,0)).called(1);

  });

}

