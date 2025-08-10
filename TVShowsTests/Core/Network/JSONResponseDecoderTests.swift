import Testing
@testable import TVShows

@Suite
struct JSONResponseDecoderTests {
   struct Model: Codable, Equatable {
      let id: Int
      let name: String
   }
   
   @Test func decodesValidJSON() throws {
      let json = #"{"id":1,"name":"Test"}"#.data(using: .utf8)!
      let decoder = JSONResponseDecoder()
      let model = try decoder.decode(Model.self, from: json)
      #expect(model == .init(id: 1, name: "Test"))
   }
   
   @Test func mapsKeyNotFoundToNetworkError() {
      let json = #"{"id":1}"#.data(using: .utf8)!
      let decoder = JSONResponseDecoder()
      #expect(throws: NetworkError.self) { _ = try decoder.decode(Model.self, from: json) }
   }
}
