#if DEBUG
struct MockedFetchEpisodesUseCase: FetchEpisodesUseCase {
   func callAsFunction(showID: Int) async throws -> Envelope<EpisodesListModel> {
      try? await Task.sleep(for: .seconds(2))
      return .init(model: .init(episodes: .showEpisodesPreview))
   }
}
#endif
