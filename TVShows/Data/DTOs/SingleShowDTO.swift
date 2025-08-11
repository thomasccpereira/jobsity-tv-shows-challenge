import Foundation

struct SingleShowDTO: Codable {
   struct Posters: Codable {
      let medium: String?
      let original: String?
   }
   
   struct Schedule: Codable {
      let time: String
      let days: [String]
   }
   
   let id: Int
   let image: Posters?
   let name: String
   let schedule: Schedule
   let genres: [String]
   let runtime: Int?
   let summary: String?
}

extension SingleShowDTO.Posters: DataTransferableObjects {
   var domainModelObject: SingleShowModel.Posters {
      .init(mediumURL: medium.flatMap(URL.init(string:)),
            originalURL: original.flatMap(URL.init(string:)))
   }
}

extension SingleShowDTO.Schedule: DataTransferableObjects {
   var domainModelObject: SingleShowModel.Schedule {
      .init(time: time,
            days: days)
   }
}

extension SingleShowDTO: DataTransferableObjects {
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
