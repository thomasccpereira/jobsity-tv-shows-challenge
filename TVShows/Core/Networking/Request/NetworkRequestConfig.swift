import Foundation

public protocol NetworkRequestConfig: Sendable {
   var host: String { get }
   var path: String { get }
   var method: NetworkHTTPMethod { get }
   var headers: [String: String]? { get }
   var body: [String: any Sendable]? { get }
}
