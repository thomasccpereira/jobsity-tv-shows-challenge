import Foundation

struct FetchShowsPageUseCase {
   private let repository: ShowsRepository
   
   init(respository: ShowsRepository) {
      self.repository = respository
   }
   
   func callAsFunction(page: Int) async throws -> Page<SingleShowModel> {
      try await repository.fetchShows(page: page)
   }
}
