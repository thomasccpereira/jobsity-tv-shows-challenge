import Foundation

@MainActor
protocol AddShowToFavoritesUseCase {
   func execute(_ show: SingleShowModel) async throws
}

@MainActor
struct AddShowToFavoritesUseCaseImpl: AddShowToFavoritesUseCase {
   private let repository: FavoritesRepository
   
   init(repository: FavoritesRepository) {
      self.repository = repository
   }
   
   func execute(_ show: SingleShowModel) async throws {
      try await repository.addShowToFavorites(show)
   }
}
