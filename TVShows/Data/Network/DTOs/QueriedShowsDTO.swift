import Foundation

struct QueriedShowsDTO: Codable {
   struct SingleQueriedShow: Codable, DataTransferableObjects {
      let score: Double
      let show: SingleShowDTO
      
      var domainModelObject: QueriedShowsModel.SingleQueriedShow {
         .init(score: score,
               show: show.domainModelObject)
      }
   }
   
   let queriedShows: [SingleQueriedShow]
   let error: APIErrorDTO?
   
   init(from decoder: any Decoder) throws {
      do {
         let queriedShows = try [SingleQueriedShow](from: decoder)
         self.queriedShows = queriedShows
         self.error = nil
         
      } catch {
         do {
            let error = try APIErrorDTO(from: decoder)
            self.queriedShows = []
            self.error = error
            
         } catch {
            throw NetworkError.decodingGenericError(error: error)
         }
      }
   }
}

extension QueriedShowsDTO: DataTransferableObjects {
   var domainModelObject: QueriedShowsModel {
      .init(queriedShows: queriedShows.compactMap(\.domainModelObject))
   }
}
