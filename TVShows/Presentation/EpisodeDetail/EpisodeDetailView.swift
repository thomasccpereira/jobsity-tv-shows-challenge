import SwiftUI

struct EpisodeDetailView: View {
   @State private var viewModel: EpisodeDetailViewModel
   
   init(coordinator: AppCoordinator, episode: SingleEpisodeModel) {
      let viewModel = EpisodeDetailViewModel(coordinator: coordinator,
                                             episode: episode)
      _viewModel = State(initialValue: viewModel)
   }
   
   var body: some View {
      ScrollView {
         episodeMainView
      }
      .navigationTitle("Episode")
      .navigationBarTitleDisplayMode(.inline)
   }
   
   @ViewBuilder
   private var episodeMainView: some View {
      VStack(alignment: .center, spacing: 24) {
         episodePosterView
         
         episodeName
         
         seasonAndEpisodeView
         
         episodeSummary
         
         Spacer()
      }
      .padding(.all, 24)
   }
   
   @ViewBuilder
   private var episodePosterView: some View {
      AsyncImage(url: viewModel.episodePosterImageURL) { posterImage in
         posterImage
            .resizable()
            .scaledToFit()
         
      } placeholder: {
         Image("placeholder-poster-medium")
            .scaledToFit()
      }
      .frame(maxWidth: .infinity)
      .clipShape(RoundedRectangle(cornerRadius: 8))
   }
   
   @ViewBuilder
   private var episodeName: some View {
      Text(viewModel.episodeTitle)
         .font(.bold16)
         .foregroundColor(.textPrimary)
         .multilineTextAlignment(.leading)
         .frame(maxWidth: .infinity, alignment: .leading)
   }
   
   @ViewBuilder
   private var seasonAndEpisodeView: some View {
      HStack(alignment: .firstTextBaseline) {
         Text(viewModel.episodeSeason)
            .font(.medium14)
            .foregroundStyle(.textPrimary)
            .padding(.all, 8)
            .background {
               RoundedRectangle(cornerRadius: 8)
                  .fill(.gold)
            }
         
         Text(viewModel.episodeNumber)
            .font(.medium13)
            .foregroundStyle(.primaryRoyalPurple)
            .frame(maxWidth: .infinity, alignment: .leading)
      }
   }
   
   @ViewBuilder
   private var episodeSummary: some View {
      Text(viewModel.episodeSummary)
         .font(.regular13)
         .foregroundStyle(.textPrimary)
         .frame(maxWidth: .infinity, alignment: .leading)
   }
}

#Preview {
   EpisodeDetailView(coordinator: .preview,
                     episode: .previewEpisode1)
}
