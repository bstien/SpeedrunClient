import SwiftUI

struct SpeedrunListView: View {
    @ObservedObject var viewModel = SpeedrunListViewModel()

    var body: some View {
        GeometryReader { geometryProxy in
            List() {
                SpeedrunFilterView(filterModel: self.$viewModel.filterModel)
                ForEach(self.viewModel.speedruns) { speedrun in
                    SpeedrunItemView(speedrun: speedrun, geometryProxy: geometryProxy)
                }
            }
        }
    }
}
