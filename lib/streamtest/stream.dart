

import 'dart:async';

void addLessThanFive (StreamController controller , int value)
{

  if(value < 5)
    {
      controller .sink.add(value);
    }
  else
    {
      controller.sink.addError(StateError('$value is less than five'));
    }
}

void main ()
{
 final  controller  =StreamController () ;

addLessThanFive(controller, 1) ;
addLessThanFive(controller, 2) ;
addLessThanFive(controller, 3) ;
addLessThanFive(controller, 4) ;
addLessThanFive(controller, 5) ;

controller.close() ;
 // addLessThanFive(controller, 0) ; show error becuse no stream

 controller.stream.listen((event) {
   print(event);
 }, onError: (error){
   // use onError for handling error
   print(error) ;
 } ,
 onDone: (){
   print('done') ;
 }
 );
}