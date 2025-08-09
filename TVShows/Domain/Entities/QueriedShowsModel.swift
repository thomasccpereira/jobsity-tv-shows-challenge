import Foundation

struct QueriedShowsModel {
   struct SingleQueriedShow {
      let score: Double
      let show: SingleShowModel
   }
   
   let queriedShows: [SingleQueriedShow]
}
