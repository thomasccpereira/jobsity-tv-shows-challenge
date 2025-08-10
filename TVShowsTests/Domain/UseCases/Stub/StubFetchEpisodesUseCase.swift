import Foundation
@testable import TVShows

struct StubFetchEpisodesUseCase: FetchEpisodesUseCase {
   var handler: (Int) async throws -> Envelope<EpisodesListModel>
   func callAsFunction(showID: Int) async throws -> Envelope<EpisodesListModel> { try await handler(showID) }
}
