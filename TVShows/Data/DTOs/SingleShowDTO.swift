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

extension SingleShowDTO: DataTransferableObjects {
   var domainModelObject: SingleShowModel {
      .init(id: id,
            image: .init(mediumURL: image?.medium.flatMap(URL.init(string:)),
                         originalURL: image?.original.flatMap(URL.init(string:))),
            name: name,
            schedule: .init(time: schedule.time, days: schedule.days),
            genres: genres,
            runtime: runtime,
            summary: summary?.strippingHTML)
   }
}
