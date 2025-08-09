extension AppCoordinator {
   enum Paths: CoordinatablePathDefinition {
      // MARK: - CaseIterable
      static var allCases: [AppCoordinator.Paths] {
         [
            .newEvent,
            .editEvent(),
            .settings
         ]
      }
      
      // MARK: - Destination
      case newEvent
      case editEvent(eventID: String = "")
      case settings
   }
}
