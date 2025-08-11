import SwiftData
import Foundation

@MainActor
final class FavoritesRepositoryImpl: FavoritesRepository {
   private let databaseStore: DatabaseStore
   
   init(databaseStore: DatabaseStore) {
      self.databaseStore = databaseStore
   }
   
   // MARK: - Check
   func checkIfShowIsFavorite(_ showID: Int) async throws -> Bool {
      try await findSingleShowDAO(by: showID) != nil
   }
   
   // MARK: - Create
   func addShowToFavorites(_ show: SingleShowModel) async throws {
      if let existing = try await findSingleShowDAO(by: show.id) {
         existing.applyUpdate(from: show)
         
      } else {
         let dao = SingleShowDAO.make(from: show)
         try await databaseStore.insert(dao)
      }
   }
   
   func addShowEpisodesToFavorites(_ episodes: [SingleEpisodeModel],
                                   ofShow show: SingleShowModel) async throws {
      let existings = try await findShowEpisodeDAOs(by: show.id)
      
      if !existings.isEmpty {
         try await databaseStore.delete(existings)
      }
      
      var daos: [SingleEpisodeDAO] = []
      
      for episode in episodes {
         let dao = SingleEpisodeDAO.make(from: episode,
                                         ofShow: show)
         daos.append(dao)
      }
      
      try await databaseStore.insertAll(daos)
   }
   
   // MARK: - Read
   func fetchFavorites() async throws -> [SingleShowModel] {
      let sortBy: [SortDescriptor<SingleShowDAO>] = [ SortDescriptor(\.name, order: .forward) ]
      return try await databaseStore.fetch(sortBy: sortBy).map(\.domainModelObject)
   }
   
   func fetchFavoritesEpisodes(showID: Int) async throws -> [SingleEpisodeModel] {
      return try await findShowEpisodeDAOs(by: showID).map(\.domainModelObject)
   }
   
   // MARK: - Delete
   func removeShowFromFavorites(showID: Int) async throws {
      if let dao = try await findSingleShowDAO(by: showID) {
         try await databaseStore.delete(dao)
      }
   }
   
   func removeShowEpisodesFromFavorites(showID: Int) async throws {
      let daos = try await findShowEpisodeDAOs(by: showID)
      try await databaseStore.delete(daos)
   }
   
   // MARK: - Helpers
   private func findSingleShowDAO(by id: Int) async throws -> SingleShowDAO? {
      let predicate = #Predicate<SingleShowDAO> { $0.id == id }
      return try await databaseStore.fetch(matching: predicate).first
   }
   
   private func findShowEpisodeDAOs(by showID: Int) async throws -> [SingleEpisodeDAO] {
      let predicate = #Predicate<SingleEpisodeDAO> { $0.showID == showID }
      
      let sortBy: [SortDescriptor<SingleEpisodeDAO>] = [
         SortDescriptor(\.season, order: .forward),
         SortDescriptor(\.number, order: .forward)
      ]
      
      return try await databaseStore.fetch(matching: predicate, sortBy: sortBy)
   }
}
