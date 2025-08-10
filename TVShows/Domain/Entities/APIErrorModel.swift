import Foundation

struct APIErrorModel: Error, Equatable, Sendable {
   struct Underlying: Equatable, Sendable {
      let name: String
      let message: String
      let code: Int
      
      init?(name: String?, message: String?, code: Int?) {
         guard let name, let message, let code else { return nil }
         self.name = name
         self.message = message
         self.code = code
      }
   }
   
   let name: String
   let message: String
   let code: Int
   let httpStatus: Int?
   let underlying: Underlying?
}

extension APIErrorModel: LocalizedError {
   var errorDescription: String? { message }
   var failureReason: String? { name }
}
