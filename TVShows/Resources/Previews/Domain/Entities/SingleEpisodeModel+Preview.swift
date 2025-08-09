#if DEBUG
import Foundation

extension SingleEpisodeModel {
   static var previewEpisode1: Self {
      .init(id: 4952,
            season: 1,
            number: 1,
            image: .init(mediumURL: URL(string: "https://static.tvmaze.com/uploads/images/medium_landscape/1/4388.jpg"),
                         originalURL: URL(string: "https://static.tvmaze.com/uploads/images/original_untouched/1/4388.jpg")),
            name: "Pilot",
            summary: "When the residents of Chester's Mill find themselves trapped under a massive transparent dome with no way out, they struggle to survive as resources rapidly dwindle and panic quickly escalates.",
            runtime: 60)
   }
   
   static var previewEpisode2: Self {
      .init(id: 4953,
            season: 1,
            number: 2,
            image: .init(mediumURL: URL(string: "https://static.tvmaze.com/uploads/images/medium_landscape/1/4389.jpg"),
                         originalURL: URL(string: "https://static.tvmaze.com/uploads/images/original_untouched/1/4389.jpg")),
            name: "The Fire",
            summary: "While the residents of Chester's Mill face the uncertainty of life in the dome, panic is heightened when a house goes up in flames and their fire department is outside of the dome.",
            runtime: 60)
   }
   
   static var previewEpisode3: Self {
      .init(id: 4954,
            season: 1,
            number: 3,
            image: .init(mediumURL: URL(string: "https://static.tvmaze.com/uploads/images/medium_landscape/1/4390.jpg"),
                         originalURL: URL(string: "https://static.tvmaze.com/uploads/images/original_untouched/1/4390.jpg")),
            name: "Manhunt",
            summary: "When a former deputy goes rogue, Big Jim recruits Barbie to join the manhunt to keep the town safe. Meanwhile, Junior is determined to escape the dome by going underground.",
            runtime: 60)
   }
   
   static var previewEpisode4: Self {
      .init(id: 4955,
            season: 1,
            number: 4,
            image: .init(mediumURL: URL(string: "https://static.tvmaze.com/uploads/images/medium_landscape/1/4391.jpg"),
                         originalURL: URL(string: "https://static.tvmaze.com/uploads/images/original_untouched/1/4391.jpg")),
            name: "Outbreak",
            summary: "The people of Chester's Mill fall into a state of panic as an outbreak of meningitis strikes their community, threatening their already depleted medical supplies. Meanwhile, Julia continues to search for answers into her husband's disappearance.",
            runtime: 60)
   }
   
   static var previewEpisode5: Self {
      .init(id: 4956,
            season: 1,
            number: 5,
            image: .init(mediumURL: URL(string: "https://static.tvmaze.com/uploads/images/medium_landscape/1/4392.jpg"),
                         originalURL: URL(string: "https://static.tvmaze.com/uploads/images/original_untouched/1/4392.jpg")),
            name: "The Age of Reason",
            summary: "The Chester's Mill residents receive an unexpected visit from their loved ones on the other side. Meanwhile, the community braces for a threat from outside the Dome.",
            runtime: 60)
   }
   
   static var previewEpisode6: Self {
      .init(id: 4957,
            season: 1,
            number: 6,
            image: .init(mediumURL: URL(string: "https://static.tvmaze.com/uploads/images/medium_landscape/1/4393.jpg"),
                         originalURL: URL(string: "https://static.tvmaze.com/uploads/images/original_untouched/1/4393.jpg")),
            name: "Get Behind the Mule",
            summary: "When the town begins to run low on water, the residents of Chester's Mill begin to fight for the remaining resources. Meanwhile, Julia discovers a strange connection that two of the town's residents have with the Dome.",
            runtime: 60)
   }
   
   static var previewEpisode7: Self {
      .init(id: 4958,
            season: 1,
            number: 7,
            image: .init(mediumURL: URL(string: "https://static.tvmaze.com/uploads/images/medium_landscape/1/4394.jpg"),
                         originalURL: URL(string: "https://static.tvmaze.com/uploads/images/original_untouched/1/4394.jpg")),
            name: "Blue Gold",
            summary: "Big Jim takes matters into his own hands when he feels his authority slipping away, and the dome displays its power when a life is taken just as a newborn arrives.",
            runtime: 60)
   }
   
   static var previewEpisode8: Self {
      .init(id: 4959,
            season: 1,
            number: 8,
            image: .init(mediumURL: URL(string: "https://static.tvmaze.com/uploads/images/medium_landscape/1/4395.jpg"),
                         originalURL: URL(string: "https://static.tvmaze.com/uploads/images/original_untouched/1/4395.jpg")),
            name: "Two Ships",
            summary: "Junior stands up to his father and is shattered when he discovers the truth about his mother's past. Meanwhile, Julia learns firsthand the powers of the \"mini dome\"",
            runtime: 60)
   }
   
   static var previewEpisode9: Self {
      .init(id: 4960,
            season: 1,
            number: 9,
            image: .init(mediumURL: URL(string: "https://static.tvmaze.com/uploads/images/medium_landscape/1/4396.jpg"),
                         originalURL: URL(string: "https://static.tvmaze.com/uploads/images/original_untouched/1/4396.jpg")),
            name: "Achilles",
            summary: "Big Jim and Barbie discover their lives are more intertwined than they knew when a mysterious woman, Maxine, shows up unexpectedly in Chester's Mill.",
            runtime: 60)
   }
   
   static var previewEpisode10: Self {
      .init(id: 4961,
            season: 1,
            number: 10,
            image: .init(mediumURL: URL(string: "https://static.tvmaze.com/uploads/images/medium_landscape/1/4397.jpg"),
                         originalURL: URL(string: "https://static.tvmaze.com/uploads/images/original_untouched/1/4397.jpg")),
            name: "No Place Like Home",
            summary: "Julia uncovers the truth about her husband's disappearance and unravels some of Chester's Mill's darkest secrets. Meanwhile, Maxine shows Barbie how she plans to take control of the town.",
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
