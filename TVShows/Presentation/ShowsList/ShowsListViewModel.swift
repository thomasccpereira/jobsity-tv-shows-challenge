import SwiftUI
import Foundation

@MainActor
@Observable
final class ShowsListViewModel {
   // MARK: - Properties
   // Coordinator
   private unowned let coordinator: AppCoordinator
   // Use cases
   private let fetchShowsUseCase: FetchShowsPageUseCase?
   // State
   private(set) var shows: [SingleShowModel] = []
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
        fetchShowsUseCase: FetchShowsPageUseCase? = nil) {
      self.coordinator = coordinator
      self.fetchShowsUseCase = fetchShowsUseCase
   }
   
   // MARK: - Fetching
   func loadShowsIfNeeded(after presentedShow: SingleShowModel? = nil) async throws {
      switch paginationState {
      case .idle(let nextPage):
         if nextPage == 0 {
            withAnimation {
               shows = .showsListPreview
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
            return
         }
         
         let fetchedShows = fetchedEnvelope.model?.items ?? []
         if page == 0 {
            shows = fetchedShows
         } else {
            shows += fetchedShows
         }
         
         if let model = fetchedEnvelope.model, model.hasNextPage {
            let nextPage = model.pageIndex + 1
            paginationState = .idle(nextPage: nextPage)
            
         } else {
            paginationState = .endOfList
         }
         
      } catch {
         if page == 0 {
            shows = []
            errorMessage = error.localizedDescription
            
         } else {
            paginationState = .didFail(page: page, errorMessage: error.localizedDescription)
         }
      }
      
      withAnimation(.easeInOut) { isLoading = false }
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
   
   // MARK: - Navigation
   func navigateToShowDetail(for show: SingleShowModel) {
      coordinator.goToPath(.showDetails(show: show))
   }
}
