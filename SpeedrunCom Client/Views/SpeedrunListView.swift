import SwiftUI

struct SpeedrunListView: View {
    @ObservedObject var viewModel = SpeedrunListViewModel()

    var body: some View {
        NavigationView {
            GeometryReader { geometryProxy in
                List() {
                    Section(header:
                        SpeedrunFilterView(filterModel: self.$viewModel.filterModel)
                            .listRowInsets(EdgeInsets())
                            .padding()
                    ) {
                        ForEach(self.viewModel.speedruns) { speedrun in
                            NavigationLink(destination: SpeedrunDetailView(speedrun: speedrun)) {
                                SpeedrunItemView(speedrun: speedrun, geometryProxy: geometryProxy)
                                    .onAppear { self.speedrunItemWillAppear(speedrun) }
                            }
                        }
                    }
                }
            }.navigationBarTitle("Search speedruns")
        }
    }

    private func speedrunItemWillAppear(_ speedrun: Speedrun) {
        if speedrun.id == viewModel.speedruns.last?.id {
            viewModel.loadNextPage()
        }
    }
}
