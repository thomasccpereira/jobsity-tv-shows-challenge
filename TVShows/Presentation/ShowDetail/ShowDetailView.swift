import SwiftUI

struct ShowDetailView: View {
   @State private var viewModel: ShowDetailViewModel
   @State private var firstLoad = true
   private var seasonsCardBackgroundColor: Color { viewModel.isLoading ? .customLightGray : .gold }
   private var episodesForegroundColor: Color { viewModel.isLoading ? .customLightGray : .primaryRoyalPurple }
   
   init(coordinator: AppCoordinator, store: DatabaseStore, show: SingleShowModel) {
      let viewModel = ShowDetailViewModel(coordinator: coordinator,
                                          store: store,
                                          show: show)
      _viewModel = State(initialValue: viewModel)
   }
   
   var body: some View {
      ScrollView {
         showMainInfoView
      }
      .navigationTitle("TV Show")
      .navigationBarTitleDisplayMode(.inline)
      .onAppear {
         if firstLoad {
            firstLoad = false
            Task { try await viewModel.loadEpisodes() }
         }
      }
   }
   
   @ViewBuilder
   private var showMainInfoView: some View {
      VStack(alignment: .center, spacing: 12) {
         showPosterAndFavoriteView
         
         showNameView
         
         showSummaryView
         
         showSchedulesView
         
         showGenresView
         
         seasonEpisodesView
            .shimmer(active: viewModel.isLoading)
         
         Spacer()
      }
      .padding(.all, 12)
   }
   
   @ViewBuilder
   private var showPosterAndFavoriteView: some View {
      ZStack {
         showPosterView
         
         Button {
            Task { try await viewModel.addOrRemoveShowFromFavorites() }
         } label: {
            favoriteButtonView
         }
         .disabled(viewModel.isLoading)
      }
   }
   
   @ViewBuilder
   private var showPosterView: some View {
      AsyncImage(url: viewModel.showPosterImageURL) { posterImage in
         posterImage
            .resizable()
            .scaledToFit()
         
      } placeholder: {
         Image("placeholder-poster-medium")
            .scaledToFill()
      }
      .frame(minHeight: 320, maxHeight: 320)
      .clipShape(RoundedRectangle(cornerRadius: 8))
   }
   
   @ViewBuilder
   private var favoriteButtonView: some View {
      VStack(alignment: .trailing) {
         HStack(alignment: .top) {
            Spacer()
            
            Image(systemName: viewModel.favoriteImageNamed)
               .resizable()
               .aspectRatio(contentMode: .fit)
               .frame(width: 32)
               .foregroundStyle(.softTeal)
         }
         
         Spacer()
      }
   }
   
   @ViewBuilder
   private var showNameView: some View {
      Text(viewModel.showTitle)
         .font(.bold13)
         .foregroundColor(.textPrimary)
         .multilineTextAlignment(.leading)
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
   
   @ViewBuilder
   private var seasonEpisodesView: some View {
      if !viewModel.seasons.isEmpty {
         VStack(spacing: 12) {
            Text("Episodes")
               .font(.bold14)
               .foregroundStyle(.primaryRoyalPurple)
               .padding(.top, 16)
               .padding(.bottom, 8)
               .frame(maxWidth: .infinity, alignment: .leading)
               .border(edges: [.bottom], color: episodesForegroundColor)
            
            seasonsListView
         }
         .disabled(viewModel.isLoading)
      }
   }
   
   @ViewBuilder
   private var seasonsListView: some View {
      VStack(spacing: 4) {
         ForEach(viewModel.seasons) { season in
            HStack(alignment: .firstTextBaseline) {
               Text(season.id.prettySeason)
                  .font(.medium12)
                  .foregroundStyle(.textPrimary)
                  .padding(.all, 8)
                  .background {
                     RoundedRectangle(cornerRadius: 8)
                        .fill(seasonsCardBackgroundColor)
                  }
                  .frame(minWidth: 44)
               
               seasonsEpisodesListView(season: season)
            }
         }
      }
   }
   
   @ViewBuilder
   private func seasonsEpisodesListView(season: ShowDetailViewModel.Seasons) -> some View {
      VStack {
         ForEach(season.episodes, id: \.number) { episode in
            Button {
               viewModel.navigateToEpisodeDetail(for: episode)
               
            } label: {
               singleSeasonEpisodeView(episode: episode)
            }
         }
      }
      .border(edges: [.leading])
   }
   
   @ViewBuilder
   private func singleSeasonEpisodeView(episode: SingleEpisodeModel) -> some View {
      HStack(alignment: .firstTextBaseline) {
         Text(episode.prettyNumber)
            .font(.medium11)
            .foregroundStyle(.primaryRoyalPurple)
         
         Text(episode.name)
            .font(.medium11)
            .foregroundStyle(.primaryRoyalPurple)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
      }
      .padding(.vertical, 8)
      .padding(.horizontal, 12)
   }
}

#Preview {
   ShowDetailView(coordinator: .preview,
                  store: .preview,
                  show: .previewShow1)
}
