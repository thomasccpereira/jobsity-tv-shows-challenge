extension AppCoordinator {
   enum Paths: CoordinatablePathDefinition {
      case showDetails(show: SingleShowModel)
      case episodeDetails(episode: SingleEpisodeModel)
   }
}
