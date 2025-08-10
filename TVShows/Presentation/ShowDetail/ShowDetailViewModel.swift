import SwiftUI
import Foundation

@MainActor
@Observable
final class ShowDetailViewModel {
   // MARK: - Properties
   // Coordinator
   private unowned let coordinator: AppCoordinator
   private let show: SingleShowModel
   // Use cases
   private let fetchEpisodesUseCase: FetchEpisodesUseCase?
   // State
   private(set) var episodes: [SingleEpisodeModel] = []
   private(set) var isLoading = false
   // Errors
   private(set) var errorMessage: String?
   // Layout
   var showPosterImageURL: URL? { show.image?.originalURL }
   var showTitle: String { show.name }
   // Schedule
   // Helper struct
   struct ShowSchedule: Identifiable {
      var id: String { day + time }
      var day: String
      var time: String
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
        show: SingleShowModel,
        fetchEpisodesUseCase: FetchEpisodesUseCase? = nil) {
      self.coordinator = coordinator
      self.show = show
      self.fetchEpisodesUseCase = fetchEpisodesUseCase
   }
   
   // MARK: - Fetching
   func loadEpisodes() async throws {
      do {
         let repository = ShowsRepositoryImpl()
         let fetchs = fetchEpisodesUseCase ?? FetchEpisodesUseCaseImpl(repository: repository)
         let fetchedEpisodes = try await fetchs(showID: show.id)
         
         if let fetchedError = fetchedEpisodes.errorMessage, !fetchedError.isEmpty {
            errorMessage = fetchedError
            return
         }
         
         episodes = fetchedEpisodes.model?.episodes ?? []
         
      } catch {
         episodes = []
         errorMessage = error.localizedDescription
      }
      
      withAnimation(.easeInOut) { isLoading = false }
   }
   
   func retryLoad() async throws {
      try await loadEpisodes()
   }
   
   // MARK: - Navigation
   func navigateToEpisodeDetail(for episode: SingleEpisodeModel) {
      coordinator.goToPath(.episodeDetails(show: show, episode: episode))
   }
}
