import Foundation
@testable import TVShows

struct StubFetchShowsUseCase: FetchShowsPageUseCase {
   var handler: @Sendable (Int) async throws -> Envelope<Page<SingleShowModel>>
   func callAsFunction(page: Int) async throws -> Envelope<Page<SingleShowModel>> { try await handler(page) }
}
