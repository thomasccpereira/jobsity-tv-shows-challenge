import Testing
import SwiftUI
@testable import TVShows

@Suite
@MainActor
struct EpisodeDetailViewModelTests {
   private func ep(_ number: Int?) -> SingleEpisodeModel {
      .init(id: 1,
            season: 2,
            number: number,
            image: .init(mediumURL: URL(string: "https://example.com/m.jpg"), originalURL: URL(string: "https://example.com/o.jpg")),
            name: "Pilot",
            summary: nil,
            runtime: 42)
   }
   
   @Test func computedProperties_withNumber() {
      let coordinator = AppCoordinator()
      let vm = EpisodeDetailViewModel(coordinator: coordinator, episode: ep(3))
      #expect(vm.episodeTitle == "Pilot")
      #expect(vm.episodeSeason == "S2") // Int.prettySeason
      #expect(vm.episodeNumber == "EP #3")
      #expect(vm.episodePosterImageURL?.absoluteString == "https://example.com/o.jpg")
      #expect(vm.episodeSummary == "N/A")
   }
   
   @Test func computedProperties_withoutNumber() {
      let coordinator = AppCoordinator()
      let vm = EpisodeDetailViewModel(coordinator: coordinator, episode: ep(nil))
      #expect(vm.episodeNumber == "EP #N/A")
   }
}
