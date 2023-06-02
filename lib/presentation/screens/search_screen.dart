import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../application/chat_bloc/blocs.dart';
import '../../application/search_bloc/search_blocs.dart';
import '../../domain/entities/models/user_model.dart';
import '../routes/app_route_constants.dart';

class SearchScreen extends StatefulWidget {
  final localUser;
  const SearchScreen({super.key, required this.localUser});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  late SearchBloc _searchBloc;
  late ChatBloc chatBloc;

  @override
  void initState() {
    super.initState();
    _searchBloc = BlocProvider.of<SearchBloc>(context);
    _searchBloc.add(SearchInitialEvent());
    _searchController.addListener(_onSearchTextChanged);
  }

  void _onSearchTextChanged() {
    _searchBloc.add(SearchQueryChanged(_searchController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 2),
          child: TextFormField(
            style: const TextStyle(
              color: Colors.white, // Set the text color to white
            ),
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
              labelStyle: TextStyle(
                color: Colors.white,
              ),
              labelText: "Search for users",
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            controller: _searchController,
            onChanged: (value) {
              _onSearchTextChanged();
            },
          ),
        ),
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        bloc: _searchBloc,
        builder: (context, state) {
          if (state is SearchInitial) {
            return buildInitialInput();
          } else if (state is SearchResult) {
            return buildSearchResults(state.results);
          } else if (state is SearchError) {
            return buildSearchError(state.message);
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget buildInitialInput() {
    return const Center(
      child: Text('Start typing to search.'),
    );
  }

  Widget buildSearchResults(List<User> results) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (() => GoRouter.of(context).pushReplacementNamed(
                MyAppRouteConstants.userProfile,
                pathParameters: {
                  "username": results[index].userName,
                  "bio": results[index].bio,
                  "avatar": results[index].avatarUrl,
                  "id": results[index].id,
                  "name": results[index].name,
                  "email": results[index].email,
                  "role": "user"
                },
              )),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            color: Colors.white,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 15),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      results[index].avatarUrl,
                    ),
                    radius: 35,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        results[index].name,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w700),
                      ),
                      const Divider(
                        height: 5,
                      ),
                      Text(
                        results[index].bio,
                        style:
                            const TextStyle(color: Colors.blue, fontSize: 12),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "@${results[index].userName}",
                      style: const TextStyle(fontSize: 12),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildSearchError(String error) {
    return Center(
      child: Text(
        'Error: $error',
        style: const TextStyle(color: Colors.red),
      ),
    );
  }
}
