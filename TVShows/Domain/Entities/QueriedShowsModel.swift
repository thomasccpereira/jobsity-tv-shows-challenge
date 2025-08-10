import Foundation

struct QueriedShowsModel: Sendable, Equatable, Hashable {
   struct SingleQueriedShow: Sendable, Equatable, Hashable {
      let score: Double
      let show: SingleShowModel
   }
   
   let queriedShows: [SingleQueriedShow]
}
