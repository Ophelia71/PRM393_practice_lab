
import 'dart:async';

void main(){
  print('Start');

  scheduleMicrotask((){
    print('Microtask executed');
  });

  Future((){
    print('Future event executed');
  });

  print('End');
}