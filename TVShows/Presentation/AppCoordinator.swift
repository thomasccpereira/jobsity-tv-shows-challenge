import SwiftUI
import Foundation

@Observable
final class AppCoordinator: Coordinatable {
   // Properties
   private let store: DatabaseStore
   
   @ObservationIgnored
   lazy var showsListViewModel: ShowsListViewModel = ShowsListViewModel(coordinator: self,
                                                                        store: store)
   
   // Navigation
   var paths: [Paths] = []
   
   // State
   private(set) var didFinishLoad: Bool = false
   private var launchViewOpacity: Double { didFinishLoad ? 0.0 : 1.0 }
   
   // Init
   init(viewModel: ShowsListViewModel? = nil) {
      do {
         self.store = try DatabaseStore(models: [ SingleShowDAO.self, SingleEpisodeDAO.self ],
                                        config: .init(inMemory: false))
         
         if let viewModel {
            self.showsListViewModel = viewModel
         }
      } catch {
         fatalError("Couldn't initialize the store: \(error.localizedDescription)")
      }
   }
}

// MARK: - Start
extension AppCoordinator {
   func start() {
      if didFinishLoad { return }
      
      didFinishLoad = true
   }
   
   @ViewBuilder
   var startView: some View {
      if didFinishLoad {
         mainView
         
      } else {
         launchView
      }
   }
   
   @ViewBuilder
   private var mainView: some View {
      ShowsListView(viewModel: showsListViewModel)
   }
   
   @ViewBuilder
   private var launchView: some View {
      VStack(alignment: .center) {
         Spacer()
         
         Image("launch-logo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 136, alignment: .center)
         
         Spacer()
      }
      .frame(maxWidth: .infinity)
      .background(Color.defaultBackground)
      .opacity(launchViewOpacity)
   }
}

// MARK: - Navigation
extension AppCoordinator {
   func goToPath(_ path: Paths) {
      paths.append(path)
   }
}

// MARK: - Scene phases
extension AppCoordinator {
   func handleScenePhase(_ scenePhase: ScenePhase) {
      switch scenePhase {
      case .background:
         break
         
      case .active, .inactive:
         break
         
      @unknown default:
         break
      }
   }
}
