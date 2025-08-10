import Foundation
@testable import TVShows

struct StubShowsRepository: ShowsRepository {
   var fetchShowsHandler: (Int) async throws -> Envelope<Page<SingleShowModel>>
   var searchShowHandler: (String) async throws -> Envelope<QueriedShowsModel>
   var fetchEpisodesHandler: (Int) async throws -> Envelope<EpisodesListModel>
   func fetchShows(page: Int) async throws -> Envelope<Page<SingleShowModel>> { try await fetchShowsHandler(page) }
   func searchShow(query: String) async throws -> Envelope<QueriedShowsModel> { try await searchShowHandler(query) }
   func fetchEpisodes(showID: Int) async throws -> Envelope<EpisodesListModel> { try await fetchEpisodesHandler(showID) }
}
