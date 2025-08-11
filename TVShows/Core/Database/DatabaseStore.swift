import SwiftData
import Foundation

@MainActor
final class DatabaseStore {
   let container: ModelContainer
   let context: ModelContext
   
   init(models: [any PersistentModel.Type],
        config: SwiftDataStoreConfig = .init()) throws {
      do {
         let configuration = ModelConfiguration(config.configurationName,
                                                isStoredInMemoryOnly: config.inMemory)
         self.container = try ModelContainer(for: Schema(models), configurations: configuration)
         self.context = ModelContext(container)
         
      } catch {
         throw DatabaseStoreError.containerCreationFailed(underlying: error)
      }
   }
   
   // MARK: - Create
   @discardableResult
   func insert<T: PersistentModel>(_ model: T) async throws -> T {
      context.insert(model)
      try context.save()
      return model
   }
   
   func insertAll<T: PersistentModel>(_ models: [T]) async throws {
      try await transaction {
         models.forEach { context.insert($0) }
      }
   }
   
   // MARK: - Read
   func fetch<T: PersistentModel>(matching predicate: Predicate<T>? = nil,
                                  sortBy: [SortDescriptor<T>] = [],
                                  limit: Int? = nil,
                                  offset: Int = 0) async throws -> [T] {
      var descriptor = FetchDescriptor<T>(predicate: predicate, sortBy: sortBy)
      if let limit { descriptor.fetchLimit = limit }
      descriptor.fetchOffset = offset
      return try context.fetch(descriptor)
   }
   
   func first<T: PersistentModel>(matching predicate: Predicate<T>) async throws -> T? {
      try await fetch(matching: predicate, limit: 1).first
   }
   
   func count<T: PersistentModel>(matching predicate: Predicate<T>? = nil) async throws -> Int {
      var descriptor = FetchDescriptor<T>(predicate: predicate)
      descriptor.fetchLimit = .max
      return try context.fetch(descriptor).count
   }
   
   // MARK: - Delete
   func delete<T: PersistentModel>(_ model: T) async throws {
      context.delete(model)
      try context.save()
   }
   
   func delete<T: PersistentModel>(_ models: [T]) async throws {
      try await transaction {
         models.forEach { context.delete($0) }
      }
   }
   
   @discardableResult
   func deleteAll<T: PersistentModel>(of type: T.Type,
                                      matching predicate: Predicate<T>? = nil) async throws -> Int {
      let items = try await fetch(matching: predicate)
      
      try await transaction {
         items.forEach { context.delete($0) }
      }
      
      return items.count
   }
   
   // MARK: - Update
   func save() async throws {
      try context.save()
   }
   
   // MARK: - Transaction
   // Runs a batch of ops and saves once at the end.
   func transaction(_ operations: () throws -> Void) async throws {
      try operations()
      try context.save()
   }
}
