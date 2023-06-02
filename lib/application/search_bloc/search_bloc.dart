import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/models/user_model.dart';
import '../../domain/repositories/chat_repository.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ChatRepository chatRepository;
  SearchBloc({required this.chatRepository}) : super(SearchInitial()) {
    on<SearchQueryChanged>((event, emit) async {
      try {
        List<User> results = await chatRepository.search(event.query);
        emit(SearchResult(results));
      } catch (e) {
        // Handle any errors that occur during the search
        emit(const SearchError("An error occurred during the search."));
      }
      
    });

    on<SearchInitialEvent> ((event, emit) async {
      emit(SearchInitial());
    });
  }

  
}
