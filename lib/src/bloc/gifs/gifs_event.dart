part of 'gifs_bloc.dart';

abstract class GifsEvent extends Equatable {
  const GifsEvent();

  @override
  List<Object> get props => [];
}

class LoadApiGifs extends GifsEvent {
  final DataModel gifs;

  const LoadApiGifs(this.gifs);
}

class SearchGifs extends GifsEvent {
  final DataModel gifs;

  const SearchGifs(this.gifs);
}

class Delete extends GifsEvent {
  bool initialData;
  DataModel? gifs;
  Delete({this.initialData = false, this.gifs});
}
