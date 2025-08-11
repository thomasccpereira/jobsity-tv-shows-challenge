import Foundation

struct SingleEpisodeDTO: Codable {
   struct Posters: Codable {
      let medium: String?
      let original: String?
   }
   
   let id: Int
   let season: Int
   let number: Int?
   let image: Posters?
   let name: String
   let summary: String?
   let runtime: Int?
}

extension SingleEpisodeDTO.Posters: DataTransferableObjects {
   var domainModelObject: SingleEpisodeModel.Posters {
      .init(mediumURL: medium.flatMap(URL.init(string:)),
            originalURL: original.flatMap(URL.init(string:)))
   }
}

extension SingleEpisodeDTO: DataTransferableObjects {
   var domainModelObject: SingleEpisodeModel {
      .init(id: id,
            season: season,
            number: number,
            image: image?.domainModelObject,
            name: name,
            summary: summary?.strippingHTML,
            runtime: runtime)
   }
}
