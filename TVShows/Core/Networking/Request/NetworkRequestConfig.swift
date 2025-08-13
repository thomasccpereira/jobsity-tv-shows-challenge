import Foundation

protocol NetworkRequestConfig: Sendable {
   var host: String { get }
   var path: String { get }
   var method: HTTPMethod { get }
   var headers: HTTPHeaders? { get }
   var queryItems: [URLQueryItem]? { get }
   var body: HTTPBody? { get }
}

extension NetworkRequestConfig {
   var host: String { "https://api.tvmaze.com" }
   
   var method: HTTPMethod { .get }
   
   var headers: HTTPHeaders? { [ "Content-Type": "application/json; charset=utf-8" ] }
   
   var body: HTTPBody? { nil }
}
