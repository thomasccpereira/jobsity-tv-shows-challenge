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
   
   var abbreviated: String {
      self.prefix(3).capitalized
   }
   
   var trimmed: String {
      self.trimmingCharacters(in: .whitespacesAndNewlines).condensed.replacingOccurrences(of: "\t", with: "")
   }
   
   var cleaned: String {
      self.trimmed.lowercased()
   }
   
   var escaped: String {
      self.trimmed.replacingOccurrences(of: "'", with: "\'")
   }
   
   var validLines: String {
      self.components(separatedBy: .newlines).filter { !$0.trimmed.isEmpty }.joined(separator: "\n")
   }
   
   // Returns a condensed string, with no extra whitespaces and no new lines.
   var condensed: String {
      replacingOccurrences(of: "[\\s\n]+", with: " ", options: .regularExpression, range: nil)
   }
   
   // Returns a condensed string, with no whitespaces at all and no new lines.
   var extraCondensed: String {
      replacingOccurrences(of: "[\\s\n]+", with: "", options: .regularExpression, range: nil)
   }
   
   var nilWhenEmpty: String? {
      self.trimmed.isEmpty ? nil : self.trimmed
   }
}
