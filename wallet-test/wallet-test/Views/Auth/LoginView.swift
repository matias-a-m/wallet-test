import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {

                Text("Iniciar sesión")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)

                TextField("Correo electrónico", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)

                // Campo de contraseña con funcionalidad de ver/ocultar
                HStack {
                    if isPasswordVisible {
                        TextField("Contraseña", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                    } else {
                        SecureField("Contraseña", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                    }
                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.gray)
                    }
                }

                Button(action: {
                    viewModel.signIn(email: email, password: password)
                }) {
                    Text("Iniciar sesión")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                        .padding(.top)
                }

                NavigationLink(
                    destination: RegisterView(),
                    label: {
                        Text("¿No tienes cuenta? Regístrate")
                            .foregroundColor(.blue)
                            .font(.body)
                            .padding(.top)
                    }
                )

                NavigationLink(
                    destination: MainView()
                        .navigationBarBackButtonHidden(true),
                    isActive: $viewModel.isAuthenticated
                ) {
                    EmptyView()
                }
            }
            .padding(.top)
            .padding(.horizontal)
            .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    LoginView()
}
