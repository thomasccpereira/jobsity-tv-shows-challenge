import SwiftUI

struct ShowsListView: View {
   static let scrollToTopViewID = "scrollToTop_showsList"
   @State var viewModel: ShowsListViewModel
   @State private var firstLoad = true
   @State private var isSearchPresented = false
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
         
         fullScreenLoadingView
      }
      .searchable(text: $viewModel.searchText,
                  isPresented: $isSearchPresented,
                  placement: .navigationBarDrawer(displayMode: .always),
                  prompt: "Search you TV show")
      .onChange(of: isSearchPresented) { old, new in
         if old == true && new == false {
            viewModel.cancelSearch()
         }
      }
      .navigationTitle("TV Shows")
      .onAppear {
         if firstLoad {
            firstLoad = false
            Task { try await viewModel.loadShowsIfNeeded() }
         }
      }
      .disabled(viewModel.isLoading)
   }
   
   @ViewBuilder
   private var listContentView: some View {
      if viewModel.shows.isEmpty, !viewModel.isPerformingQuery {
         loadStateView(stateImageNamed: emptyListSystemImageNamed,
                       stateTitle: "That's not time for \"show\".",
                       foregroundStyle: .elevatedSurface)
         
      } else {
         listView
      }
   }
   
   @ViewBuilder
   private var listView: some View {
      ScrollViewReader { scrollReader in
         List {
            Section {
               ForEach(viewModel.shows, id: \.id) { singleShow in
                  Button {
                     viewModel.navigateToShowDetail(for: singleShow)
                  } label: {
                     singleShowView(singleShow)
                  }
                  .disabled(viewModel.isLoading)
               }
            } footer: {
               paginationStateView
            }
            .listRowSeparator(.hidden)
            .id(ShowsListView.scrollToTopViewID)
         }
         .listStyle(.plain)
         .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
         .scrollDisabled(viewModel.isLoading)
         .onChange(of: viewModel.isQueryActive) {
            scrollReader.scrollTo(ShowsListView.scrollToTopViewID, anchor: .topLeading)
         }
      }
   }
   
   @ViewBuilder
   private func singleShowView(_ singleShow: SingleShowModel) -> some View {
      ShowsListSingleItemView(singleShow: singleShow)
         .shimmer(active: viewModel.isLoading)
         .onAppear {
            Task {
               try await viewModel.loadShowsIfNeeded(after: singleShow)
            }
         }
   }
   
   @ViewBuilder
   private var paginationStateView: some View {
      ZStack(alignment: .center) {
         switch viewModel.paginationState {
         case .idle:
            EmptyView()
            
         case .isPaginating:
            circularProgressView
            
         case .didFail(_, let errorMessage):
            paginationErrorView(errorMessage: errorMessage)
            
         case .endOfList:
            Text("All TV shows loaded!")
               .font(.thin11)
               .foregroundStyle(.textSecondary)
         }
      }
      .padding(.all, 8)
      .frame(maxWidth: .infinity, alignment: .center)
   }
   
   @ViewBuilder
   private var circularProgressView: some View {
      ProgressView()
         .progressViewStyle(.circular)
         .controlSize(.mini)
         .tint(.primaryRoyalPurple)
   }
   
   @ViewBuilder
   private var fullScreenLoadingView: some View {
      if viewModel.isPerformingQuery {
         ZStack {
            Color.black
               .opacity(0.3)
            
            ProgressView()
         }
         .edgesIgnoringSafeArea(.all)
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
         
         if let retryButtonTitle {
            retryButton(with: retryButtonTitle)
               .font(.medium18)
               .padding(.top, 24)
         }
         
         Spacer()
      }
      .foregroundStyle(foregroundStyle)
      .padding(.all, 32)
   }
   
   @ViewBuilder
   private func paginationErrorView(errorMessage: String) -> some View {
      retryButton(with : errorMessage)
         .font(.regular11)
         .padding(.all, 12)
   }
   
   @ViewBuilder
   private func retryButton(with buttonTitle: String) -> some View {
      Button {
         Task { try await viewModel.retryLoad() }
         
      } label: {
         HStack(alignment: .center, spacing: 8) {
            Image(systemName: "arrow.clockwise")
               .resizable()
               .aspectRatio(contentMode: .fit)
               .frame(width: 24)
            
            Text(buttonTitle)
         }
         .foregroundStyle(.softTeal)
      }
   }
}

#Preview {
   ShowsListView(viewModel: .preview)
}
