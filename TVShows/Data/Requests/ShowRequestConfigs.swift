import Foundation

enum ShowRequestConfigs {
   case listShows(page: Int)
   case getDetailedShow(showID: Int)
extension ShowRequestConfigs: NetworkRequestConfig {
   var path: String {
      switch self {
      case .listShows: "/shows"
      case .getDetailedShow(let showID): "/seasons/\(showID)/episodes"
      }
   }
   
   var queryItems: [URLQueryItem]? {
      switch self {
      case .listShows(let page):
         [
            .init(name: "page", value: String(page))
         ]
         
      case .getDetailedShow: nil
      }
   }
}
