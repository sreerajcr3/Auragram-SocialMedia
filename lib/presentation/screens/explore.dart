import 'package:aura/bloc/searchBloc/bloc/search_bloc.dart';
import 'package:aura/core/constants/measurements.dart';
import 'package:aura/cubit/explorePage_cubit/explore_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ionicons/ionicons.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExplorePageCubit, bool>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  searchController.clear();
                  context.read<ExplorePageCubit>().pageChange(false);
                },
                icon: const Icon(Ionicons.arrow_back)),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      // kheight30,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                height: 45,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      hintText: "Search",
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            context.read<SearchBloc>().add(
                                                GetUserEvent(
                                                    text:
                                                        searchController.text));
                                          },
                                          icon: const Icon(Icons.search)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  controller: searchController,
                                  onTap: () {
                                    context
                                        .read<ExplorePageCubit>()
                                        .pageChange(true);
                                  },
                                ),
                              ),
                            ],
                          ),
                          kheight20
                        ],
                      ),
                      !state
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height * 0.8,
                              child: Expanded(
                                child: MasonryGridView.builder(
                                    gridDelegate:
                                        SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2),
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 100,
                                          width: 50,
                                          color: Colors.greenAccent,
                                        ),
                                      );
                                      
                                    }),
                              ),
                            )
                          : SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  0.8, //fixed height never change*
                              child: BlocConsumer<SearchBloc, SearchState>(
                                listener: (context, state) {},
                                builder: (context, state) {
                                  if (state is SearchSuccessState) {
                                    return Expanded(
                                      child: ListView.builder(
                                          itemCount: state.usersList.length,
                                          itemBuilder: (context, index) {
                                            return Card(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5),
                                              elevation: 10,
                                              child: ListTile(
                                                subtitle: Text(state
                                                    .usersList[index].fullname),
                                                leading: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.grey,
                                                    backgroundImage:
                                                        NetworkImage(state
                                                            .usersList[index]
                                                            .profilePic)),
                                                title: Text(
                                                  state.usersList[index]
                                                      .username,
                                                  style: const TextStyle(
                                                      fontFamily: "kanit",
                                                      fontSize: 18),
                                                ),
                                              ),
                                            );
                                          }),
                                    );
                                  } else if (state is SearchErrorState) {
                                    return Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Ionicons.search_outline,
                                            size: 35,
                                          ),
                                          kheight15,
                                          Text(
                                            """Opps..! No result found for '${searchController.text}'"""
                                            "",
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
