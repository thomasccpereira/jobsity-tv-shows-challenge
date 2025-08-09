import Foundation

extension String {
   var isValidURL: Bool {
      let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
      if let match = detector?.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
         return match.range.length == self.utf16.count
      }
      return false
   }
   
   var strippingHTML: String {
      guard let data = data(using: .utf8) else { return self }
      
      let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
         .documentType: NSAttributedString.DocumentType.html,
         .characterEncoding: String.Encoding.utf8.rawValue
      ]
      
      return (try? NSAttributedString(data: data, options: options, documentAttributes: nil).string) ?? self
   }
}
