import Foundation

// MARK: - Network dependencies
struct NetworkDependencies: Sendable {
   let sessionManager: any NetworkSessionManaging
   let requestBuilder: any NetworkRequestBuilding
   let cacher: any NetworkResponseCaching
   let logger: any NetworkLogging
   let errorMapper: any NetworkErrorMapping
   let validator: any NetworkResponseValidating
   let decoder: any NetworkResponseDecoding
}

// MARK: - Network dependencies - Default dependencies
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
