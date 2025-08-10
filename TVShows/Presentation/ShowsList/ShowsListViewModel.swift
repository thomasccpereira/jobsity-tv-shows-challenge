import SwiftUI
import Foundation

@MainActor
@Observable
final class ShowsListViewModel {
   private unowned let coordinator: AppCoordinator
   private(set) var shows: [SingleShowModel] = []
   private(set) var error: String?
   private(set) var isLoading = false
   private(set) var canLoadMore = true
   
   private let fetchShowsUseCase: FetchShowsPageUseCase?
   private var nextPage = 0
   
   init(coordinator: AppCoordinator,
        fetchShowsUseCase: FetchShowsPageUseCase? = nil) {
      self.coordinator = coordinator
      self.fetchShowsUseCase = fetchShowsUseCase
   }
   
   func loadFirstPage() async throws {
      if shows.isEmpty {
         try await loadMore()
      }
   }
   
   func loadMoreShowsIfNeeded(after presentedShow: SingleShowModel) async throws {
      if canLoadMore, presentedShow == shows.suffix(5).first {
         try await loadMore()
      }
   }
   
   private func loadMore() async throws {
      guard !isLoading else { return }
      isLoading = true
      
      do {
         let repository = ShowsRepositoryImpl()
         let fetchPage = fetchShowsUseCase ?? FetchShowsPageUseCaseImpl(respository: repository)
         let page = try await fetchPage(page: nextPage)
         shows += page.items
         nextPage = page.pageIndex + 1
         canLoadMore = page.hasNextPage
         
      } catch {
         self.error = String(describing: error)
      }
      
      isLoading = false
   }
}
