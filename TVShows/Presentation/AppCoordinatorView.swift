import SwiftUI
import Foundation

struct AppCoordinatorView: View {
   @Environment(\.scenePhase) var scenePhase
   @StateObject var coordinator: AppCoordinator
   
   var body: some View {
      NavigationStack {
         coordinator.startView
            .animation(.easeInOut(duration: 0.5).delay(0.5), value: coordinator.didFinishLoad)
            .transition(.opacity)
            .onAppear {
               coordinator.start()
            }
      }
      .onChange(of: scenePhase) { _, scenePhase in
         coordinator.handleScenePhase(scenePhase)
      }
   }
}

// MARK: - Preview
#if DEBUG
#Preview {
   AppCoordinatorView(coordinator: .preview)
}
#endif
