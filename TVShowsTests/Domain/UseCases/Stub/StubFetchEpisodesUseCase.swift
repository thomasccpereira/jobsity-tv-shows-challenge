import Foundation
@testable import TVShows

struct StubFetchEpisodesUseCase: FetchEpisodesUseCase {
   var handler: @Sendable (Int) async throws -> Envelope<EpisodesListModel>
   func callAsFunction(showID: Int) async throws -> Envelope<EpisodesListModel> { try await handler(showID) }
}
