import Foundation

@MainActor
protocol AddShowEpisodesToFavoritesUseCase {
   func execute(_ episodes: [SingleEpisodeModel], ofShow show: SingleShowModel) async throws
}

@MainActor
struct AddShowEpisodesToFavoritesUseCaseImpl: AddShowEpisodesToFavoritesUseCase {
   private let repository: FavoritesRepository
   
   init(repository: FavoritesRepository) {
      self.repository = repository
   }
   
   func execute(_ episodes: [SingleEpisodeModel], ofShow show: SingleShowModel) async throws {
      try await repository.addShowEpisodesToFavorites(episodes, ofShow: show)
   }
}
