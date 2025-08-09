#if DEBUG
extension QueriedShowsModel.SingleQueriedShow {
   static var previewQueried1: Self {
      .init(score: 0.9009114,
            show: .previewQueried1)
   }
   
   static var previewQueried2: Self {
      .init(score: 0.87978435,
            show: .previewQueried2)
   }
   
   static var previewQueried3: Self {
      .init(score: 0.69502723,
            show: .previewQueried3)
   }
   
   static var previewQueried4: Self {
      .init(score: 0.6942474,
            show: .previewQueried4)
   }
   
   static var previewQueried5: Self {
      .init(score: 0.6938046,
            show: .previewQueried5)
   }
   
   static var previewQueried6: Self {
      .init(score: 0.6931727,
            show: .previewQueried6)
   }
   
   static var previewQueried7: Self {
      .init(score: 0.69271255,
            show: .previewQueried6)
   }
   
   static var previewQueried8: Self {
      .init(score: 0.6924329,
            show: .previewQueried8)
   }
   
   static var previewQueried9: Self {
      .init(score: 0.6921505,
            show: .previewQueried9)
   }
   
   static var previewQueried10: Self {
      .init(score: 0.69079494,
            show: .previewQueried10)
   }
}

extension Collection where Element == QueriedShowsModel.SingleQueriedShow {
   static var queriedShowsPreview: [QueriedShowsModel.SingleQueriedShow] {
      [
         .previewQueried1,
         .previewQueried2,
         .previewQueried3,
         .previewQueried4,
         .previewQueried5,
         .previewQueried6,
         .previewQueried7,
         .previewQueried8,
         .previewQueried9,
         .previewQueried10
      ]
   }
}

extension QueriedShowsModel {
   static var preview: Self {
      .init(queriedShows: .queriedShowsPreview)
   }
}
#endif
