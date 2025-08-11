import Foundation

@MainActor
protocol FetchFavoriteShowsUseCase {
   func execute() async throws -> [SingleShowModel]
}

@MainActor
struct FetchFavoriteShowsUseCaseImpl: FetchFavoriteShowsUseCase {
   private let repository: FavoritesRepository
   
   init(repository: FavoritesRepository) {
      self.repository = repository
   }
   
   func execute() async throws -> [SingleShowModel] {
      try await repository.fetchFavorites()
   }
}
