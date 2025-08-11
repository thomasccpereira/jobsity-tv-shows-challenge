import Foundation

@MainActor
protocol FavoritesRepository {
   func checkIfShowIsFavorite(_ showID: Int) async throws -> Bool
   func addShowToFavorites(_ show: SingleShowModel) async throws
   func addShowEpisodesToFavorites(_ episodes: [SingleEpisodeModel], ofShow show: SingleShowModel) async throws
   func fetchFavorites() async throws -> [SingleShowModel]
   func fetchFavoritesEpisodes(showID: Int) async throws -> [SingleEpisodeModel]
   func removeShowFromFavorites(showID: Int) async throws
   func removeShowEpisodesFromFavorites(showID: Int) async throws
}
