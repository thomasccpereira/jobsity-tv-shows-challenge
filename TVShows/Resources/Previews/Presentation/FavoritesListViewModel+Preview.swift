#if DEBUG
extension FavoritesListViewModel {
   static var preview: Self {
      .init(coordinator: .preview,
            store: .preview,
            fetchFavoriteUseCase: MockedFetchFavoriteShowsUseCase())
   }
}
#endif
