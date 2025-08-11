import SwiftUI
import Foundation

@MainActor
@Observable
final class FavoritesListViewModel {
   // MARK: - Properties
   // Coordinator
   private unowned let coordinator: AppCoordinator
   private let store: DatabaseStore
   // Repository
   private let repository: FavoritesRepository
   // Use cases
   private let fetchFavoriteUseCase: FetchFavoriteShowsUseCase?
   private let addToFavoritesUseCase: AddShowToFavoritesUseCase?
   private let removeFavoriteUseCase: RemoveShowFromFavoritesUseCase?
   // State
   private(set) var favorites: [SingleShowModel] = []
   private var removed: [SingleShowModel] = []
   // Errors
   private(set) var errorMessage: String?
   
   // MARK: - Init
   init(coordinator: AppCoordinator,
        store: DatabaseStore,
        fetchFavoriteUseCase: FetchFavoriteShowsUseCase? = nil,
        addToFavoritesUseCase: AddShowToFavoritesUseCase? = nil,
        removeFavoriteUseCase: RemoveShowFromFavoritesUseCase? = nil) {
      self.coordinator = coordinator
      self.store = store
      self.repository = FavoritesRepositoryImpl(databaseStore: store)
      self.fetchFavoriteUseCase = fetchFavoriteUseCase
      self.addToFavoritesUseCase = addToFavoritesUseCase
      self.removeFavoriteUseCase = removeFavoriteUseCase
   }
   
   func loadFavorites() async throws {
      do {
         let fetchs = fetchFavoriteUseCase ?? FetchFavoriteShowsUseCaseImpl(repository: repository)
         favorites = try await fetchs.execute()
         
      } catch {
         errorMessage = error.localizedDescription
      }
   }
   
   func addShowToFavorites(show: SingleShowModel) async throws {
      let adds = addToFavoritesUseCase ?? AddShowToFavoritesUseCaseImpl(repository: repository)
      try await adds.execute(show)
      
      removed.removeAll(where: { $0.id == show.id })
   }
   
   func removeShowFromFavorites(show: SingleShowModel) async throws {
      let removes = removeFavoriteUseCase ?? RemoveShowFromFavoritesUseCaseImpl(repository: repository)
      try await removes.execute(showID: show.id)
      
      removed.append(show)
   }
   
   func isShowFavorite(_ show: SingleShowModel) -> Bool {
      !removed.contains(where: { $0.id == show.id })
   }
   
   // MARK: - Navigation
   func navigateToShowDetail(for show: SingleShowModel) {
      coordinator.goToPath(.showDetails(show: show))
   }
}
