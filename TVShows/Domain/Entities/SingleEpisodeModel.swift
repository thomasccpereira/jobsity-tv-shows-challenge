import Foundation

struct SingleEpisodeModel: Sendable, Equatable, Hashable {
   struct Posters: Sendable, Equatable, Hashable {
      let mediumURL: URL?
      let originalURL: URL?
   }
   
   let id: Int
   let season: Int
   let number: Int
   let image: Posters?
   let name: String
   let summary: String?
   let runtime: Int?
}
