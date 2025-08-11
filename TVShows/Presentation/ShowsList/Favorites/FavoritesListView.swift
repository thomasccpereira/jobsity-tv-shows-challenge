import SwiftUI

struct FavoritesListView: View {
   static let scrollToTopViewID = "scrollToTop_favoritesList"
   @State var viewModel: FavoritesListViewModel
   private var emptyListSystemImageNamed: String { "movieclapper" }
   private var errorSystemImageNamed: String { "xmark.octagon" }
   
   var body: some View {
      ZStack {
         if let errorMessage = viewModel.errorMessage {
            loadStateView(stateImageNamed: errorSystemImageNamed,
                          stateTitle: errorMessage,
                          retryButtonTitle: "RETRY",
                          foregroundStyle: .accentRed)
            
         } else {
            listContentView
         }
      }
      .navigationTitle("Favorites TV Shows")
      .navigationBarTitleDisplayMode(.inline)
      .onAppear {
         Task { try await viewModel.loadFavorites() }
      }
   }
   
   @ViewBuilder
   private var listContentView: some View {
      if viewModel.favorites.isEmpty {
         loadStateView(stateImageNamed: emptyListSystemImageNamed,
                       stateTitle: "Explore the TV shows and save your loved ones!",
                       foregroundStyle: .elevatedSurface)
         
      } else {
         listView
      }
   }
   
   @ViewBuilder
   private var listView: some View {
      ScrollViewReader { scrollReader in
         List {
            ForEach(viewModel.favorites, id: \.id) { singleShow in
               singleShowView(singleShow)
            }
            .listRowSeparator(.hidden)
            .id(ShowsListView.scrollToTopViewID)
         }
         .listStyle(.plain)
         .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
         .onChange(of: viewModel.favorites) {
            scrollReader.scrollTo(ShowsListView.scrollToTopViewID, anchor: .topLeading)
         }
      }
   }
   
   @ViewBuilder
   private func singleShowView(_ singleShow: SingleShowModel) -> some View {
      HStack(alignment: .firstTextBaseline) {
         Button {
            viewModel.navigateToShowDetail(for: singleShow)
         } label: {
            ShowsListSingleItemView(singleShow: singleShow)
         }
         .buttonStyle(.plain)
         
         let isShowFavorite = viewModel.isShowFavorite(singleShow)
         Button {
            Task {
               if isShowFavorite {
                  try await viewModel.removeShowFromFavorites(show: singleShow)
               } else {
                  try await viewModel.addShowToFavorites(show: singleShow)
               }
            }
         } label: {
            let imageSystemName: String = isShowFavorite ? "heart.fill" : "heart"
            Image(systemName: imageSystemName)
               .resizable()
               .aspectRatio(contentMode: .fit)
               .frame(width: 32)
               .foregroundStyle(.softTeal)
         }

      }
   }
   
   @ViewBuilder
   private func loadStateView(stateImageNamed: String,
                              stateTitle: String,
                              retryButtonTitle: String? = nil,
                              foregroundStyle: Color) -> some View {
      VStack(alignment: .center, spacing: 12) {
         Image(systemName: stateImageNamed)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 64)
            .padding(.top, 64)
         
         Text(stateTitle)
            .font(.medium16)
         
         Spacer()
      }
      .foregroundStyle(foregroundStyle)
      .padding(.all, 32)
   }
}

#Preview {
   FavoritesListView(viewModel: .preview)
}
