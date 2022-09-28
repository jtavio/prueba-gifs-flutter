import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pruebagifs/src/api/services.dart';
import 'package:pruebagifs/src/models/gifs_model.dart';

part 'gifs_event.dart';
part 'gifs_state.dart';

class GifsBloc extends Bloc<GifsEvent, GifsState> {
  HttpService httpServices;
  GifsBloc({required this.httpServices}) : super(GifsState()) {
    on<LoadApiGifs>((event, emit) =>
        emit(state.copyWith(gifsModel: event.gifs, initialData: true)));
    on<Delete>((event, emit) => emit(
        state.copyWith(gifsModel: event.gifs, initialData: event.initialData)));
    on<SearchGifs>((event, emit) =>
        emit(state.copyWith(gifsModel: event.gifs, initialData: true)));
  }

  Future getAllGifs() async {
    final res = await httpServices.getInitCategory();
    if (res != null) {
      add(LoadApiGifs(res));
    }
  }

  Future searchGifs(String query) async {
    final res = await httpServices.searchGifs(query);
    if (res.data.length > 0) {
      add(SearchGifs(res!));
    } else {
      add(SearchGifs(res!));
    }
  }
}
