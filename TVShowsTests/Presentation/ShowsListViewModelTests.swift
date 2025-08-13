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
      // Use an in-memory SwiftData store for tests
      let store = try DatabaseStore(models: DatabaseStore.databaseModels,
                                    config: .init(inMemory: true))
      
      let show = SingleShowModel(id: 1,
                                  image: nil,
                                  name: "Kirby",
                                  schedule:.init(time: "", days: []),
                                  genres: [],
                                  runtime: nil,
                                  summary: nil)
      let queriedShows = QueriedShowsModel.SingleQueriedShow(score: 1.0,
                                                             show: show)
      let queried = QueriedShowsModel(queriedShows: [ queriedShows ])
      
      let mockedUseCase = StubQueryShowsUseCase(handler: { _ in Envelope(model: queried) })
      let viewModel = ShowsListViewModel(coordinator: coordinator,
                                         store: store,
                                         fetchShowsUseCase: nil,
                                         queryShowsUseCase: mockedUseCase)
      
      viewModel.searchText = "Kir"
      
      // Wait for debounce (500ms) + work; poll until results land
      let ok = await eventually( _ : viewModel.shows.first?.name == "Kirby" && viewModel.isPerformingQuery == false )
      #expect(ok, "Expected debounced query to complete and results to be set")
   }
   
   @Test func cancelSearchClearsState() async throws {
      let coordinator = AppCoordinator()
      // Use an in-memory SwiftData store for tests
      let store = try DatabaseStore(models: DatabaseStore.databaseModels,
                                    config: .init(inMemory: true))
      
      let viewModel = ShowsListViewModel(coordinator: coordinator, store: store)
      
      viewModel.searchText = "abc"
      viewModel.cancelSearch()
      
      // Allow any pending scheduled task to be cancelled and state to settle
      _ = await eventually( _ : viewModel.isPerformingQuery == false )
      
      #expect(viewModel.shows.isEmpty)
      #expect(viewModel.isPerformingQuery == false)
      #expect(viewModel.errorMessage == nil)
   }
}
