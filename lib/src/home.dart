import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pruebagifs/src/api/services.dart';
import 'package:pruebagifs/src/bloc/gifs/gifs_bloc.dart';
import 'package:pruebagifs/src/models/gifs_model.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  StreamController<String> streamController = StreamController();
  TextEditingController editingController = TextEditingController();
  List<Gifs> listGifs = [];
  late GifsBloc callApiGifs;

  @override
  void initState() {
    streamController.stream
        .debounce(const Duration(seconds: 2))
        .listen((event) => _validateValues());
    super.initState();
    callApiGifs = BlocProvider.of<GifsBloc>(context);
    callApiGifs.getAllGifs();
  }

  _validateValues() {
    if (editingController.text.length > 3) {
      BlocProvider.of<GifsBloc>(context, listen: false).add(Delete());
      // code here
      print('esto es: ${editingController.text}');
      Future.delayed(const Duration(seconds: 5));
      // ignore: prefer_const_constructors
      callApiGifs.searchGifs(editingController.text);
      editingController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
            left: 8.0, right: 8.0, top: 45.0, bottom: 10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, right: 8.0, top: 8.0, bottom: 10.0),
              child: TextField(
                style: const TextStyle(color: Color.fromARGB(255, 60, 63, 62)),
                onChanged: (value) {
                  streamController.add(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blueGrey[100],
                  hintText: "Search by name",
                  labelStyle:
                      const TextStyle(color: Color.fromARGB(255, 60, 63, 62)),
                  prefixIcon: const Icon(Icons.search,
                      color: Color.fromARGB(255, 60, 63, 62)),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child:
                  BlocBuilder<GifsBloc, GifsState>(builder: (context, state) {
                if (state.initialData == true &&
                    state.gifsModel!.data!.isNotEmpty) {
                  listGifs = state.gifsModel!.data!;

                  return StaggeredGridView.countBuilder(
                    staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    itemCount: listGifs.length,
                    crossAxisCount: 4,
                    itemBuilder: (context, index) {
                      return Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          ClipRRect(
                              child: FadeInImage(
                            image: NetworkImage(
                                listGifs[index].images!.original!.url!
                                // 'https://media0.giphy.com/media/10khKaHKOP2mZ2/giphy.gif?cid=fdd78afabhgp9qvzsxpoqsjoskdxqd3xgd4hjqu8r2o9kb29&rid=giphy.gif&ct=g',
                                ),
                            fit: BoxFit.cover,
                            placeholder:
                                const AssetImage('assets/jar-loading.gif'),
                          )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              child: const Icon(
                                Icons.favorite_border_outlined,
                                color: Colors.red,
                                size: 20,
                              ),
                              onTap: () async {},
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                        ],
                      );
                    },
                  );
                }

                // if (state.initialData == true &&
                //     state.queryGifs!.data!.isNotEmpty) {
                //   listGifs = state.gifsModel!.data!;
                //   return StaggeredGridView.countBuilder(
                //     staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
                //     mainAxisSpacing: 8,
                //     crossAxisSpacing: 8,
                //     itemCount: listGifs.length,
                //     crossAxisCount: 4,
                //     itemBuilder: (context, index) {
                //       return ClipRRect(
                //           child: FadeInImage(
                //         image: NetworkImage(
                //             listGifs[index].images!.original!.url!
                //             // 'https://media0.giphy.com/media/10khKaHKOP2mZ2/giphy.gif?cid=fdd78afabhgp9qvzsxpoqsjoskdxqd3xgd4hjqu8r2o9kb29&rid=giphy.gif&ct=g',
                //             ),
                //         fit: BoxFit.cover,
                //         placeholder: const AssetImage('assets/jar-loading.gif'),
                //       ));
                //     },
                //   );
                // }
                // if (state.queryGifs!.data!.length == 0) {
                //   return const Center(
                //     child: Text('No se encontró ninguna coincidencia'),
                //   );
                // }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    streamController.close();
    editingController.dispose();
  }
}
