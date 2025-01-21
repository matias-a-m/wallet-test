import SwiftUI

struct RegisterView: View {

    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var passwordStrengthMessage = ""
    @State private var passwordMatchColor: Color = .clear
    @State private var emailErrorMessage = ""

    var body: some View {
        VStack(spacing: 20) {

            Text("Crear una cuenta")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.primary)

            TextField("Correo electrónico", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .disableAutocorrection(true)
                .onChange(of: email) { newValue in
                    emailErrorMessage = validateEmail(email: newValue)
                }

            if !emailErrorMessage.isEmpty {
                Text(emailErrorMessage)
                    .foregroundColor(.red)
                    .font(.footnote)
            }

            TextField("Contraseña", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .onChange(of: password) { newValue in
                    passwordStrengthMessage = passwordStrengthValidation(password: newValue)
                }

            Text(passwordStrengthMessage)
                .foregroundColor(.red)
                .font(.footnote)

            TextField("Confirmar contraseña", text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .onChange(of: confirmPassword) { _ in
                    passwordMatchColor = (password == confirmPassword) ? .green : .red
                }

            if password != confirmPassword && !confirmPassword.isEmpty {
                Text("Las contraseñas no coinciden")
                    .foregroundColor(.red)
                    .font(.footnote)
            }

            Button(action: {
                if emailErrorMessage.isEmpty && password == confirmPassword && passwordStrengthMessage.isEmpty {
                    viewModel.signUp(email: email, password: password)
                } else {
                    viewModel.errorMessage = "Verifica los campos antes de continuar."
                }
            }) {
                Text("Registrarse")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(password == confirmPassword && emailErrorMessage.isEmpty ? Color.blue : Color.gray)
                    .cornerRadius(12)
                    .shadow(radius: 5)
                    .padding(.top)
                    .disabled(password != confirmPassword || !passwordStrengthMessage.isEmpty || !emailErrorMessage.isEmpty)
            }

            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("¿Ya tienes cuenta? Inicia sesión")
                    .foregroundColor(.blue)
                    .font(.body)
                    .padding(.top)
            }
        }
        .padding(.top)
        .padding(.horizontal)
        .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
        .navigationBarBackButtonHidden(true)
    }

    func passwordStrengthValidation(password: String) -> String {
        if password.count < 6 {
            return "La contraseña debe tener al menos 6 caracteres."
        } else if !password.contains(where: { $0.isNumber }) {
            return "La contraseña debe incluir al menos un número."
        } else if !password.contains(where: { $0.isUppercase }) {
            return "La contraseña debe incluir al menos una letra mayúscula."
        }
        return ""
    }

    func validateEmail(email: String) -> String {
        let emailRegEx = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if email.isEmpty {
            return "El correo electrónico es obligatorio."
        } else if !emailTest.evaluate(with: email) {
            return "El correo electrónico no tiene un formato válido."
        }
        return ""
    }
}

#Preview {
    RegisterView()
}

