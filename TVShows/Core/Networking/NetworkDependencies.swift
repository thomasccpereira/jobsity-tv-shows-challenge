import Foundation

struct NetworkDependencies: Sendable {
   let sessionManager: any NetworkSessionManager
   let requestBuilder: any NetworkRequestBuilding
   let cacher: any NetworkResponseCaching
   let logger: any NetworkLogging
   let errorMapper: any NetworkErrorMapping
   let validator: any NetworkResponseValidator
   let decoder: any NetworkResponseDecoding
}

extension NetworkDependencies {
   static var `default`: Self {
      .init(sessionManager: DefaultSessionManager(),
            requestBuilder: DefaultRequestBuilder(),
            cacher: DefaultNetworkResponseCache(),
            logger: DefaultNetworkLogger(),
            errorMapper: DefaultErrorMapper(),
            validator: StatusCodeValidator(),
            decoder: JSONResponseDecoder())
   }
}
