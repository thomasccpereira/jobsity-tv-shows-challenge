import SwiftUI
import Foundation

@MainActor
@Observable
final class ShowsListViewModel {
   // MARK: - Properties
   // Coordinator
   private unowned let coordinator: AppCoordinator
   private let store: DatabaseStore
   // Use cases
   private let fetchShowsUseCase: FetchShowsPageUseCase?
   private let queryShowsUseCase: QueryShowsUseCase?
   // State
   var shows: [SingleShowModel] {
      isQueryActive ? queriedShows : fetchedShows
   }
   private var fetchedShows: [SingleShowModel] = []
   // Search
   private var searchTask: Task<Void, Never>?
   private let debounceDuration: Duration = .milliseconds(500)
   var searchText: String = "" {
      didSet {
         performQueryIfNeeded(searchText)
      }
   }
   private(set) var queriedShows: [SingleShowModel] = []
   private(set) var isPerformingQuery = false
   var isQueryActive: Bool { !searchText.trimmed.isEmpty }
   // Loading
   private(set) var isLoading = false
   // Pagination
   enum PaginationState: Equatable {
      case idle(nextPage: Int)
      case isPaginating
      case didFail(page: Int, errorMessage: String)
      case endOfList
   }
   // Pagination state
   private(set) var paginationState: PaginationState = .idle(nextPage: 0)
   // Errors
   private(set) var errorMessage: String?
   
   // MARK: - Init
   init(coordinator: AppCoordinator,
        store: DatabaseStore,
        fetchShowsUseCase: FetchShowsPageUseCase? = nil,
        queryShowsUseCase: QueryShowsUseCase? = nil) {
      self.coordinator = coordinator
      self.store = store
      self.fetchShowsUseCase = fetchShowsUseCase
      self.queryShowsUseCase = queryShowsUseCase
   }
   
   // MARK: - Fetching
   func loadShowsIfNeeded(after presentedShow: SingleShowModel? = nil) async throws {
      guard !isQueryActive else { return }
      
      switch paginationState {
      case .idle(let nextPage):
         if nextPage == 0 {
            withAnimation {
               fetchedShows = .showsListPreview
               errorMessage = nil
               isLoading = true
               Task { try await loadShows(page: nextPage) }
            }
            
         } else if let presentedShow, presentedShow == shows.suffix(5).first {
            withAnimation {
               paginationState = .isPaginating
               Task { try await loadShows(page: nextPage) }
            }
         }
         
      case .isPaginating, .endOfList, .didFail:
         return
      }
   }
   
   private func loadShows(page: Int) async throws {
      do {
         let repository = ShowsRepositoryImpl()
         let fetchsPage = fetchShowsUseCase ?? FetchShowsPageUseCaseImpl(respository: repository)
         let fetchedEnvelope = try await fetchsPage(page: page)
         
         if let fetchedError = fetchedEnvelope.errorMessage, !fetchedError.isEmpty {
            errorMessage = fetchedError
            withAnimation(.easeInOut) { isLoading = false }
            return
         }
         
         let fetchedShows = fetchedEnvelope.model?.items ?? []
         if page == 0 {
            self.fetchedShows = fetchedShows
         } else {
            self.fetchedShows += fetchedShows
         }
         
         if let model = fetchedEnvelope.model, model.hasNextPage {
            let nextPage = model.pageIndex + 1
            paginationState = .idle(nextPage: nextPage)
            
         } else {
            paginationState = .endOfList
         }
         
         withAnimation(.easeInOut) { isLoading = false }
         
      } catch {
         if page == 0 {
            fetchedShows = []
            errorMessage = error.localizedDescription
            
         } else {
            paginationState = .didFail(page: page, errorMessage: error.localizedDescription)
         }
         
         withAnimation(.easeInOut) { isLoading = false }
      }
   }
   
   func retryLoad() async throws {
      switch paginationState {
      case .idle:
         try await loadShowsIfNeeded()
         
      case .didFail(let page, _):
         try await loadShows(page: page)
         
      default:
         break
      }
   }
   
   // MARK: - Search
   func cancelSearch() {
      queriedShows = []
      errorMessage = nil
      isPerformingQuery = false
   }
   
   private func performQueryIfNeeded(_ query: String) {
      searchTask?.cancel()
      
      let trimmed = searchText.trimmed.lowercased()
      guard !trimmed.isEmpty else {
         cancelSearch()
         return
      }
      
      withAnimation(.easeInOut) { isPerformingQuery = true }
      
      searchTask = Task {
         // Wait for debounce duration
         do {
            try await Task.sleep(for: debounceDuration)
            
            // Check if task was cancelled during sleep
            guard !Task.isCancelled else { return }
            
            // Perform the actual search
            let results = try await performQuery(trimmed)
            
            // Update UI on main thread if not cancelled
            if !Task.isCancelled {
               await MainActor.run {
                  self.queriedShows = results
                  
                  withAnimation(.easeInOut) { isPerformingQuery = false }
               }
            }
         } catch {
            if !Task.isCancelled {
               await MainActor.run {
                  // Handle error
                  cancelSearch()
               }
            }
         }
      }
   }
   
   private func performQuery(_ query: String) async throws -> [SingleShowModel] {
      do {
         let repository = ShowsRepositoryImpl()
         let queries = queryShowsUseCase ?? QueryShowsUseCaseImpl(repository: repository)
         let queriedShows = try await queries(query: query)
         
         if let fetchedError = queriedShows.errorMessage, !fetchedError.isEmpty {
            errorMessage = fetchedError
            return []
         }
         
         return queriedShows.model?.queriedShows.compactMap(\.show) ?? []
         
      } catch {
         if case NetworkError.cancelled = error {
            return self.queriedShows
         }
         
         errorMessage = error.localizedDescription
         return []
      }
   }
   
   // MARK: - Navigation
   func navigateToFavorites() {
      coordinator.goToPath(.showFavorites)
   }
   
   func navigateToShowDetail(for show: SingleShowModel) {
      coordinator.goToPath(.showDetails(show: show))
   }
}
