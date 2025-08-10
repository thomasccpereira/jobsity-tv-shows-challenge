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
      AsyncImage(url: singleShow.image?.mediumURL) { img in
         img.resizable().scaledToFill()
         
      } placeholder: {
         Image("placeholder-poster-medium")
            .aspectRatio(contentMode: .fit)
      }
      .frame(width: 72, height: 96)
      .clipShape(RoundedRectangle(cornerRadius: 8))
   }
   
   @ViewBuilder
   private var nameView: some View {
      Text(singleShow.name)
         .font(.medium12)
         .foregroundStyle(.textPrimary)
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
