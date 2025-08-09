import Foundation

protocol NetworkLogging: Sendable {
   func logRequest(_ request: URLRequest)
   func logResponse(_ response: URLResponse, data: Data?)
}

final class DefaultNetworkLogger: NetworkLogging {
   init() { }
   
   func logRequest(_ request: URLRequest) {
      #if DEBUG
      print("-------------------------- NETWORK REQUEST START --------------------------")
      
      if let url = request.url, let httpMethod = request.httpMethod {
         print("\(httpMethod) \(url)")
      }
      
      if let headers = request.allHTTPHeaderFields {
         print("Headers: \(headers)")
      }
      
      if let httpBody = request.httpBody, let bodyString = String(data: httpBody, encoding: .utf8) {
         print("Body: \(bodyString)")
      }
      
      print("--------------------------------------------------------------------------------")
      #endif
   }
   
   func logResponse(_ response: URLResponse, data: Data?) {
      #if DEBUG
      print("--------------------------- NETWORK RESPONSE START ---------------------------")
      
      if let httpResponse = response as? HTTPURLResponse {
         print("Response - Status Code: \(httpResponse.statusCode)")
         print("Response URL: \(httpResponse.url?.absoluteString ?? "Unknown URL")")
      }
      
      if let data = data, let dataString = String(data: data, encoding: .utf8) {
         print("Response Body: \(dataString)")
      }
      
      print("--------------------------- NETWORK RESPONSE END -----------------------------")
      #endif
   }
}
