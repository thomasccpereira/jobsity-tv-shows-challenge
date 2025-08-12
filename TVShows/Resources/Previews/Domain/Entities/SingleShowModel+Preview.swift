import Foundation

extension SingleShowModel {
   static var previewShow1: Self {
      .init(id: 250,
            image: .init(mediumURL: URL(string: "https://static.tvmaze.com/uploads/images/medium_portrait/1/4600.jpg"),
                         originalURL: URL(string: "https://static.tvmaze.com/uploads/images/original_untouched/1/4600.jpg")),
            name: "Kirby Buckets",
            schedule: .init(time: "07:00", days: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]),
            genres: ["Comedy"],
            runtime: 30,
            summary: "<p>The single-camera series that mixes live-action and animation stars Jacob Bertrand as the title character. <b>Kirby Buckets</b> introduces viewers to the vivid imagination of charismatic 13-year-old Kirby Buckets, who dreams of becoming a famous animator like his idol, Mac MacCallister. With his two best friends, Fish and Eli, by his side, Kirby navigates his eccentric town of Forest Hills where the trio usually find themselves trying to get out of a predicament before Kirby's sister, Dawn, and her best friend, Belinda, catch them. Along the way, Kirby is joined by his animated characters, each with their own vibrant personality that only he and viewers can see.</p>")
   }
   
   static var previewShow2: Self {
      .init(id: 251,
            image: .init(mediumURL: URL(string: "https://static.tvmaze.com/uploads/images/medium_portrait/1/4601.jpg"),
                         originalURL: URL(string: "https://static.tvmaze.com/uploads/images/original_untouched/1/4601.jpg")),
            name: "Downton Abbey",
            schedule: .init(time: "21:00", days: ["Sunday"]),
            genres: ["Drama", "Family", "Romance"],
            runtime: 60,
            summary: "<p>The Downton Abbey estate stands a splendid example of confidence and mettle, its family enduring for generations and its staff a well-oiled machine of propriety. But change is afoot at Downton...</p>")
   }
   
   static var previewShow3: Self {
      .init(id: 252,
            image: .init(mediumURL: URL(string: "https://static.tvmaze.com/uploads/images/medium_portrait/316/792450.jpg"),
                         originalURL: URL(string: "https://static.tvmaze.com/uploads/images/original_untouched/316/792450.jpg")),
            name: "Girl Meets World",
            schedule: .init(time: "18:00", days: ["Friday"]),
            genres: ["Drama", "Comedy", "Family"],
            runtime: 30,
            summary: "<p><b>Girl Meets World</b> is based on ABC's hugely popular sitcom, Boy Meets World (1993)...</p>")
   }
   
   static var previewShow4: Self {
      .init(id: 253,
            image: .init(mediumURL: URL(string: "https://static.tvmaze.com/uploads/images/medium_portrait/534/1335955.jpg"),
                         originalURL: URL(string: "https://static.tvmaze.com/uploads/images/original_untouched/534/1335955.jpg")),
            name: "Hell's Kitchen",
            schedule: .init(time: "20:00", days: ["Thursday"]),
            genres: ["Food"],
            runtime: 60,
            summary: "<p>In <b>Hell's Kitchen</b>, aspiring chefs are put through an intense culinary academy...</p>")
   }
   
   static var previewShow5: Self {
      .init(id: 254,
            image: .init(mediumURL: URL(string: "https://static.tvmaze.com/uploads/images/medium_portrait/1/4656.jpg"),
                         originalURL: URL(string: "https://static.tvmaze.com/uploads/images/original_untouched/1/4656.jpg")),
            name: "World Series of Poker",
            schedule: .init(time: "", days: ["Monday", "Tuesday", "Sunday"]),
            genres: ["Sports"],
            runtime: nil,
            summary: "<p>The <b>World Series of Poker</b> is where the world's best poker players battle...</p>")
   }
   
   static var previewShow6: Self {
      .init(id: 255,
            image: .init(mediumURL: URL(string: "https://static.tvmaze.com/uploads/images/medium_portrait/1/4660.jpg"),
                         originalURL: URL(string: "https://static.tvmaze.com/uploads/images/original_untouched/1/4660.jpg")),
            name: "Anthony Bourdain: Parts Unknown",
            schedule: .init(time: "21:00", days: ["Sunday"]),
            genres: ["Food", "Travel"],
            runtime: 60,
            summary: "<p><b>Anthony Bourdain: Parts Unknown</b> follows chef and author Anthony Bourdain...</p>")
   }
   
   static var previewShow7: Self {
      .init(id: 256,
            image: .init(mediumURL: URL(string: "https://static.tvmaze.com/uploads/images/medium_portrait/1/4661.jpg"),
                         originalURL: URL(string: "https://static.tvmaze.com/uploads/images/original_untouched/1/4661.jpg")),
            name: "Comic Book Men",
            schedule: .init(time: "00:00",days: ["Sunday"]),
            genres: ["Comedy"],
            runtime: 30,
            summary: "<p>AMC's popular unscripted series <b>Comic Book Men</b> takes another dive into world of geekdom...</p>")
   }
   
   static var previewShow8: Self {
      .init(id: 257,
            image: .init(mediumURL: URL(string: "https://static.tvmaze.com/uploads/images/medium_portrait/1/4662.jpg"),
                         originalURL: URL(string: "https://static.tvmaze.com/uploads/images/original_untouched/1/4662.jpg")),
            name: "Key & Peele",
            schedule: .init(time: "22:00", days: ["Wednesday"]),
            genres: ["Comedy"],
            runtime: 30,
            summary: "<p>Keegan-Michael Key and Jordan Peele are the stars of <b>Key &amp; Peele</b>...</p>")
   }
   
   static var previewShow9: Self {
      .init(id: 258,
            image: .init(mediumURL: URL(string: "https://static.tvmaze.com/uploads/images/medium_portrait/118/295401.jpg"),
                         originalURL: URL(string: "https://static.tvmaze.com/uploads/images/original_untouched/118/295401.jpg")),
            name: "Glue",
            schedule: .init(time: "22:00", days: ["Monday"]),
            genres: ["Drama"],
            runtime: 60,
            summary: "<p>Bafta-winning writer Jack Thorne's compelling eight-part drama...</p>")
   }
   
   static var previewShow10: Self {
      .init(id: 259,
            image: .init(mediumURL: URL(string: "https://static.tvmaze.com/uploads/images/medium_portrait/304/760085.jpg"),
                         originalURL: URL(string: "https://static.tvmaze.com/uploads/images/original_untouched/304/760085.jpg")),
            name: "Southern Justice",
            schedule: .init(time: "21:00", days: ["Wednesday"]),
            genres: ["Crime"],
            runtime: 60,
            summary: "<p>Follow the Sheriff Deputies of Sullivan County, TN and Ashe County, NC...</p>")
   }
   
   static var previewQueried1: Self {
      .init(id: 139,
            image: .init(mediumURL: URL(string: "https://static.tvmaze.com/uploads/images/medium_portrait/31/78286.jpg"),
                         originalURL: URL(string: "https://static.tvmaze.com/uploads/images/original_untouched/31/78286.jpg")),
            name: "Girls",
            schedule: .init(time: "22:00", days: ["Sunday"]),
            genres: ["Drama", "Romance"],
            runtime: 30,
            summary: "<p>This Emmy winning series is a comic look at the assorted humiliations and rare triumphs of a group of girls in their 20s.</p>"
      )
   }
   
   static var previewQueried2: Self {
      .init(id: 41734,
            image: .init(mediumURL: URL(string: "https://static.tvmaze.com/uploads/images/medium_portrait/191/478539.jpg"),
                         originalURL: URL(string: "https://static.tvmaze.com/uploads/images/original_untouched/191/478539.jpg")),
            name: "GIRLS",
            schedule: .init(time: "", days: ["Thursday"]),
            genres: ["Comedy"],
            runtime: 41,
            summary: nil
      )
   }
   
   static var previewQueried3: Self {
      .init(id: 525,
            image: .init(mediumURL: URL(string: "https://static.tvmaze.com/uploads/images/medium_portrait/4/11308.jpg"),
                         originalURL: URL(string: "https://static.tvmaze.com/uploads/images/original_untouched/4/11308.jpg")),
            name: "Gilmore Girls",
            schedule: .init(time: "21:00", days: ["Tuesday"]),
            genres: ["Drama", "Comedy", "Romance"],
            runtime: 60,
            summary: "<p><b>Gilmore Girls</b> is a drama centering around the relationship between a thirtysomething single mother and her teen daughter living in Stars Hollow, Connecticut.</p>"
      )
   }
   
   static var previewQueried4: Self {
      .init(id: 67594,
            image: .init(mediumURL: URL(string: "https://static.tvmaze.com/uploads/images/medium_portrait/556/1390988.jpg"),
                         originalURL: URL(string: "https://static.tvmaze.com/uploads/images/original_untouched/556/1390988.jpg")),
            name: "Dope Girls",
            schedule: .init(time: "", days: []),
            genres: ["Drama", "Crime", "History"],
            runtime: nil,
            summary: "<p>As WWI ends, housewife Kate Galloway sets up a nightclub in Soho to support her daughters. But Kate must contend with a dangerous gangster family and the police to survive.</p>"
      )
   }
   
   static var previewQueried5: Self {
      .init(id: 23542,
            image: .init(mediumURL: URL(string: "https://static.tvmaze.com/uploads/images/medium_portrait/297/744253.jpg"),
                         originalURL: URL(string: "https://static.tvmaze.com/uploads/images/original_untouched/297/744253.jpg")),
            name: "Good Girls",
            schedule: .init(time: "21:00", days: ["Thursday"]),
            genres: ["Drama", "Comedy", "Crime"],
            runtime: 60,
            summary: "<p><b>Good Girls</b> follows three \"good girl\" suburban wives and mothers who suddenly find themselves in desperate circumstances and decide to stop playing it safe, and risk everything to take their power back.</p>")
   }
   
   static var previewQueried6: Self {
      .init(id: 49334,
            image: .init(mediumURL: URL(string: "https://static.tvmaze.com/uploads/images/medium_portrait/406/1015813.jpg"),
                         originalURL: URL(string: "https://static.tvmaze.com/uploads/images/original_untouched/406/1015813.jpg")),
            name: "Shining Girls",
            schedule: .init( time: "", days: ["Friday"]),
            genres: ["Crime", "Thriller", "Supernatural"],
            runtime: nil,
            summary: "<p><b>Shining Girls</b> is a metaphysical thriller, which follows a Chicago reporter who survived a brutal assault only to find her reality shifting as she hunts down her attacker.</p>")
   }
   
   static var previewQueried7: Self {
      .init(id: 33320,
            image: .init(mediumURL: URL(string: "https://static.tvmaze.com/uploads/images/medium_portrait/402/1007479.jpg"),
                         originalURL: URL(string: "https://static.tvmaze.com/uploads/images/original_untouched/402/1007479.jpg")),
            name: "Derry Girls",
            schedule: .init(time: "", days: []),
            genres: ["Comedy"],
            runtime: nil,
            summary: "<p>16-year-old Erin Quinn lives with her uncompromising mother, her long-suffering father and the fearsome ‘Granda Joe’...</p>")
   }
   
   static var previewQueried8: Self {
      .init(id: 42986,
            image: .init(mediumURL: URL(string: "https://static.tvmaze.com/uploads/images/medium_portrait/417/1043587.jpg"),
                         originalURL: URL(string: "https://static.tvmaze.com/uploads/images/original_untouched/417/1043587.jpg")),
            name: "Paper Girls",
            schedule: .init(time: "", days: []),
            genres: ["Drama", "Science-Fiction"],
            runtime: nil,
            summary: "<p><b>Paper Girls</b> follows four young girls who, while out delivering papers on the morning after Halloween in 1988, become unwittingly caught in a conflict between warring factions of time-travelers...</p>")
   }
   
   static var previewQueried9: Self {
      .init(id: 3418,
            image: .init(mediumURL: URL(string: "https://static.tvmaze.com/uploads/images/medium_portrait/17/44896.jpg"),
                         originalURL: URL(string: "https://static.tvmaze.com/uploads/images/original_untouched/17/44896.jpg")),
            name: "ANZAC Girls",
            schedule: .init(time: "20:30", days: ["Sunday"]),
            genres: ["Drama", "War", "History"],
            runtime: 60,
            summary: "<p>Honouring the Centenary of the commencement of WW1, <b>ANZAC Girls</b> is a moving new six-part series...</p>"
      )
   }
   
   static var previewQueried10: Self {
      .init(id: 32087,
            image: .init(mediumURL: URL(string: "https://static.tvmaze.com/uploads/images/medium_portrait/137/344365.jpg"),
                         originalURL: URL(string: "https://static.tvmaze.com/uploads/images/original_untouched/137/344365.jpg")),
            name: "Chicken Girls",
            schedule: .init(time: "", days: ["Tuesday"]),
            genres: ["Drama", "Music", "Romance"],
            runtime: nil,
            summary: "<p>Rhyme and her friends — known by their 'ship name, \"The Chicken Girls\" — have been dancing together forever. But this year, everything's changing...</p>")
   }
}

extension Collection where Element == SingleShowModel {
   static var showsListPreview: [SingleShowModel] {
      [
         .previewShow1,
         .previewShow2,
         .previewShow3,
         .previewShow4,
         .previewShow5,
         .previewShow6,
         .previewShow7,
         .previewShow8,
         .previewShow9,
         .previewShow10
      ]
   }
}
