import Foundation

struct SingleEpisodeModel {
   struct Posters: Codable {
      let medium: String?
      let original: String?
   }
   
   let id: Int
   let season: Int
   let number: Int
   let image: Posters?
   let name: String
   let runtime: Int?
}
