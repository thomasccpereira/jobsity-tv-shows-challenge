extension AppCoordinator {
   enum Paths: CoordinatablePathDefinition {
      case episodeDetails(showID: Int, season: Int, episode: Int)
      case showDetails(show: SingleShowModel)
   }
}
