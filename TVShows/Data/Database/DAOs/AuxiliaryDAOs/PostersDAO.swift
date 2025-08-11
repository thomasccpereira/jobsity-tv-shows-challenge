import SwiftData
import Foundation

@Model
final class PostersDAO {
   var medium: String?
   var original: String?
   
   init(medium: String?, original: String?) {
      self.medium = medium
      self.original = original
   }
}
