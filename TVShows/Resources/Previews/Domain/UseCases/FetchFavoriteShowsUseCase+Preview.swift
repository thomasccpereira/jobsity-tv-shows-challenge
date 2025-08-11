#if DEBUG
struct MockedFetchFavoriteShowsUseCase: FetchFavoriteShowsUseCase {
   func execute() async throws -> [SingleShowModel] {
      try? await Task.sleep(for: .seconds(2))
      return [ .previewShow1, .previewShow2, .previewShow3 ]
   }
}
#endif
