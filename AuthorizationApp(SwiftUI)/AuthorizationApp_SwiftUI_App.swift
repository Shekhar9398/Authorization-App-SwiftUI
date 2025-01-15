
import SwiftUI
import FirebaseCore

@main
struct AuthorizationApp_SwiftUI_App: App {
    
    init(){
        FirebaseApp.configure()
    }
        
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
