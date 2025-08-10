import Foundation

struct ShowsListDTO: Codable {
   let shows: [SingleShowDTO]
   
   init(from decoder: any Decoder) throws {
      let shows = try [SingleShowDTO](from: decoder)
      self.shows = shows
   }
}

extension ShowsListDTO: DataTransferableObjects {
   var domainModelObject: ShowsListModel {
      .init(shows: shows.compactMap(\.domainModelObject))
   }
}
