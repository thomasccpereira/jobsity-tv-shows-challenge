import SwiftData
import Foundation

@MainActor
enum FavoritesRepositoryError: Error, @preconcurrency LocalizedError {
   case notFound(id: Int)
   case alreadyExists(id: Int)
   
   var errorDescription: String? {
      switch self {
      case .notFound(let id): return "Favorite with id \(id) was not found."
      case .alreadyExists(let id): return "Favorite with id \(id) already exists."
      }
   }
}

@MainActor
final class FavoritesRepositoryImpl: FavoritesRepository {
   private let context: ModelContext
   
   init(context: ModelContext) {
      self.context = context
   }
   
   // MARK: - Create
   func addShowToFavorites(_ show: SingleShowModel) async throws {
      if let existing = try await findDAO(by: show.id) {
         existing.applyUpdate(from: show)
         
      } else {
         let dao = SingleShowDAO.make(from: show)
         context.insert(dao)
      }
      
      try context.save()
   }
   
   // MARK: - Read
   func fetchFavorites() async throws -> [SingleShowModel] {
      let descriptor = FetchDescriptor<SingleShowDAO>(sortBy: [ SortDescriptor(\.name, order: .forward) ])
      return try context.fetch(descriptor).map(\.domainModelObject)
   }
   
   // MARK: - Delete
   func removeShowFromFavorites(showID: Int) async throws {
      if let dao = try await findDAO(by: showID) {
         context.delete(dao)
         try context.save()
      }
   }
   
   // MARK: - Helpers
   private func findDAO(by id: Int) async throws -> SingleShowDAO? {
      let predicate = #Predicate<SingleShowDAO> { $0.id == id }
      
      var descriptor = FetchDescriptor<SingleShowDAO>(predicate: predicate)
      descriptor.fetchLimit = 1
      
      return try context.fetch(descriptor).first
   }
}
