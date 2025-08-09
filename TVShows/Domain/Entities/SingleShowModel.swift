import Foundation

struct SingleShowModel {
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
