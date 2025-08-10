import Testing
import Foundation
@testable import TVShows

@Suite
struct ShowsRepositoryImplTests {
   // Helper to decode ShowsListDTO from raw JSON
   private func decodeShowsListDTO(from json: String) throws -> ShowsListDTO {
      let data = Data(json.utf8)
      return try JSONDecoder().decode(ShowsListDTO.self, from: data)
   }
   
   // Helper empty DTOs for other endpoints (to satisfy the stub)
   private func emptyQueriedShowsDTO() throws -> QueriedShowsDTO {
      // QueriedShowsDTO expects the root to be a JSON array of { score, show }
      let data = Data("[]".utf8)
      return try JSONDecoder().decode(QueriedShowsDTO.self, from: data)
   }
   
   private func emptyEpisodesListDTO() throws -> EpisodesListDTO {
      // EpisodesListDTO expects the root to be a JSON array of episodes
      let data = Data("[]".utf8)
      return try JSONDecoder().decode(EpisodesListDTO.self, from: data)
   }
   
   // Stub that returns pre-built DTOs
   private struct StubRemote: ShowsRemoteDataSource {
      let showsDTO: ShowsListDTO
      let searchDTO: QueriedShowsDTO
      let episodesDTO: EpisodesListDTO
      
      func shows(page: Int) async throws -> ShowsListDTO { showsDTO }
      func searchShow(query: String) async throws -> QueriedShowsDTO { searchDTO }
      func episodes(showID: Int) async throws -> EpisodesListDTO { episodesDTO }
   }
   
   @Test func mapsDTOToEnvelopeSuccess() async throws {
      // Root is an array => success path in ShowsListDTO.init(from:)
      let showArrayJSON = "[{\n  \"id\": 1, \"image\": null, \"name\": \"A\", \"schedule\": { \"time\": \"07:00\", \"days\": [\"Monday\"] }, \"genres\": [\"Comedy\"], \"runtime\": 30, \"summary\": \"Sample\" }]"
      
      let showsDTO = try decodeShowsListDTO(from: showArrayJSON)
      let repo = ShowsRepositoryImpl(
         remote: StubRemote(
            showsDTO: showsDTO,
            searchDTO: try emptyQueriedShowsDTO(),
            episodesDTO: try emptyEpisodesListDTO()
         )
      )
      
      let env = try await repo.fetchShows(page: 0)
      #expect(env.errorMessage == nil)
      #expect(env.model?.items.count == 1)
      #expect(env.model?.items.first?.name == "A")
   }
   
   @Test func mapsDTOErrorToEnvelopeErrorMessage() async throws {
      // Root is an object => error path in ShowsListDTO.init(from:)
      let errorJSON = "{\n  \"name\": \"Not Found\", \n  \"message\": \"Page not found.\", \n  \"code\": 0, \n  \"status\": 404, \n  \"previous\": null\n}"
      
      let showsDTO = try decodeShowsListDTO(from: errorJSON)
      let repo = ShowsRepositoryImpl(
         remote: StubRemote(
            showsDTO: showsDTO,
            searchDTO: try emptyQueriedShowsDTO(),
            episodesDTO: try emptyEpisodesListDTO()
         )
      )
      
      let env = try await repo.fetchShows(page: 0)
      #expect(env.model == nil)
      #expect(env.errorMessage == "Page not found.")
   }
}
