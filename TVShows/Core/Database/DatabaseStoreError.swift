import Foundation

enum DatabaseStoreError: Error, LocalizedError {
   case containerCreationFailed(underlying: Error)
   
   var errorDescription: String? {
      switch self {
      case .containerCreationFailed(let underlying):
         return "Failed to create ModelContainer: \(underlying.localizedDescription)"
      }
   }
}
