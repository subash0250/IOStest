import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @Binding var isAdmin: Bool
    @State private var username = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showRegistrationView = false

    var body: some View {
        NavigationStack {
            VStack {
//                Image(systemName: "lock.fill")
//                    .resizable()
//                    .frame(width: 250, height: 200)
//                    .scaledToFit()
//                    .padding()
                
                Image(.libraryLogo).resizable().frame(width:250, height:200)
                    .scaledToFit()
                
                Text("Login")
                    .font(.largeTitle)
                    .padding()
                
                VStack {
                    TextField("Enter your Email", text: $username).padding().frame(width: 400,height: 50,alignment: .center).textFieldStyle(RoundedBorderTextFieldStyle()).textContentType(.newPassword)
                    
                    SecureField("Enter Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding().textContentType(.newPassword)
                    
                    Button(action: {
                        login()
                    }) {
                        Text("Login")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Login Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }
                    .padding()
                    
                    NavigationLink(destination: RegistrationView(isPresented: $showRegistrationView)) {
                        Text("New to application? Sign Up").padding()
                    }
                    .padding()
    
                }
                .navigationBarTitle("Login")
            }
        }
    }
    
    private func login() {
        Auth.auth().signIn(withEmail: username, password: password) { authResult, error in
            if let error = error {
                alertMessage = error.localizedDescription
                showAlert = true
                return
            }
            
            // Successfully authenticated
            if let user = authResult?.user {
                isLoggedIn = true
                checkAdminPrivileges(for: user)
            }
        }
    }
    
    private func checkAdminPrivileges(for user: User) {
        // Example: Hardcoded admin credentials
        let adminEmail = "Gaddamsubashreddy0519@gmail.com"
        let adminPassword = "Welcome123"
        
        if user.email == adminEmail && password == adminPassword {
            
            isAdmin = true
            //NavigationLink(destination: AdminDashboard()) {
            //    Text("Welcome" + username)
           // }
            
            
            
        } else {
            isAdmin = false
//            NavigationLink(destination: DashboardView()) {
//                Text("Welcome" + username)
//            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isLoggedIn: .constant(false), isAdmin: .constant(false))
    }
}
