import SwiftUI
import Foundation

@MainActor
@Observable
final class EpisodeDetailViewModel {
   // MARK: - Properties
   // Coordinator
   private unowned let coordinator: AppCoordinator
   private let episode: SingleEpisodeModel
   // Layout
   var episodePosterImageURL: URL? { episode.image?.originalURL }
   var episodeTitle: String { episode.name }
   var episodeSeason: String { episode.season.prettySeason }
   var episodeNumber: String { episode.prettyNumber }
   var episodeSummary: String { episode.summary ?? "N/A" }
   
   // MARK: - Init
   init(coordinator: AppCoordinator,
        episode: SingleEpisodeModel) {
      self.coordinator = coordinator
      self.episode = episode
   }
}
