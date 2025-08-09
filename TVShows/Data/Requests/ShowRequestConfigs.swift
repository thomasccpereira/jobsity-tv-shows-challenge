import Foundation

enum ShowRequestConfigs {
   case listShows(page: Int)
extension ShowRequestConfigs: NetworkRequestConfig {
   var path: String {
      switch self {
      case .listShows: "/shows"
      }
   }
   
   var queryItems: [URLQueryItem]? {
      switch self {
      case .listShows(let page):
         [
            .init(name: "page", value: String(page))
         ]
         
      }
   }
}
