part of 'gifs_bloc.dart';

class GifsState extends Equatable {
  DataModel? gifsModel = null;
  bool? initialData = false;

  GifsState({
    this.gifsModel,
    this.initialData,
  });

  GifsState copyWith({
    DataModel? gifsModel,
    bool? initialData,
  }) =>
      GifsState(
        gifsModel: gifsModel ?? this.gifsModel,
        initialData: initialData ?? this.initialData,
      );

  @override
  List<Object?> get props => [gifsModel, initialData];

  @override
  String tostring() => '{gifsModel: $gifsModel, initialData: $initialData}';
}

class GifsInitial extends GifsState {}
