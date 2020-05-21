import SwiftUI

struct SpeedrunFilterView: View {
    @Binding var filterModel: SpeedrunFilterModel

    var body: some View {
        HStack {
            Text(filterModel.runStatus.rawValue)
            Button(action: {
                self.filterModel.runStatus = self.filterModel.runStatus == .verified ? .new : .verified
            }, label: { Text("Switch") })
        }
    }
}
