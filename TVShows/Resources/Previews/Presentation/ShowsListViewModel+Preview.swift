#if DEBUG
extension ShowsListViewModel {
   static var preview: Self {
      .init(coordinator: .preview,
            store: .preview,
            fetchShowsUseCase: MockedFetchShowsPageUseCase())
   }
}
#endif
