#if DEBUG
struct MockedFetchShowsPageUseCase: FetchShowsPageUseCase {
   func callAsFunction(page: Int) async throws -> Envelope<Page<SingleShowModel>> {
      try? await Task.sleep(for: .seconds(2))
      
      let model = Page(items: .showsListPreview,
                       pageIndex: 0,
                       hasNextPage: false)
      return .init(model: model)
   }
}
#endif
