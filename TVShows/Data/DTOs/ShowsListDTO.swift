import Foundation

struct ShowsListDTO: Codable {
   let shows: [SingleShowDTO]
   
   init(from decoder: any Decoder) throws {
      var container = try decoder.unkeyedContainer()
      self.shows = try container.decode([SingleShowDTO].self)
   }
}

extension ShowsListDTO: DataTransferableObjects {
   var domainModelObject: ShowsListModel {
      .init(shows: shows.compactMap(\.domainModelObject))
   }
}
