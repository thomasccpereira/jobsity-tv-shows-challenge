import Foundation

public enum NetworkHTTPMethod: String, Sendable {
   case head = "HEAD"
   case get = "GET"
   case post = "POST"
   case put = "PUT"
   case delete = "DELETE"
   case patch = "PATCH"
}
