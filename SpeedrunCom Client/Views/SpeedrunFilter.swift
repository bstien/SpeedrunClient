import SwiftUI

struct SpeedrunFilter: View {
    @ObservedObject var viewModel: SpeedrunListViewModel

    var body: some View {
        HStack {
            Text(viewModel.runStatus.rawValue)
            Button(action: {
                self.viewModel.runStatus = self.viewModel.runStatus == .verified ? .new : .verified
            }, label: { Text("Switch") })
        }
    }
}
