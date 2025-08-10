#if DEBUG
struct MockedFetchEpisodesUseCase: FetchEpisodesUseCase {
   func callAsFunction(showID: Int) async throws -> Envelope<EpisodesListModel> {
      return .init(model: .init(episodes: .showEpisodesPreview))
   }
}
#endif
