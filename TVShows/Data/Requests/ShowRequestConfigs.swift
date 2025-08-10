import Foundation

enum ShowRequestConfigs {
   case listShows(page: Int)
   case searchShows(query: String)
   case getDetailedShow(showID: Int)
}

extension ShowRequestConfigs: NetworkRequestConfig {
   var path: String {
      switch self {
      case .listShows: "/shows"
      case .searchShows: "/search/shows"
      case .getDetailedShow(let showID): "/seasons/\(showID)/episodes"
      }
   }
   
   var queryItems: [URLQueryItem]? {
      switch self {
      case .listShows(let page):
         [
            .init(name: "page", value: String(page))
         ]
         
      case .searchShows(let query):
         [
            .init(name: "q", value: query)
         ]
         
      case .getDetailedShow: nil
      }
   }
}
