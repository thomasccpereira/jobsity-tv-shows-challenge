import Testing
import Foundation
@testable import TVShows

@Suite
struct StatusCodeValidatorTests {
   @Test func accepts2xx() throws {
      let validator = StatusCodeValidator()
      let url = URL(string:"https://example.com")!
      let response = HTTPURLResponse(url: url, statusCode: 204, httpVersion: nil, headerFields: nil)!
      try validator.validate(response, data: Data())
   }
   
   @Test func maps4xxToClientFailure() {
      let validator = StatusCodeValidator()
      let url = URL(string:"https://example.com/a")!
      let response = HTTPURLResponse(url: url, statusCode: 404, httpVersion: nil, headerFields: nil)!
      #expect(throws: NetworkError.networkClientFailure(code: 404, url: url.absoluteString)) {
         try validator.validate(response, data: Data())
      }
   }
   
   @Test func maps5xxToServerFailure() {
      let validator = StatusCodeValidator()
      let url = URL(string:"https://example.com/b")!
      let response = HTTPURLResponse(url: url, statusCode: 500, httpVersion: nil, headerFields: nil)!
      #expect(throws: NetworkError.networkServerFailure(code: 500, url: url.absoluteString)) {
         try validator.validate(response, data: Data())
      }
   }
}
