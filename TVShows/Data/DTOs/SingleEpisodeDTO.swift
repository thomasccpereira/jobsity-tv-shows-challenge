import Foundation

struct SingleEpisodeDTO: Codable {
   struct Posters: Codable {
      let medium: String?
      let original: String?
   }
   
   let id: Int
   let season: Int
   let number: Int
   let image: Posters?
   let name: String
   let summary: String?
   let runtime: Int?
}

extension SingleEpisodeDTO: DataTransferableObjects {
   var domainModelObject: SingleEpisodeModel {
      .init(id: id,
            season: season,
            number: number,
            image: .init(mediumURL: image?.medium.flatMap(URL.init(string:)),
                         originalURL: image?.original.flatMap(URL.init(string:))),
            name: name,
            summary: summary?.strippingHTML,
            runtime: runtime)
   }
}
