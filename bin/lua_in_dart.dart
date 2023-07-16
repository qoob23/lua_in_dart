import 'package:lua_dardo/lua.dart';

void main(List<String> arguments) {
  final st = Stopwatch()..start();

  // Виртуальная машина lua, реализованная на dart.
  // см. pub.dev/packages/lua_dardo
  final ls = LuaState.newState();

  // Регистрируем функцию
  // Когда в lua будет вызвана функция _sum, будет выполнена функция luaSum
  ls.register('_sum', luaSum);

  // Загрузка стандартной библиотеки lua
  ls.openLibs();
  print('[dart] loaded lua (took ${st.elapsed.inMilliseconds} ms)');
  st.reset();

  // Загружаем свой скрипт
  if (ls.doFile('lua/script.lua')) {
    print('[dart] loaded script (took ${st.elapsed.inMilliseconds} ms)');
    st.reset();
    print('[dart] calling lua:print_sum');

    // Вызываем функцию print_sum в lua скрипте
    ls.getGlobal('print_sum');
    ls.call(0,0);
  } else {
    final msg = ls.toStr(-1);
    print('Lua error: $msg');
  }

  print('call to lua took ${st.elapsed.inMilliseconds} ms');
}

int luaSum(LuaState ls) {
  print('[dart] called luaSum');
  // Получаем аргументы из lua. Они хранятся на стеке в таком виде:
  // - количество аргументов
  // - аргумент 1
  // - аргумент 2
  if (ls.getTop() != 2) {
    // Функция была вызвана с неправильным количеством аргументов
    print('[dart] error: nAgrs=${ls.getTop()}');
    return -1;
  }
  final a = ls.toNumber(1);
  final b = ls.toNumber(2);

  final sum = a + b;
  print('[dart] a=$a, b=$b, sum=$sum');

  // Кладём результат вычислений на стек, это значение, которое вернёт
  // вызов функции в lua
  ls.pushNumber(sum);
  return 1;
}

