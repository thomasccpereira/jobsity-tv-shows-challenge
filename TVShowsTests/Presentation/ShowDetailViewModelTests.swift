import Testing
import SwiftUI
@testable import TVShows

@Suite(.serialized)
@MainActor
struct ShowDetailViewModelTests {
   private struct StubFetchEpisodes: FetchEpisodesUseCase {
      var handler: (Int) async throws -> Envelope<EpisodesListModel>
      func callAsFunction(showID: Int) async throws -> Envelope<EpisodesListModel> { try await handler(showID) }
   }
   
   private func makeShow(id: Int = 1) -> SingleShowModel {
      .init(id: id,
            image: .init(mediumURL: nil, originalURL: nil),
            name: "Demo Show",
            schedule: .init(time: "07:00", days: ["Monday"]),
            genres: ["Comedy","Drama"],
            runtime: 30,
            summary: "Summary")
   }
   
   @Test func loadEpisodes_groupsBySeason_andStopsLoading() async throws {
      let coordinator = AppCoordinator()
      let episodes = EpisodesListModel(episodes: [
         .init(id: 1, season: 1, number: 1, image: nil, name: "S1E1", summary: nil, runtime: 10),
         .init(id: 2, season: 2, number: 1, image: nil, name: "S2E1", summary: nil, runtime: 10),
         .init(id: 3, season: 1, number: 2, image: nil, name: "S1E2", summary: nil, runtime: 10)
      ])
      let stub = StubFetchEpisodes { _ in Envelope(model: episodes) }
      let vm = ShowDetailViewModel(coordinator: coordinator, show: makeShow(), fetchEpisodesUseCase: stub)
      
      try await vm.loadEpisodes()
      
      // Expect two seasons: 1 and 2, grouped
      #expect(vm.seasons.count == 2)
      let s1 = vm.seasons.first { $0.id == 1 }!
      let s2 = vm.seasons.first { $0.id == 2 }!
      #expect(s1.episodes.count == 2)
      #expect(s2.episodes.count == 1)
      #expect(vm.isLoading == false)
      #expect(vm.errorMessage == nil)
      // Computed props sanity
      #expect(vm.showTitle == "Demo Show")
      #expect(vm.showGenres == "Comedy, Drama")
   }
   
   @Test func loadEpisodes_setsErrorMessage_onErrorEnvelope() async throws {
      let coordinator = AppCoordinator()
      let stub = StubFetchEpisodes { _ in Envelope<EpisodesListModel>(model: nil, errorMessage: "Fail") }
      let vm = ShowDetailViewModel(coordinator: coordinator, show: makeShow(), fetchEpisodesUseCase: stub)
      
      try await vm.loadEpisodes()
      
      // The view model leaves skeleton previews in 'seasons' but stops loading.
      #expect(vm.errorMessage == "Fail")
      #expect(vm.isLoading == false)
   }
   
   @Test func navigateToEpisodeDetail_pushesPath() async throws {
      let coordinator = AppCoordinator()
      let vm = ShowDetailViewModel(coordinator: coordinator, show: makeShow())
      let episode = SingleEpisodeModel(id: 9, season: 3, number: 7, image: nil, name: "Ep", summary: nil, runtime: nil)
      
      vm.navigateToEpisodeDetail(for: episode)
      #expect(coordinator.paths.last == .episodeDetails(episode: episode))
   }
}
