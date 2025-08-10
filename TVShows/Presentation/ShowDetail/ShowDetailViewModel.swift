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
   var showPosterImageURL: URL? { show.image?.originalURL }
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
        show: SingleShowModel,
        fetchEpisodesUseCase: FetchEpisodesUseCase? = nil) {
      self.coordinator = coordinator
      self.show = show
      self.fetchEpisodesUseCase = fetchEpisodesUseCase
   }
   
   // MARK: - Fetching
   func loadEpisodes() async throws {
      do {
         withAnimation(.easeInOut) {
            seasons = Seasons.previews
            isLoading = true
         }
         
         let repository = ShowsRepositoryImpl()
         let fetchs = fetchEpisodesUseCase ?? FetchEpisodesUseCaseImpl(repository: repository)
         let fetchedEpisodes = try await fetchs(showID: show.id)
         
         if let fetchedError = fetchedEpisodes.errorMessage, !fetchedError.isEmpty {
            errorMessage = fetchedError
            return
         }
         
         let allEpisodes = fetchedEpisodes.model?.episodes ?? []
         let episodesGroupedBySeason = Dictionary(grouping: allEpisodes, by: \.season)
         let allSeasons = episodesGroupedBySeason.map { season, episodes in
            Seasons(id: season, episodes: episodes)
         }
         
         seasons = allSeasons.sorted(using: KeyPathComparator(\.id))
         
      } catch {
         seasons = []
         errorMessage = error.localizedDescription
      }
      
      withAnimation(.easeInOut.delay(0.3)) { isLoading = false }
   }
   
   func retryLoad() async throws {
      try await loadEpisodes()
   }
   
   // MARK: - Navigation
   func navigateToEpisodeDetail(for episode: SingleEpisodeModel) {
      coordinator.goToPath(.episodeDetails(episode: episode))
   }
}
