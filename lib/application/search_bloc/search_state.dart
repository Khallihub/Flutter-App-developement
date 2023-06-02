import 'package:equatable/equatable.dart';

import '../../domain/entities/models/user_model.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object> get props => [message];
}
class SearchResult extends SearchState {
  final List<User> results;

  const SearchResult(this.results);

  @override
  List<Object> get props => [results];
}
