import SwiftUI

struct SpeedrunFilterView: View {
    @Binding var filterModel: SpeedrunFilterModel
    @State private var showRunStatusFilter = false
    @State private var showOrderByFilter = false
    @State private var showSortingFilter = false

    var body: some View {
        HStack {
            FilterItemView(title: "Run status", value: filterModel.runStatus.humanReadable, action: { self.showRunStatusFilter.toggle() })
                .actionSheet(isPresented: $showRunStatusFilter) {
                    ActionSheet(title: Text("Select run status"), buttons:
                    RunStatus.allCases.map({ runStatus in
                        ActionSheet.Button.default(Text(runStatus.humanReadable), action: { self.filterModel.runStatus = runStatus })
                    }) + [ActionSheet.Button.cancel()])
                }
            Spacer()
            FilterItemView(title: "Order by", value: filterModel.orderBy.humanReadable, action: { self.showOrderByFilter.toggle() })
                .actionSheet(isPresented: $showOrderByFilter) {
                    ActionSheet(title: Text("Order results by"), buttons:
                    OrderBy.Run.allCases.map({ orderBy in
                        ActionSheet.Button.default(Text(orderBy.humanReadable), action: { self.filterModel.orderBy = orderBy })
                    }) + [ActionSheet.Button.cancel()])
                }
            Spacer()
            FilterItemView(title: "Sorting", value: filterModel.sorting.humanReadable, action: { self.showSortingFilter.toggle() })
                .actionSheet(isPresented: $showSortingFilter) {
                    ActionSheet(title: Text("Sort results by"), buttons:
                    SortDirection.allCases.map({ sorting in
                        ActionSheet.Button.default(Text(sorting.humanReadable), action: { self.filterModel.sorting = sorting })
                    }) + [ActionSheet.Button.cancel()])
                }
        }
    }
}

private struct FilterItemView: View {
    private(set) var title: String
    private(set) var value: String
    private(set) var action: () -> Void

    var body: some View {
        VStack {
            Text(title).fontWeight(.medium)
            Text(value).fontWeight(.regular)
        }.onTapGesture(perform: action)
    }
}
