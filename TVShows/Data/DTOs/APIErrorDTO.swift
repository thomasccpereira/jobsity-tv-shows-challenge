import Foundation

struct APIErrorDTO: Codable, Sendable {
   struct Previous: Codable, Sendable {
      let name: String
      let message: String
      let code: Int
   }
   
   let name: String
   let message: String
   let code: Int
   let status: Int?
   let previous: Previous?
}

extension APIErrorDTO: DataTransferableObjects {
   var domainModelObject: APIErrorModel {
      .init(name: name,
            message: message,
            code: code,
            httpStatus: status,
            underlying: .init(name: previous?.name, message: previous?.message, code: previous?.code))
   }
}

