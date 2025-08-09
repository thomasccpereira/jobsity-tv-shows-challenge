import Foundation

protocol NetworkRequestConfig: Sendable {
   var host: String { get }
   var path: String { get }
   var method: NetworkHTTPMethod { get }
   var headers: [String: String]? { get }
   var queryItems: [URLQueryItem]? { get }
   var body: [String: any Sendable]? { get }
}

extension NetworkRequestConfig {
   var host: String { "https://api.tvmaze.com" }
   
   var method: NetworkHTTPMethod { .get }
   
   var headers: [String: String]? { [ "Content-Type": "application/json; charset=utf-8" ] }
   
   var body: [String: any Sendable]? { nil }
}
