#if DEBUG
extension SingleEpisodeModel {
   static var previewEpisode1: Self {
      .init(id: 4952,
            season: 1,
            number: 1,
            image: .init(medium: "https://static.tvmaze.com/uploads/images/medium_landscape/1/4388.jpg",
                         original: "https://static.tvmaze.com/uploads/images/original_untouched/1/4388.jpg"),
            name: "Pilot",
            runtime: 60)
   }
   
   static var previewEpisode2: Self {
      .init(id: 4953,
            season: 1,
            number: 2,
            image: .init(medium: "https://static.tvmaze.com/uploads/images/medium_landscape/1/4389.jpg",
                         original: "https://static.tvmaze.com/uploads/images/original_untouched/1/4389.jpg"),
            name: "The Fire",
            runtime: 60)
   }
   
   static var previewEpisode3: Self {
      .init(id: 4954,
            season: 1,
            number: 3,
            image: .init(medium: "https://static.tvmaze.com/uploads/images/medium_landscape/1/4390.jpg",
                         original: "https://static.tvmaze.com/uploads/images/original_untouched/1/4390.jpg"),
            name: "Manhunt",
            runtime: 60)
   }
   
   static var previewEpisode4: Self {
      .init(id: 4955,
            season: 1,
            number: 4,
            image: .init(medium: "https://static.tvmaze.com/uploads/images/medium_landscape/1/4391.jpg",
                         original: "https://static.tvmaze.com/uploads/images/original_untouched/1/4391.jpg"),
            name: "Outbreak",
            runtime: 60)
   }
   
   static var previewEpisode5: Self {
      .init(id: 4956,
            season: 1,
            number: 5,
            image: .init(medium: "https://static.tvmaze.com/uploads/images/medium_landscape/1/4392.jpg",
                         original: "https://static.tvmaze.com/uploads/images/original_untouched/1/4392.jpg"),
            name: "The Age of Reason",
            runtime: 60)
   }
   
   static var previewEpisode6: Self {
      .init(id: 4957,
            season: 1,
            number: 6,
            image: .init(medium: "https://static.tvmaze.com/uploads/images/medium_landscape/1/4393.jpg",
                         original: "https://static.tvmaze.com/uploads/images/original_untouched/1/4393.jpg"),
            name: "Get Behind the Mule",
            runtime: 60)
   }
   
   static var previewEpisode7: Self {
      .init(id: 4958,
            season: 1,
            number: 7,
            image: .init(medium: "https://static.tvmaze.com/uploads/images/medium_landscape/1/4394.jpg",
                         original: "https://static.tvmaze.com/uploads/images/original_untouched/1/4394.jpg"),
            name: "Blue Gold",
            runtime: 60)
   }
   
   static var previewEpisode8: Self {
      .init(id: 4959,
            season: 1,
            number: 8,
            image: .init(medium: "https://static.tvmaze.com/uploads/images/medium_landscape/1/4395.jpg",
                         original: "https://static.tvmaze.com/uploads/images/original_untouched/1/4395.jpg"),
            name: "Two Ships",
            runtime: 60)
   }
   
   static var previewEpisode9: Self {
      .init(id: 4960,
            season: 1,
            number: 9,
            image: .init(medium: "https://static.tvmaze.com/uploads/images/medium_landscape/1/4396.jpg",
                         original: "https://static.tvmaze.com/uploads/images/original_untouched/1/4396.jpg"),
            name: "Achilles",
            runtime: 60)
   }
   
   static var previewEpisode10: Self {
      .init(id: 4961,
            season: 1,
            number: 10,
            image: .init(medium: "https://static.tvmaze.com/uploads/images/medium_landscape/1/4397.jpg",
                         original: "https://static.tvmaze.com/uploads/images/original_untouched/1/4397.jpg"),
            name: "No Place Like Home",
            runtime: 60)
   }
   
}

extension Collection where Element == SingleEpisodeModel {
   static var showEpisodesPreview: [SingleEpisodeModel] {
      [
         .previewEpisode1,
         .previewEpisode2,
         .previewEpisode3,
         .previewEpisode4,
         .previewEpisode5,
         .previewEpisode6,
         .previewEpisode7,
         .previewEpisode8,
         .previewEpisode9,
         .previewEpisode10
      ]
   }
}
#endif
