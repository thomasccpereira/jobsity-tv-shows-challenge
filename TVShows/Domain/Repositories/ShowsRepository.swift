import Foundation

protocol ShowsRepository: Sendable {
   func fetchShows(page: Int) async throws -> Envelope<Page<SingleShowModel>>
   func searchShow(query: String) async throws -> QueriedShowsModel
   func fetchEpisodes(showID: Int) async throws -> Envelope<EpisodesListModel>
}
