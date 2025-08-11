import SwiftData
import Foundation

@Model
final class SingleEpisodeDAO {
   var showID: Int
   var id: Int
   var season: Int
   var number: Int?
   @Relationship(deleteRule: .cascade) var image: PostersDAO?
   var name: String
   var summary: String?
   var runtime: Int?
   
   init(showID: Int,
        id: Int,
        season: Int,
        number: Int?,
        image: PostersDAO?,
        name: String,
        summary: String?,
        runtime: Int?) {
      self.showID = showID
      self.id = id
      self.season = season
      self.number = number
      self.image = image
      self.name = name
      self.summary = summary
      self.runtime = runtime
   }
}

extension SingleEpisodeDAO: DataAccessibleObject {
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

extension SingleEpisodeDAO {
   // Factory to persist a domain model into SwiftData.
   static func make(from domain: SingleEpisodeModel, ofShow show: SingleShowModel) -> SingleEpisodeDAO {
      let posters: PostersDAO? = {
         guard domain.image?.mediumURL != nil || domain.image?.originalURL != nil else { return nil }
         
         return PostersDAO(medium: domain.image?.mediumURL?.absoluteString,
                           original: domain.image?.originalURL?.absoluteString)
      }()
      
      return SingleEpisodeDAO(showID: show.id,
                              id: domain.id,
                              season: domain.season,
                              number: domain.number,
                              image: posters,
                              name: domain.name,
                              summary: domain.summary,
                              runtime: domain.runtime)
   }

   // Update an existing tracked DAO in-place from a domain model.
   func applyUpdate(from domain: SingleEpisodeModel) {
      // Main info
      season = domain.season
      number = domain.number
      name = domain.name
      summary = domain.summary
      runtime = domain.runtime
      
      // Posters can be created/updated/cleared
      if let image = domain.image {
         self.image = PostersDAO(medium: image.mediumURL?.absoluteString,
                                 original: image.originalURL?.absoluteString)
         
      } else {
         self.image = nil
      }
   }
}
