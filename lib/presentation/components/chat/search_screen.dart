import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../application/search_bloc/search_blocs.dart';
import '../../../domain/entities/models/user_model.dart';
import '../../routes/app_route_constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  late SearchBloc _searchBloc;

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
        title: const Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                _onSearchTextChanged();
              },
              decoration: const InputDecoration(
                labelText: 'Search',
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchBloc, SearchState>(
              bloc: _searchBloc,
              builder: (context, state) {
                if (state is SearchInitial) {
                  return buildInitialInput();
                } else if (state is SearchResult) {
                  return buildSearchResults(state.results);
                } else if (state is SearchError) {
                  return buildSearchError(state.message);
                } else {
                  return Container(); // Placeholder for other states
                }
              },
            ),
          ),
        ],
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
        return ListTile(
          onTap: () {
            GoRouter.of(context).pushNamed(
              MyAppRouteConstants.chatRouteName,
              pathParameters: {
                // user: results[index].userName,
              },
            );
          },
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(results[index].avatarUrl),
          ),
          title: Text(
            results[index].name,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            results[index].userName,
            maxLines: 1,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          // trailing: Text(
          //   results[index].id.toString(),
          //   style: Theme.of(context).textTheme.bodySmall,
          // ),
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
