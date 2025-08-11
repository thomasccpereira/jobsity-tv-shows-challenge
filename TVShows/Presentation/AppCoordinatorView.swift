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
            .navigationDestination(for: AppCoordinator.Paths.self) { [paths = coordinator.paths] destination in
               let nextDestination = paths.last ?? destination
               
               switch nextDestination {
               case .showDetails(let show):
                  let viewModel = ShowDetailViewModel(coordinator: coordinator, store: coordinator.store, show: show)
                  ShowDetailView(viewModel: viewModel)
                  
               case .episodeDetails(let episode):
                  let viewModel = EpisodeDetailViewModel(coordinator: coordinator, episode: episode)
                  EpisodeDetailView(viewModel: viewModel)
                  
               case .showFavorites:
                  let viewModel = FavoritesListViewModel(coordinator: coordinator, store: coordinator.store)
                  FavoritesListView(viewModel: viewModel)
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
