import SwiftUI

struct ShowsListView: View {
   var viewModel: ShowsListViewModel
   @State private var firstLoad = true
   
   var body: some View {
      listView
         .navigationTitle("TV Shows")
         .onAppear {
            if firstLoad {
               Task { try await viewModel.loadShowsIfNeeded() }
               firstLoad = false
            }
         }
         // .alert("Error", isPresented: .constant(vm.error != nil), actions: {
         //    Button("OK") { vm.error = nil }
         // }, message: { Text(vm.error ?? "") })
   }
   
   @ViewBuilder
   private var listView: some View {
      List {
         Section {
            ForEach(viewModel.shows, id: \.id) { singleShow in
               ShowsListSingleItemView(singleShow: singleShow)
                  .shimmer(active: viewModel.isLoading)
                  .onAppear {
                     Task {
                        try await viewModel.loadShowsIfNeeded(after: singleShow)
                     }
                  }
            }
         } footer: {
            paginationStateView
         }
         .listRowSeparator(.hidden)
      }
      .listStyle(.plain)
      .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
      .scrollDisabled(viewModel.isLoading)
   }
   
   @ViewBuilder
   var paginationStateView: some View {
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
   private func paginationErrorView(errorMessage: String) -> some View {
      Button {
         Task { try await viewModel.retryPagination() }
         
      } label: {
         HStack(alignment: .center, spacing: 8) {
            Image(systemName: "arrow.clockwise")
               .resizable()
               .frame(width: 40, height: 40)
               .aspectRatio(contentMode: .fit)
               .foregroundStyle(.softTeal)
            
            Text("Error when paginating...\nTap to try again.")
               .font(.regular11)
               .foregroundStyle(.softTeal)
         }
      }
      .padding(.all, 12)
   }
}

