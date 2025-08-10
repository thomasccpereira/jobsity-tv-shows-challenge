import SwiftUI
import Foundation

@MainActor
@Observable
final class ShowsListViewModel {
   enum PaginationState: Equatable {
      case idle(nextPage: Int)
      case isPaginating
      case didFail(page: Int, errorMessage: String)
      case endOfList
   }
   
   // Properties
   // Coordinator
   private unowned let coordinator: AppCoordinator
   // Use cases
   private let fetchShowsUseCase: FetchShowsPageUseCase?
   // State
   private(set) var shows: [SingleShowModel] = []
   private(set) var isLoading = false
   private(set) var paginationState: PaginationState = .idle(nextPage: 0)
   private(set) var errorMessage: String?
   
   init(coordinator: AppCoordinator,
        fetchShowsUseCase: FetchShowsPageUseCase? = nil) {
      self.coordinator = coordinator
      self.fetchShowsUseCase = fetchShowsUseCase
   }
   
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
         let fetchedPage = try await fetchsPage(page: page)
         
         if page == 0 {
            shows = fetchedPage.items
         } else {
            shows += fetchedPage.items
         }
         
         if fetchedPage.hasNextPage {
            let nextPage = fetchedPage.pageIndex + 1
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
}
