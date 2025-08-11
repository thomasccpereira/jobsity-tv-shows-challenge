import SwiftData
import Foundation

@Model
final class SingleShowDAO {
   @Model
   class Posters {
      var medium: String?
      var original: String?
      
      init(medium: String? = nil, original: String? = nil) {
         self.medium = medium
         self.original = original
      }
   }
   
   @Model
   class Schedule {
      var time: String
      var days: [String]
      
      init(time: String, days: [String]) {
         self.time = time
         self.days = days
      }
   }
   
   var id: Int
   var image: Posters?
   var name: String
   var schedule: Schedule
   var genres: [String]
   var runtime: Int?
   var summary: String?
   
   init(id: Int,
        image: Posters? = nil,
        name: String,
        schedule: Schedule,
        genres: [String],
        runtime: Int? = nil,
        summary: String? = nil) {
      self.id = id
      self.image = image
      self.name = name
      self.schedule = schedule
      self.genres = genres
      self.runtime = runtime
      self.summary = summary
   }
}

extension SingleShowDAO.Posters: DataAccessibleObject {
   var domainModelObject: SingleShowModel.Posters {
      .init(mediumURL: medium.flatMap(URL.init(string:)),
            originalURL: original.flatMap(URL.init(string:)))
   }
}

extension SingleShowDAO.Schedule: DataAccessibleObject {
   var domainModelObject: SingleShowModel.Schedule {
      .init(time: time,
            days: days)
   }
}

extension SingleShowDAO: DataAccessibleObject {
   var domainModelObject: SingleShowModel {
      .init(id: id,
            image: image?.domainModelObject,
            name: name,
            schedule: schedule.domainModelObject,
            genres: genres,
            runtime: runtime,
            summary: summary?.strippingHTML)
   }
}

extension SingleShowDAO {
   // Factory to persist a domain model into SwiftData.
   static func make(from domain: SingleShowModel) -> SingleShowDAO {
      let posters: Posters? = {
         guard domain.image?.mediumURL != nil || domain.image?.originalURL != nil else { return nil }
         
         return Posters(medium: domain.image?.mediumURL?.absoluteString,
                        original: domain.image?.originalURL?.absoluteString)
      }()
      
      let schedule = Schedule(time: domain.schedule.time,
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
      genres = domain.genres
      runtime = domain.runtime
      summary = domain.summary
      
      // Schedule
      schedule.time = domain.schedule.time
      schedule.days = domain.schedule.days
      
      // Posters can be created/updated/cleared
      let mediumURLString = domain.image?.mediumURL?.absoluteString
      let originalURLString = domain.image?.originalURL?.absoluteString
      
      if let image = domain.image {
         self.image = Posters(medium: mediumURLString,
                              original: originalURLString)
         
      } else {
         self.image = nil
      }
   }
}
