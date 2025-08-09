import Foundation

struct QueriedShowsDTO: Codable {
   struct SingleQueriedShow: Codable {
      let score: Double
      let show: SingleShowDTO
   }
   
   let queriedShows: [SingleQueriedShow]
   
   init(from decoder: any Decoder) throws {
      var container = try decoder.unkeyedContainer()
      self.queriedShows = try container.decode([SingleQueriedShow].self)
   }
}
