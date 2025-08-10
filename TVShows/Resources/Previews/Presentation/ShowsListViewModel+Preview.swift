#if DEBUG
extension ShowsListViewModel {
   static var preview: Self {
      .init(coordinator: .preview, fetchShowsUseCase: MockedFetchShowsPageUseCase())
   }
}
#endif
