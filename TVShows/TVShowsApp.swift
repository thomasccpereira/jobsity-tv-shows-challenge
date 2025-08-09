import SwiftUI

@main
struct TVShowsApp: App {
   @StateObject var coordinator = AppCoordinator()
   
   var body: some Scene {
      WindowGroup {
         AppCoordinatorView(coordinator: coordinator)
      }
   }
}
