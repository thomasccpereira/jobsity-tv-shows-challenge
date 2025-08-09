extension AppCoordinator {
   enum Paths: CoordinatablePathDefinition {
      case showDetails(showID: Int)
      case episodeDetails(showID: Int, season: Int, episode: Int)
   }
}
