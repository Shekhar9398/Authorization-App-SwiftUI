import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct UserProfileView: View {
    @State private var user: Users?
    @State private var userId = Auth.auth().currentUser?.uid
    
    var body: some View {
        VStack {
            
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 70, height: 70)
            
            VStack(alignment: .leading, spacing: 10) {
                if let user = user {
                    HStack{
                        Text("Name: ")
                            .font(.title)
                        Text("\(user.name)")
                            .font(.title)
                    }
                    HStack{
                        Text("Age: ")
                            .font(.subheadline)
                        Text("\(user.age)")
                            .font(.subheadline)
                    }
                    HStack{
                        Text("Email: ")
                            .font(.subheadline)
                        Text(user.email)
                            .font(.subheadline)
                    }
                } else {
                    Text("Loading user data...")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .onAppear {
                // Ensure user is logged in
                if let userId = userId {
                    fetchFirestoreUsers(userId: userId)
                } else {
                    print("User not logged in")
                }
        }
        }
    }
    
    func fetchFirestoreUsers(userId: String) {
        let db = Firestore.firestore()
        let collection = "users"
        
        print("Fetching user data for userId: \(userId)")
        
        db.collection(collection).document(userId).getDocument { document, error in
            if let error = error {
                print("Firestore Fetch Users Error: \(error.localizedDescription)")
                return
            }
            
            if let document = document, document.exists, let data = document.data() {
                print("Document data: \(data)")
                
                let name = data["name"] as? String ?? "Unknown"
                let age = data["age"] as? Int ?? 0
                let email = data["email"] as? String ?? "Unknown"
                
                DispatchQueue.main.async {
                    self.user = Users(name: name, age: age, email: email)
                }
            } else {
                print("Document does not exist or has no data")
            }
        }
    }
}

struct Users {
    var name: String
    var age: Int
    var email: String
}

#Preview {
    UserProfileView()
}
