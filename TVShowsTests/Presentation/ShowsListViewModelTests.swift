import Testing
import SwiftUI
@testable import TVShows

// Small helper to wait until a condition is true or timeout
@MainActor
func eventually(timeout: UInt64 = 1_500_000_000, // 1.5s
                poll: UInt64 = 50_000_000,      // 50ms
                _ condition: @autoclosure @escaping () -> Bool) async -> Bool {
   var waited: UInt64 = 0
   while waited < timeout {
      if condition() { return true }
      try? await Task.sleep(nanoseconds: poll)
      waited += poll
   }
   return condition()
}

@Suite
@MainActor
struct ShowsListViewModelTests {
   @Test func performQueryDebouncedUpdatesResults() async throws {
      let coordinator = AppCoordinator()
      let queried = QueriedShowsModel(queriedShows: [
         .init(score: 1.0,
               show: .init(id: 1,
                           image: nil,
                           name: "Kirby",
                           schedule:.init(time:"", days:[]),
                           genres:[],
                           runtime:nil,
                           summary:nil))
      ])
      let vm = ShowsListViewModel(
         coordinator: coordinator,
         fetchShowsUseCase: nil,
         queryShowsUseCase: StubQueryShowsUseCase(handler: { _ in Envelope(model: queried) })
      )
      
      vm.searchText = "Kir"
      
      // Wait for debounce (500ms) + work; poll until results land
      let ok = await eventually( _ : vm.shows.first?.name == "Kirby" && vm.isPerformingQuery == false )
      #expect(ok, "Expected debounced query to complete and results to be set")
   }
   
   @Test func cancelSearchClearsState() async throws {
      let coordinator = AppCoordinator()
      let vm = ShowsListViewModel(coordinator: coordinator)
      
      vm.searchText = "abc"
      vm.cancelSearch()
      
      // Allow any pending scheduled task to be cancelled and state to settle
      _ = await eventually( _ : vm.isPerformingQuery == false )
      
      #expect(vm.shows.isEmpty)
      #expect(vm.isPerformingQuery == false)
      #expect(vm.errorMessage == nil)
   }
}
