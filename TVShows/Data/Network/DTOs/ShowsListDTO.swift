import Foundation

struct ShowsListDTO: Codable {
   let shows: [SingleShowDTO]
   let error: APIErrorDTO?
   
   init() {
      self.shows = []
      self.error = nil
   }
   
   init(from decoder: any Decoder) throws {
      do {
         let shows = try [SingleShowDTO](from: decoder)
         self.shows = shows
         self.error = nil
         
      } catch {
         do {
            let error = try APIErrorDTO(from: decoder)
            self.shows = []
            self.error = error
            
         } catch {
            throw NetworkError.decodingGenericError(error: error)
         }
      }
   }
}

extension ShowsListDTO: DataTransferableObjects {
   var domainModelObject: ShowsListModel {
      .init(shows: shows.compactMap(\.domainModelObject))
   }
}
