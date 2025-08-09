import Foundation

struct SingleShowModel: Sendable, Equatable {
   struct Posters: Sendable, Equatable {
      let mediumURL: URL?
      let originalURL: URL?
   }
   
   struct Schedule: Sendable, Equatable {
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
