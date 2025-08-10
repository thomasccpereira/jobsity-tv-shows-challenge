import Foundation

struct EpisodesListDTO: Codable {
   let episodes: [SingleEpisodeDTO]
   let error: APIErrorDTO?
   
   init(from decoder: any Decoder) throws {
      do {
         let shows = try [SingleEpisodeDTO](from: decoder)
         self.episodes = shows
         self.error = nil
         
      } catch {
         do {
            let error = try APIErrorDTO(from: decoder)
            self.episodes = []
            self.error = error
            
         } catch {
            throw NetworkError.decodingGenericError(error: error)
         }
      }
   }
}

extension EpisodesListDTO: DataTransferableObjects {
   var domainModelObject: EpisodesListModel {
      .init(episodes: episodes.compactMap(\.domainModelObject))
   }
}

