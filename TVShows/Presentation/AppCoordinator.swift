import SwiftUI
import Foundation

final class AppCoordinator: Coordinatable {
   // Properties
   // Navigation
   var paths: [Paths] = []
   
   // State
   private(set) var didFinishLoad: Bool = false
   private var launchViewOpacity: Double { didFinishLoad ? 0.0 : 1.0 }
   
   // Init
   init() {
      
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
      Image(systemName: "exclamationmark.warninglight.fill")
         .resizable()
         .aspectRatio(contentMode: .fit)
         .frame(width: 136, alignment: .center)
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
      .opacity(launchViewOpacity)
   }
}

// MARK: - Navigation
extension AppCoordinator {
   func goToPath(_ path: Paths) {
      switch path {
      case .newEvent:
         break
         
      case .editEvent(let eventID):
         break
         
      case .settings:
         break
      }
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
