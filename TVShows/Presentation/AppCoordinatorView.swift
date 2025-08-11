import SwiftUI
import Foundation

struct AppCoordinatorView: View {
   @Environment(\.scenePhase) var scenePhase
   @StateObject var coordinator: AppCoordinator
   
   var body: some View {
      NavigationStack(path: $coordinator.paths) {
         coordinator.startView
            .animation(.easeInOut(duration: 0.5).delay(0.5), value: coordinator.didFinishLoad)
            .transition(.opacity)
            .onAppear {
               coordinator.start()
            }
            .navigationDestination(for: AppCoordinator.Paths.self) { destination in
               switch destination {
               case .showDetails(let show):
                  ShowDetailView(coordinator: coordinator, store: coordinator.store, show: show)
                  
               case .episodeDetails(let episode):
                  EpisodeDetailView(coordinator: coordinator, episode: episode)
                  
               case .showFavorites:
                  FavoritesListView(coordinator: coordinator, store: coordinator.store)
               }
            }
      }
      .onChange(of: scenePhase) { _, scenePhase in
         coordinator.handleScenePhase(scenePhase)
      }
   }
}

// MARK: - Preview
#Preview {
   AppCoordinatorView(coordinator: AppCoordinator(viewModel: .preview))
}
