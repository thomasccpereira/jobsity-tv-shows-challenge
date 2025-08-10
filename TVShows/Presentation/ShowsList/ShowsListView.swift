import SwiftUI

struct ShowsListView: View {
   static let scrollToTopViewID = "scrollToTop_showsList"
   @State var viewModel: ShowsListViewModel
   @State private var firstLoad = true
   @State private var isSearchPresented = false
   
   var body: some View {
      ZStack {
         if let errorMessage = viewModel.errorMessage {
            loadErrorView(errorMessage: errorMessage)
            
         } else {
            listView
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
   private func loadErrorView(errorMessage: String) -> some View {
      VStack(alignment: .center, spacing: 12) {
         Spacer()
         
         Image(systemName: "xmark.octagon")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 64)
         
         Text(errorMessage)
            .font(.medium12)
         
         retryButton(with: "Retry")
            .font(.medium16)
            .padding(.top, 24)
         
         Spacer()
      }
      .foregroundStyle(.accentRed)
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
