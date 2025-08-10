import Foundation

struct SingleShowModel: Sendable, Equatable, Hashable {
   struct Posters: Sendable, Equatable, Hashable {
      let mediumURL: URL?
      let originalURL: URL?
   }
   
   struct Schedule: Sendable, Equatable, Hashable {
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
