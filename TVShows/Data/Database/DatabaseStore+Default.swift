import SwiftData

extension DatabaseStore {
   static var databaseModels: [any PersistentModel.Type] {
      [
         PostersDAO.self,
         ScheduleDAO.self,
         SingleShowDAO.self,
         SingleEpisodeDAO.self
      ]
   }
}
