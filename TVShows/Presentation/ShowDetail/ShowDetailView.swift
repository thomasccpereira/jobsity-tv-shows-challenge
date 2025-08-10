import SwiftUI

struct ShowDetailView: View {
   var viewModel: ShowDetailViewModel
   @State private var firstLoad = true
   
   var body: some View {
      showMainInfoView
         .navigationTitle("TV Show")
         .navigationBarTitleDisplayMode(.inline)
         .onAppear {
            if firstLoad {
               Task { try await viewModel.loadEpisodes() }
               firstLoad = false
            }
         }
   }
   
   @ViewBuilder
   private var showMainInfoView: some View {
      VStack(alignment: .center, spacing: 16) {
         showPosterView
         
         showNameView
         
         showSummaryView
         
         showSchedulesView
         
         showGenresView
      }
      .padding(.all, 16)
   }
   
   @ViewBuilder
   private var showPosterView: some View {
      AsyncImage(url: viewModel.showPosterImageURL) { posterImage in
         posterImage
            .resizable()
            .scaledToFit()
         
      } placeholder: {
         Image("placeholder-poster-medium")
            .scaledToFit()
      }
      .clipShape(RoundedRectangle(cornerRadius: 8))
   }
   
   @ViewBuilder
   private var showNameView: some View {
      Text(viewModel.showTitle)
         .font(.bold13)
         .foregroundColor(.textPrimary)
         .frame(maxWidth: .infinity, alignment: .leading)
   }
   
   @ViewBuilder
   private var showSummaryView: some View {
      Text(viewModel.showSummary)
         .font(.regular11)
         .foregroundStyle(.textPrimary)
         .frame(maxWidth: .infinity, alignment: .leading)
   }
   
   @ViewBuilder
   private var showSchedulesView: some View {
      if !viewModel.showSchedules.isEmpty {
         ScrollView(.horizontal) {
            HStack {
               ForEach(viewModel.showSchedules) { schedule in
                  VStack(alignment: .center) {
                     Text(schedule.time)
                        .font(.medium11)
                        .foregroundStyle(.primaryRoyalPurple)
                     
                     Text(schedule.day)
                        .font(.regular10)
                        .foregroundStyle(.primaryRoyalPurple)
                  }
                  .padding(.all, 8)
                  .background {
                     RoundedRectangle(cornerRadius: 8)
                        .fill(.gold)
                  }
               }
            }
         }
      }
   }
   
   @ViewBuilder
   private var showGenresView: some View {
      Text(viewModel.showGenres)
         .font(.regular11)
         .foregroundStyle(.textPrimary)
         .frame(maxWidth: .infinity, alignment: .leading)
   }
   
   /*
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
   } */
}

#Preview {
   ShowDetailView(viewModel: ShowDetailViewModel(coordinator: .preview, show: .previewShow1))
}
