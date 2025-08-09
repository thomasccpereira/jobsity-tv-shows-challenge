import Foundation

public protocol NetworkRequestBuilder: Sendable {
   var requestConfig: NetworkRequestConfig { get }
   
   func buildRequest() throws -> URLRequest
}

extension NetworkRequestBuilder {
   // Default implementation
   func buildRequest() throws -> URLRequest {
      let urlString = requestConfig.host + requestConfig.path
      guard urlString.isValidURL, let url = URL(string: urlString) else {
         throw NetworkError.networkRequestBuildFailure
      }
      
      var request = URLRequest(url: url)
      request.httpMethod = requestConfig.method.rawValue
      request.allHTTPHeaderFields = requestConfig.headers
      request.httpBody = httpBody(requestConfig)
      request.timeoutInterval = 10
      
      return request
   }
   
   // Private method
   private func httpBody(_ requestConfig: NetworkRequestConfig) -> Data? {
      requestConfig.body?.data
   }
}
