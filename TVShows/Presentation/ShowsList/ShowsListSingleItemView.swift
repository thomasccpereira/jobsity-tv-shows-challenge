import SwiftUI

struct ShowsListSingleItemView: View {
   let singleShow: SingleShowModel
   
   var body: some View {
      HStack(alignment: .top, spacing: 12) {
         posterImage
         
         VStack(alignment: .leading, spacing: 4) {
            nameView
            
            summaryView
         }
      }
      .padding(.bottom, 12)
      .border(edges: [.bottom])
   }
   
   @ViewBuilder
   private var posterImage: some View {
      AsyncImage(url: singleShow.image?.mediumURL) { posterImage in
         posterImage
            .resizable()
            .scaledToFit()
         
      } placeholder: {
         Image("placeholder-poster-medium")
            .scaledToFit()
      }
      .frame(width: 72, height: 96)
      .clipShape(RoundedRectangle(cornerRadius: 8))
   }
   
   @ViewBuilder
   private var nameView: some View {
      Text(singleShow.name)
         .font(.medium14)
         .foregroundStyle(.textPrimary)
         .multilineTextAlignment(.leading)
   }
   
   @ViewBuilder
   private var summaryView: some View {
      if let summary = singleShow.summary, !summary.isEmpty {
         Text(summary)
            .font(.regular11)
            .foregroundStyle(.textSecondary)
      }
   }
}
