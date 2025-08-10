import Foundation

protocol QueryShowsUseCase: Sendable {
   func callAsFunction(query: String) async throws -> Envelope<QueriedShowsModel>
}

struct QueryShowsUseCaseImpl: QueryShowsUseCase {
   private let repository: ShowsRepository
   
   init(repository: ShowsRepository) {
      self.repository = repository
   }
   
   func callAsFunction(query: String) async throws -> Envelope<QueriedShowsModel> {
      try await repository.searchShow(query: query)
   }
}
