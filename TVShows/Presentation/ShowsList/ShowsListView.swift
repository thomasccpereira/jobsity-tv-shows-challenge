import SwiftUI

struct ShowsListView: View {
   var viewModel: ShowsListViewModel
   @State private var firstLoad = true
   
   var body: some View {
      listView
         .navigationTitle("TV Shows")
         .onAppear {
            if firstLoad {
               Task { try await viewModel.loadFirstPage() }
               firstLoad = false
            }
         }
         // .alert("Error", isPresented: .constant(vm.error != nil), actions: {
         //    Button("OK") { vm.error = nil }
         // }, message: { Text(vm.error ?? "") })
   }
   
   @ViewBuilder
   private var listView: some View {
      List(viewModel.shows, id: \.id) { singleShow in
         ShowsListSingleItemView(singleShow: singleShow)
            .onAppear {
               Task { try await viewModel.loadMoreShowsIfNeeded(after: singleShow) }
            }
      }
   }
}

