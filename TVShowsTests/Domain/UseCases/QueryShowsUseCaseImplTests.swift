import Testing
@testable import TVShows

@Suite
struct QueryShowsUseCaseImplTests {
   @Test func queryShowsUseCaseReturnsQueryResult() async throws {
      let model = QueriedShowsModel(queriedShows: [.init(score: 1.0, show: .init(id: 1,
                                                                                 image: nil,
                                                                                 name: "Q",
                                                                                 schedule: .init(time: "", days: []),
                                                                                 genres: [],
                                                                                 runtime: nil,
                                                                                 summary: nil))
                                                  ])
      
      let repository = StubShowsRepository(fetchShowsHandler: { _ in Envelope(model: .init(items: [], pageIndex: 0, hasNextPage: false)) },
                                           searchShowHandler: { _ in Envelope(model: model) },
                                           fetchEpisodesHandler: { _ in Envelope(model: .init(episodes: [])) })
      let useCase = QueryShowsUseCaseImpl(repository: repository)
      let fetched = try await useCase(query: "Q")
      #expect(fetched.model == model)
   }
}
