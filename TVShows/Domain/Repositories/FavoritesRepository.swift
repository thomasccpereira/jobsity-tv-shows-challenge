import Foundation

@MainActor
protocol FavoritesRepository {
   func addShowToFavorites(_ show: SingleShowModel) async throws
   func fetchFavorites() async throws -> [SingleShowModel]
   func removeShowFromFavorites(showID: Int) async throws
}
