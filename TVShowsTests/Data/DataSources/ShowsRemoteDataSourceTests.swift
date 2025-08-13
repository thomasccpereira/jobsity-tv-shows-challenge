import Testing
import Foundation
@testable import TVShows

@Suite
struct ShowsRemoteDataSourceTests {
   // MARK: - Helpers (DTO decoding from JSON strings)
   private func decodeShowsListDTO(_ json: String) throws -> ShowsListDTO {
      try JSONDecoder().decode(ShowsListDTO.self, from: Data(json.utf8))
   }
   private func decodeEpisodesListDTO(_ json: String) throws -> EpisodesListDTO {
      try JSONDecoder().decode(EpisodesListDTO.self, from: Data(json.utf8))
   }
   private func decodeQueriedShowsDTO(_ json: String) throws -> QueriedShowsDTO {
      try JSONDecoder().decode(QueriedShowsDTO.self, from: Data(json.utf8))
   }
   
   // MARK: - Local stub for NetworkFactoryType (kept local to avoid cross-file coupling)
   private struct LocalStubNetworkFactory: NetworkFactoring {
      let handler: (NetworkRequestConfig) throws -> any Decodable
      func fetch<Model>(requestConfig: NetworkRequestConfig, cacheTTL: Duration) async throws -> Model where Model : Decodable {
         return try handler(requestConfig) as! Model
      }
   }
   
   @Test func requestsListShowsWithPage_andDecodesDTOFromJSON() async throws {
      // ShowsListDTO succeeds when the root is a JSON array
      let showsJSON = #"""
        [
          {
            "id": 1,
            "image": null,
            "name": "A",
            "schedule": { "time": "07:00", "days": ["Monday"] },
            "genres": [],
            "runtime": 30,
            "summary": "Sample"
          }
        ]
        """#
      let showsDTO = try decodeShowsListDTO(showsJSON)
      
      let dataSource = ShowsRemoteDataSourceImpl(networkFactory: LocalStubNetworkFactory(handler: { config in
         // Verify endpoint and query
         #expect((config as! ShowRequestConfigs).path == "/shows")
         let items = (config as! ShowRequestConfigs).queryItems
         let pageValue = items?.first(where: { $0.name == "page" })?.value
         #expect(pageValue == "2")
         return showsDTO
      }))
      
      let result = try await dataSource.shows(page: 2)
      #expect(result.shows.count == 1)
      #expect(result.error == nil)
   }
   
   @Test func requestsEpisodesForShow_andDecodesDTOFromJSON() async throws {
      // EpisodesListDTO succeeds when the root is a JSON array
      let episodesJSON = #"""
        [
          {
            "id": 101,
            "season": 1,
            "number": 1,
            "image": null,
            "name": "Pilot",
            "summary": "Ep 1",
            "runtime": 42
          }
        ]
        """#
      let episodesDTO = try decodeEpisodesListDTO(episodesJSON)
      
      let showID = 10
      let dataSource = ShowsRemoteDataSourceImpl(networkFactory: LocalStubNetworkFactory(handler: { config in
         #expect((config as! ShowRequestConfigs).path == "/shows/\(showID)/episodes")
         return episodesDTO
      }))
      
      let result = try await dataSource.episodes(showID: showID)
      #expect(result.episodes.count == 1)
      #expect(result.error == nil)
   }
   
   @Test func requestsSearchShows_andDecodesDTOFromJSON() async throws {
      // QueriedShowsDTO succeeds when the root is a JSON array of { score, show }
      let searchJSON = #"""
        [
          {
            "score": 12.34,
            "show": {
              "id": 99,
              "image": null,
              "name": "QueryHit",
              "schedule": { "time": "07:00", "days": ["Tuesday"] },
              "genres": ["Drama"],
              "runtime": 60,
              "summary": "Found"
            }
          }
        ]
        """#
      let queriedDTO = try decodeQueriedShowsDTO(searchJSON)
      
      let query = "query"
      let dataSource = ShowsRemoteDataSourceImpl(networkFactory: LocalStubNetworkFactory(handler: { config in
         #expect((config as! ShowRequestConfigs).path == "/search/shows")
         let items = (config as! ShowRequestConfigs).queryItems
         let qValue = items?.first(where: { $0.name == "q" })?.value
         #expect(qValue == query)
         return queriedDTO
      }))
      
      let result = try await dataSource.searchShow(query: query)
      #expect(result.queriedShows.count == 1)
      #expect(result.error == nil)
   }
}
