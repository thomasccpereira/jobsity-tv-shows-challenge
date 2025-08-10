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
