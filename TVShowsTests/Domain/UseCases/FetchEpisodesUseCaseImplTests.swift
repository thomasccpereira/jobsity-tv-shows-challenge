import Testing
@testable import TVShows

@Suite
struct FetchEpisodesUseCaseImplTests {
   private struct StubRepo: ShowsRepository {
      var result: Envelope<EpisodesListModel>
      func fetchShows(page: Int) async throws -> Envelope<Page<SingleShowModel>> { fatalError("unused") }
      func searchShow(query: String) async throws -> Envelope<QueriedShowsModel> { fatalError("unused") }
      func fetchEpisodes(showID: Int) async throws -> Envelope<EpisodesListModel> { result }
   }
   
   @Test func returnsModelFromRepository() async throws {
      let episodes = EpisodesListModel(episodes: [
         .init(id: 1, season: 1, number: 1, image: nil, name: "E1", summary: nil, runtime: 42)
      ])
      let repo = StubRepo(result: Envelope(model: episodes))
      let useCase = FetchEpisodesUseCaseImpl(repository: repo)
      
      let env = try await useCase(showID: 10)
      #expect(env.model == episodes)
      #expect(env.errorMessage == nil)
   }
   
   @Test func returnsErrorMessageFromRepository() async throws {
      let repo = StubRepo(result: Envelope<EpisodesListModel>(model: nil, errorMessage: "Oops"))
      let useCase = FetchEpisodesUseCaseImpl(repository: repo)
      
      let env = try await useCase(showID: 10)
      #expect(env.model == nil)
      #expect(env.errorMessage == "Oops")
   }
}
