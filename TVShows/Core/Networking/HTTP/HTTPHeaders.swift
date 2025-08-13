import Foundation

typealias HTTPHeaders = [String: String]
typealias HTTPBody = [String: any Sendable]

enum HTTPMethod: String, Sendable {
   case head = "HEAD"
   case get = "GET"
   case post = "POST"
   case put = "PUT"
   case delete = "DELETE"
   case patch = "PATCH"
}
