import SwiftUI

struct SpeedrunFilterView: View {
    @Binding var filterModel: SpeedrunFilterModel

    var body: some View {
        HStack {
            FilterItemView(title: "Status", value: filterModel.runStatus.rawValue, action: { self.configureRunStatus() })
            Spacer()
            FilterItemView(title: "Order by", value: filterModel.orderBy.rawValue, action: { self.configureOrderBy() })
            Spacer()
            FilterItemView(title: "Sorting", value: filterModel.sorting.rawValue, action: { self.configureSorting() })
        }
    }

    private func configureRunStatus() {
        self.filterModel.runStatus = .verified
    }

    private func configureOrderBy() {
        self.filterModel.orderBy = .platform
    }

    private func configureSorting() {
        self.filterModel.sorting = .asc
    }
}

private struct FilterItemView: View {
    private(set) var title: String
    private(set) var value: String
    private(set) var action: () -> Void

    var body: some View {
        VStack {
            Text(title).fontWeight(.bold)
            Text(value)
        }.onTapGesture(perform: action)
    }
}
