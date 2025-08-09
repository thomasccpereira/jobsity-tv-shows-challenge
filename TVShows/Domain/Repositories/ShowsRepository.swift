import Foundation

protocol ShowsRepository: Sendable {
   func fetchShows(page: Int) async throws -> Page<SingleShowModel>
   func searchShow(query: String) async throws -> QueriedShowsModel
   func fetchEpisodes(showID: Int) async throws -> EpisodesListModel
   func fetchEpisodeDetail(showID: Int, season: Int, episode: Int) async throws -> SingleEpisodeModel
}
