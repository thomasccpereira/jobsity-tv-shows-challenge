import Foundation

struct EpisodesListDTO: Codable {
   let episodes: [SingleEpisodeDTO]
   
   init(from decoder: any Decoder) throws {
      var container = try decoder.unkeyedContainer()
      self.episodes = try container.decode([SingleEpisodeDTO].self)
   }
}

extension EpisodesListDTO: DataTransferableObjects {
   var domainModelObject: EpisodesListModel {
      .init(episodes: episodes.compactMap(\.domainModelObject))
   }
}

