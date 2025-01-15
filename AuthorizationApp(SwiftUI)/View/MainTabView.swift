
import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView{
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            NotificationView()
                .tabItem {
                    Label("Notifications", systemImage: "bell.fill")
                }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    MainTabView()
}
