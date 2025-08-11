import SwiftUI
import Foundation

@MainActor
@Observable
final class ShowDetailViewModel {
   // MARK: - Properties
   // Coordinator
   private unowned let coordinator: AppCoordinator
   private let store: DatabaseStore
   private let show: SingleShowModel
   // Repository
   private let repository: FavoritesRepository
   // Use cases
   private let fetchEpisodesUseCase: FetchEpisodesUseCase?
   private let checkFavoriteUseCase: CheckShowIsFavoriteUseCase?
   private let addToFavoritesUseCase: AddShowToFavoritesUseCase?
   private let addEpisodesToFavoritesUseCase: AddShowEpisodesToFavoritesUseCase?
   private let removeFavoriteUseCase: RemoveShowFromFavoritesUseCase?
   private let removeEpisodesFavoriteUseCase: RemoveShowEpisodesFromFavoritesUseCase?
   // State
   // Helper model
   struct Seasons: Identifiable {
      static let previews: [Self] = [ .init(id: 1, episodes: .showEpisodesPreview) ]
      
      let id: Int
      let episodes: [SingleEpisodeModel]
   }
   private(set) var seasons: [Seasons] = []
   private(set) var isLoading = false
   // Errors
   private(set) var errorMessage: String?
   // Layout
   private(set) var isFavorite: Bool = false
   var showPosterImageURL: URL? { show.image?.originalURL }
   var favoriteImageNamed: String { isFavorite ? "heart.fill" : "heart" }
   var showTitle: String { show.name }
   // Schedule
   // Helper model
   struct ShowSchedule: Identifiable {
      var id: String { day + time }
      let day: String
      let time: String
   }
   // Schedules
   var showSchedules: [ShowSchedule] {
      let time = show.schedule.time
      return show.schedule.days.compactMap { day -> ShowSchedule? in
         guard !day.isEmpty else { return nil }
         return .init(day: day.abbreviated, time: time)
      }
   }
   var showGenres: String { show.genres.joined(separator: ", ") }
   var showSummary: String { show.summary ?? "N/A" }
   
   // MARK: - Init
   init(coordinator: AppCoordinator,
        store: DatabaseStore,
        show: SingleShowModel,
        fetchEpisodesUseCase: FetchEpisodesUseCase? = nil,
        checkFavoriteUseCase: CheckShowIsFavoriteUseCase? = nil,
        addToFavoritesUseCase: AddShowToFavoritesUseCase? = nil,
        addEpisodesToFavoritesUseCase: AddShowEpisodesToFavoritesUseCase? = nil,
        removeFavoriteUseCase: RemoveShowFromFavoritesUseCase? = nil,
        removeEpisodesFavoriteUseCase: RemoveShowEpisodesFromFavoritesUseCase? = nil) {
      self.coordinator = coordinator
      self.store = store
      self.show = show
      self.repository = FavoritesRepositoryImpl(databaseStore: store)
      self.fetchEpisodesUseCase = fetchEpisodesUseCase
      self.checkFavoriteUseCase = checkFavoriteUseCase
      self.addToFavoritesUseCase = addToFavoritesUseCase
      self.addEpisodesToFavoritesUseCase = addEpisodesToFavoritesUseCase
      self.removeFavoriteUseCase = removeFavoriteUseCase
      self.removeEpisodesFavoriteUseCase = removeEpisodesFavoriteUseCase
   }
   
   // MARK: - Checking favorite
   private func checkingFavorite() async throws {
      let checks = checkFavoriteUseCase ?? CheckShowIsFavoriteUseCaseImpl(repository: repository)
      isFavorite = try await checks.execute(showID: show.id)
   }
   
   // MARK: - Fetching
   func loadEpisodes() async throws {
      do {
         try await checkingFavorite()
         
         withAnimation(.easeInOut) {
            seasons = Seasons.previews
            isLoading = true
         }
         
         let repository = ShowsRepositoryImpl()
         let fetchs = fetchEpisodesUseCase ?? FetchEpisodesUseCaseImpl(repository: repository)
         let fetchedEpisodes = try await fetchs(showID: show.id)
         
         if let fetchedError = fetchedEpisodes.errorMessage, !fetchedError.isEmpty {
            errorMessage = fetchedError
            withAnimation(.easeInOut.delay(0.3)) { isLoading = false }
            return
         }
         
         let allEpisodes = fetchedEpisodes.model?.episodes ?? []
         let episodesGroupedBySeason = Dictionary(grouping: allEpisodes, by: \.season)
         let allSeasons = episodesGroupedBySeason.map { season, episodes in
            Seasons(id: season, episodes: episodes)
         }
         
         seasons = allSeasons.sorted(using: KeyPathComparator(\.id))
         withAnimation(.easeInOut.delay(0.3)) { isLoading = false }
         
      } catch {
         seasons = []
         errorMessage = error.localizedDescription
         withAnimation(.easeInOut.delay(0.3)) { isLoading = false }
      }
   }
   
   func retryLoad() async throws {
      try await loadEpisodes()
   }
   
   // MARK: - Favorites
   func addOrRemoveShowFromFavorites() async throws {
      if isFavorite {
         try await removeShowFromFavorites()
         
      } else {
         try await addShowToFavorites()
      }
   }
   
   private func addShowToFavorites() async throws {
      let adds = addToFavoritesUseCase ?? AddShowToFavoritesUseCaseImpl(repository: repository)
      try await adds.execute(show)
      
      let addsEpisodes = addEpisodesToFavoritesUseCase ?? AddShowEpisodesToFavoritesUseCaseImpl(repository: repository)
      let episodes: [SingleEpisodeModel] = seasons.flatMap(\.episodes)
      try await addsEpisodes.execute(episodes, ofShow: show)
      
      isFavorite = true
   }
   
   private func removeShowFromFavorites() async throws {
      let removes = removeFavoriteUseCase ?? RemoveShowFromFavoritesUseCaseImpl(repository: repository)
      try await removes.execute(showID: show.id)
      
      let removesEpisodes = removeEpisodesFavoriteUseCase ?? RemoveShowEpisodesFromFavoritesUseCaseImpl(repository: repository)
      try await removesEpisodes.execute(showID: show.id)
      
      isFavorite = false
   }
   
   // MARK: - Navigation
   func navigateToEpisodeDetail(for episode: SingleEpisodeModel) {
      coordinator.goToPath(.episodeDetails(episode: episode))
   }
}
