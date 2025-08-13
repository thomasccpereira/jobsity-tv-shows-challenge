import Foundation
@testable import TVShows

// Centralized helpers that tests can use to build an in-memory DatabaseStore.
enum DatabaseTestHelpers {
   @MainActor
   static func makeInMemoryStore() throws -> DatabaseStore {
      try DatabaseStore(models: DatabaseStore.databaseModels,
                        config: .init(inMemory: true))
   }
}
