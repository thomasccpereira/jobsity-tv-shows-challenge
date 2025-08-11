import SwiftData
import Foundation

@Model
final class ScheduleDAO {
   var time: String
   var days: String
   
   init(time: String, days: [String]) {
      self.time = time
      self.days = days.joined(separator: "-")
   }
}

extension ScheduleDAO: DataAccessibleObject {
   var domainModelObject: SingleShowModel.Schedule {
      .init(time: time,
            days: days.components(separatedBy: "-"))
   }
}
