import SwiftUI

struct SpeedrunDetailView: View {
    var speedrun: Speedrun

    var body: some View {
        Text(speedrun.status.rawValue)
    }
}
