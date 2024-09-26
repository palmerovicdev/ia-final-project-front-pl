import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'selection_game_state.dart';

class SelectionGameCubit extends Cubit<SelectionGameState> {
  SelectionGameCubit() : super(SelectionGameInitial());
  String currentWord = '';
  int currentRound = 0;
  int currentPoints = 0;

  void startGame(){
    //TODO 9/25/24 palmerodev : llamar para obtener los numeros y traducciones

    //TODO 9/25/24 palmerodev : guardar en el estado del cubit

    //TODO 9/25/24 palmerodev : elegir la palabra a esconder

    //TODO 9/25/24 palmerodev : iniciar el round
  }

  void finishCurrentRound(String wordFromUser){
    //TODO 9/25/24 palmerodev : buscar del estado, la palabra que puso el user y comparar con la palabra escogida

    //TODO 9/25/24 palmerodev : si son iguales, pasar al siguiente round ( startGame() )

    //TODO 9/25/24 palmerodev : calcular la puntuacion

    //TODO 9/25/24 palmerodev : si no son iguales, se acaba y se llama a finishGame()
  }

  void finishGame(){
    //TODO 9/25/24 palmerodev : calcular la puntuacion total

    //TODO 9/25/24 palmerodev : emitir el estado final
  }
}
