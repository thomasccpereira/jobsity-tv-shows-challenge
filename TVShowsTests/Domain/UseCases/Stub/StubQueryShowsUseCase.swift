import Foundation
@testable import TVShows

struct StubQueryShowsUseCase: QueryShowsUseCase {
   var handler: (String) async throws -> Envelope<QueriedShowsModel>
   func callAsFunction(query: String) async throws -> Envelope<QueriedShowsModel> { try await handler(query) }
}
