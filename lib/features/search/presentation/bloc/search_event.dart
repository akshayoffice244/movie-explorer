abstract class SearchEvent {
  const SearchEvent();
}

class SearchMovie extends SearchEvent {
  final String query;

  const SearchMovie(this.query);
}

class ClearSearch extends SearchEvent {
  const ClearSearch();
}


class LoadRecentSearches extends SearchEvent {}

class DeleteRecentSearch extends SearchEvent {
  final String query;

  DeleteRecentSearch(this.query);
}

class ClearRecentSearches extends SearchEvent {}