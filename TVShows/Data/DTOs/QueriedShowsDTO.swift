import Foundation

struct QueriedShowsDTO: Codable {
   struct SingleQueriedShow: Codable, DataTransferableObjects {
      let score: Double
      let show: SingleShowDTO
      
      var domainModelObject: QueriedShowsModel.SingleQueriedShow {
         .init(score: score,
               show: show.domainModelObject)
      }
   }
   
   let queriedShows: [SingleQueriedShow]
   
   init(from decoder: any Decoder) throws {
      var container = try decoder.unkeyedContainer()
      self.queriedShows = try container.decode([SingleQueriedShow].self)
   }
}

extension QueriedShowsDTO: DataTransferableObjects {
   var domainModelObject: QueriedShowsModel {
      .init(queriedShows: queriedShows.compactMap(\.domainModelObject))
   }
}
