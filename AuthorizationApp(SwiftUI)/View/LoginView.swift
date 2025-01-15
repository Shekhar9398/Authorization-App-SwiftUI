import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var userText = ""
    @State private var userPassword = ""
    @State private var showUserDashboard = false
    @State private var showCreateAccount = false
    @State private var showWrongInfoAlert = false
    
    var body: some View {
        NavigationStack {
            VStack {
                ///Mark:- Display Image
                Image("loginImage")
                    .resizable()
                    .frame(width: 250, height: 220)
                    .padding(.bottom, 50)
                
                ///Mark:- Username and Password
                VStack(alignment: .leading) {
                    Text("Username")
                        .foregroundColor(showWrongInfoAlert ? .red : .black)
                        .bold()
                        .font(.title3)
                    
                    TextField("Enter Username", text: $userText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.bottom, 20)
                    
                    Text("Password")
                        .foregroundColor(showWrongInfoAlert ? .red : .black)
                        .bold()
                        .font(.title3)
                    
                    SecureField("Enter Password", text: $userPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.bottom, 10)
                }
                .padding(.horizontal)
                
                ///Mark:- Navigate To User Dashboard
                NavigationLink(destination: MainTabView(), isActive: $showUserDashboard) {
                }
                
                ///Mark:- Login Button
                Button("Login") {
                    loginUser()
                }
                .bold()
                .frame(width: 150, height: 40)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(.bottom, 20)
                .alert(isPresented: $showWrongInfoAlert, content: {
                    Alert(title: Text("Oops"), message: Text("Please enter correct username and password"), primaryButton: .default(Text("Retry")), secondaryButton: .destructive(Text("Dismiss")))
                })
                
                ///Mark:- Navigate To Create Account View
                NavigationLink(destination: CreateAccountView(), isActive: $showCreateAccount) {
                    // Navigation logic here
                }
                
                ///Mark:- Create New User Button
                HStack {
                    Text("New user?")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.gray)
                    
                    Button("Create Account") {
                        showCreateAccount = true
                    }
                    .bold()
                    .font(.subheadline)
                    .foregroundColor(.mint)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }
    }
    
    ///Mark : - Login Handle With Firebase Authentication
    func loginUser() {
        Auth.auth().signIn(withEmail: userText, password: userPassword) { result, error in
            DispatchQueue.main.async {
                if let error = error {
                    showWrongInfoAlert = true
                } else {
                    showUserDashboard = true
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
