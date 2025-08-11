import SwiftData
import Foundation

@Model
final class SingleShowDAO {
   var id: Int
   @Relationship(deleteRule: .cascade) var image: PostersDAO?
   var name: String
   @Relationship(deleteRule: .cascade) var schedule: ScheduleDAO
   var genres: String
   var runtime: Int?
   var summary: String?
   
   init(id: Int,
        image: PostersDAO?,
        name: String,
        schedule: ScheduleDAO,
        genres: [String],
        runtime: Int?,
        summary: String?) {
      self.id = id
      self.image = image
      self.name = name
      self.schedule = schedule
      self.genres = genres.joined(separator: "-")
      self.runtime = runtime
      self.summary = summary
   }
}

extension SingleShowDAO: DataAccessibleObject {
   var domainModelObject: SingleShowModel {
      .init(id: id,
            image: .init(mediumURL: image?.medium.flatMap(URL.init(string:)),
                         originalURL: image?.original.flatMap(URL.init(string:))),
            name: name,
            schedule: schedule.domainModelObject,
            genres: genres.components(separatedBy: "-"),
            runtime: runtime,
            summary: summary?.strippingHTML)
   }
}

extension SingleShowDAO {
   // Factory to persist a domain model into SwiftData.
   static func make(from domain: SingleShowModel) -> SingleShowDAO {
      let posters: PostersDAO? = {
         guard domain.image?.mediumURL != nil || domain.image?.originalURL != nil else { return nil }
         
         return PostersDAO(medium: domain.image?.mediumURL?.absoluteString,
                           original: domain.image?.originalURL?.absoluteString)
      }()
      
      let schedule = ScheduleDAO(time: domain.schedule.time,
                                 days: domain.schedule.days)
      
      return SingleShowDAO(id: domain.id,
                           image: posters,
                           name: domain.name,
                           schedule: schedule,
                           genres: domain.genres,
                           runtime: domain.runtime,
                           summary: domain.summary)
   }
   
   // Update an existing tracked DAO in-place from a domain model.
   func applyUpdate(from domain: SingleShowModel) {
      // Main info
      name = domain.name
      genres = domain.genres.joined(separator: "-")
      runtime = domain.runtime
      summary = domain.summary
      
      // Schedule
      schedule = .init(time: domain.schedule.time, days: domain.schedule.days)
      
      // Posters can be created/updated/cleared
      if let image = domain.image {
         self.image = PostersDAO(medium: image.mediumURL?.absoluteString,
                                 original: image.originalURL?.absoluteString)
         
      } else {
         self.image = nil
      }
   }
}
