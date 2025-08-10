import Testing
import Foundation
@testable import TVShows

@Suite
struct DefaultErrorMapperTests {
   @Test func mapsCancellationError() {
      let mapper = DefaultErrorMapper()
      let mapped = mapper.map(CancellationError(), url: nil)
      #expect(mapped == .cancelled)
   }
   
   @Test func mapsURLErrorNotConnected() {
      let mapper = DefaultErrorMapper()
      let mapped = mapper.map(URLError(.notConnectedToInternet), url: nil)
      #expect(mapped == .noInternetConnection)
   }
}
