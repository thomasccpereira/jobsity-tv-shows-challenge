import Foundation

protocol NetworkRequestBuilding: Sendable {
   func makeRequest(with config: NetworkRequestConfig) throws -> URLRequest
}

final class DefaultRequestBuilder: NetworkRequestBuilding {
   init() { }
   
   func makeRequest(with requestConfig: NetworkRequestConfig) throws -> URLRequest {
      let urlString = requestConfig.host + requestConfig.path
      
      var urlComponents = URLComponents(string: urlString)
      if let queryItems = requestConfig.queryItems {
         urlComponents?.queryItems = queryItems
      }
      
      guard let urlComponents,
            let encodedURLString = urlComponents.string?.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
            encodedURLString.isValidURL,
            let url = URL(string: encodedURLString) else {
         throw NetworkError.networkRequestBuildFailure
      }
      
      var request = URLRequest(url: url)
      request.httpMethod = requestConfig.method.rawValue
      request.allHTTPHeaderFields = requestConfig.headers
      
      if let queryItems = requestConfig.queryItems {
         request.url = request.url?.appending(queryItems: queryItems)
      }
      
      request.httpBody = httpBody(requestConfig)
      request.timeoutInterval = 10
      
      return request
   }
   
   // Private method
   private func httpBody(_ requestConfig: NetworkRequestConfig) -> Data? {
      requestConfig.body?.data
   }
}
