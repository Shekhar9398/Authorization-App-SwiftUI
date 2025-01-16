
import SwiftUI

struct NotificationView: View {
    var body: some View {
        List{
            ForEach(1...30, id: \.self){ i in
                HStack{
                    Image(systemName: "\(i).circle")
                    Text("Notification \(i)")
                }
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    NotificationView()
}
