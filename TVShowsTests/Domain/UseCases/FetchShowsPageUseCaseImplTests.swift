import Testing
@testable import TVShows

@Suite
struct FetchShowsPageUseCaseImplTests {
   @Test func fetchShowsPageUseCasePassesThrough() async throws {
      let page = Page(items: [SingleShowModel(id: 1, image: nil, name: "X", schedule: .init(time:"", days:[]), genres: [], runtime: nil, summary: nil)], pageIndex: 0, hasNextPage: false)
      let repo = StubShowsRepository(
         fetchShowsHandler: { _ in Envelope(model: page) },
         searchShowHandler: { _ in Envelope(model: .init(queriedShows: [])) },
         fetchEpisodesHandler: { _ in Envelope(model: .init(episodes: [])) }
      )
      let uc = FetchShowsPageUseCaseImpl(respository: repo)
      let env = try await uc(page: 0)
      #expect(env.model == page)
   }
   
   @Test func queryShowsUseCaseReturnsQueryResult() async throws {
      let model = QueriedShowsModel(queriedShows: [.init(score: 1.0, show: .init(id:1, image:nil, name:"Q", schedule:.init(time:"", days:[]), genres:[], runtime:nil, summary:nil))])
      let repo = StubShowsRepository(
         fetchShowsHandler: { _ in Envelope(model: .init(items: [], pageIndex: 0, hasNextPage: false)) },
         searchShowHandler: { _ in Envelope(model: model) },
         fetchEpisodesHandler: { _ in Envelope(model: .init(episodes: [])) }
      )
      let uc = QueryShowsUseCaseImpl(repository: repo)
      let env = try await uc(query: "Q")
      #expect(env.model == model)
   }
}
