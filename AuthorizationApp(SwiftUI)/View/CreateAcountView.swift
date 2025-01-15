import SwiftUI
import FirebaseAuth

struct CreateAccountView: View {
 
    @State private var name = ""
    @State private var age = ""
    @State private var dob = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var date = Date()
    @State private var alertMessage = ""
    @State private var alertText = ""
    @State private var primaryAlertText = ""
    @State private var secondaryAlertText = ""
    @State private var showCustomBack = true
    
    @State private var showAlert = false
    @State private var showLogin = false
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        
        VStack(spacing: 40) {
            ///Mark :- User Details
            VStack(alignment: .leading) {
                Text("Name")
                TextField("Enter your full name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom, 25)
                
                Text("Age")
                TextField("Enter age", text: $age)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom, 25)
                    .keyboardType(.numberPad)

                Text("Email")
                TextField("Enter your email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom, 25)
                
                Text("Password")
                SecureField("Enter your password", text: $password)
                    .padding(.bottom, 25)
                
                Text("Confirm Password")
                SecureField("Confirm your password", text: $confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom, 25)
            }
            .padding(.horizontal)
            .padding(.vertical, 20)
            .bold()

            /// Mark:- Create Account Button
            Button("Create") {
                if validate() {
                    createNewUser()
                }
            }
            .bold()
            .frame(width: 100, height: 40)
            .background(Color.mint)
            .foregroundColor(.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1)
            )
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(alertText),
                    message: Text(alertMessage),
                    primaryButton: .default(Text(primaryAlertText)) {
                        if primaryAlertText == "Login"{
                            dismiss()
                        }
                    },
                    secondaryButton: .destructive(Text(secondaryAlertText))
                )
            }
            .padding(.bottom, 25)
        }
        .navigationBarBackButtonHidden(showCustomBack)
        .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if showCustomBack {
                        Button(action: {
                            dismiss()
                        }) {
                            HStack {
                                Image(systemName:"chevron.backward")
                                Text("Login")
                            }
                        }
                    }
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
    
    ///Mark: - Validate Fields and Details
    func validate() -> Bool {
        if name.isEmpty || age.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty || !isValidEmail(email) {
            alertMessage = "Please fill all the fields correctly"
            alertText = "Sorry"
            primaryAlertText = "Ok"
            secondaryAlertText = "Dismiss"
            showAlert = true
            return false
        }
        
        if password != confirmPassword {
            alertText = "Invalid Password"
            alertMessage = "Passwords do not match"
            primaryAlertText = "Correct"
            secondaryAlertText = "Dismiss"
            showAlert = true
            return false
        }
        return true
    }
    
    ///Mark:- Create User on Firebase Authentication
    func createNewUser() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                alertText = "Sorry"
                alertMessage = "Account creation failed: \(error.localizedDescription)"
                primaryAlertText = "Ok"
                secondaryAlertText = "Cancel"
            } else {
                alertText = "Congratulations"
                alertMessage = "Your account has been created successfully"
                primaryAlertText = "Login"
                secondaryAlertText = "Dismiss"
            }
            showAlert = true
        }
    }
    
    /// Mark : - Email Validation
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

#Preview {
    CreateAccountView()
}
