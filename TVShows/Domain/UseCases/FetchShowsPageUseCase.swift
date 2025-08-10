import Foundation

protocol FetchShowsPageUseCase: Sendable {
   func callAsFunction(page: Int) async throws -> Envelope<Page<SingleShowModel>>
}

struct FetchShowsPageUseCaseImpl: FetchShowsPageUseCase {
   private let repository: ShowsRepository
   
   init(respository: ShowsRepository) {
      self.repository = respository
   }
   
   func callAsFunction(page: Int) async throws -> Envelope<Page<SingleShowModel>> {
      try await repository.fetchShows(page: page)
   }
}
