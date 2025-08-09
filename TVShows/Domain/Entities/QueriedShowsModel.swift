import Foundation

struct QueriedShowsModel: Sendable, Equatable {
   struct SingleQueriedShow: Sendable, Equatable {
      let score: Double
      let show: SingleShowModel
   }
   
   let queriedShows: [SingleQueriedShow]
}
