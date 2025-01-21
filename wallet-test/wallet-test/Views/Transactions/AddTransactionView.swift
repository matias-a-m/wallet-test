import SwiftUI

struct AddTransactionView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: TransactionViewModel
    
    @State private var title = ""
    @State private var amount = ""
    @State private var date = Date()
    @State private var isKeyboardVisible = false
    @State private var showAlert = false
    @State private var errorMessage = ""
    @State private var keyboardHeight: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Crear Transacción")
                    .font(.title)
                    .bold()
                    .foregroundColor(.primary)
                    .padding()
                
                VStack{
                    TextField("Título", text: $title)
                        .padding()
                        .background(Color(white: 0.95))
                        .cornerRadius(12)
                        .padding(.bottom, 12)
                        .shadow(radius: 5)
                        .keyboardType(.default)
                    
                    TextField("Monto", text: $amount)
                        .keyboardType(.decimalPad)
                        .padding()
                        .background(Color(white: 0.95))
                        .cornerRadius(12)
                        .padding(.bottom, 12)
                        .shadow(radius: 5)
                        .onTapGesture {
                            isKeyboardVisible = true
                        }
                    
                    DatePicker("Fecha", selection: $date, displayedComponents: .date)
                        .padding()
                        .background(Color(white: 0.95))
                        .cornerRadius(12)
                        .padding(.bottom, 24)
                        .shadow(radius: 5)
                }
                .padding()
                Spacer()

                Button(action: {
                    saveTransaction()
                }) {
                    Text("Guardar")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .font(.headline)
                        .shadow(radius: 10)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
            }
            .onAppear {
                NotificationCenter.default.addObserver(
                    forName: UIResponder.keyboardWillShowNotification,
                    object: nil,
                    queue: .main
                ) { notification in
                    if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                        keyboardHeight = keyboardFrame.height
                    }
                    withAnimation {
                        isKeyboardVisible = true
                    }
                }
                
                NotificationCenter.default.addObserver(
                    forName: UIResponder.keyboardWillHideNotification,
                    object: nil,
                    queue: .main
                ) { _ in
                    withAnimation {
                        isKeyboardVisible = false
                        keyboardHeight = 0
                    }
                }
            }
            .onDisappear {
                NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
                NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("Aceptar")))
            }
        }
        .background(Color(white: 0.98).edgesIgnoringSafeArea(.all))
        .gesture(
            TapGesture().onEnded {
                dismissKeyboard()
            }
        )
    }
    
    private func saveTransaction() {
        guard !title.isEmpty else {
            errorMessage = "El título es obligatorio."
            showAlert = true
            return
        }
        
        guard let amountValue = Double(amount), amountValue > 0 else {
            errorMessage = "Por favor ingrese un monto válido."
            showAlert = true
            return
        }
        
        let transaction = Transaction(title: title, amount: amountValue, date: date)
        
        viewModel.addTransaction(transaction: transaction) { result in
            if case .success = result {
                dismiss()
            } else {
                errorMessage = "Hubo un error al guardar la transacción."
                showAlert = true
            }
        }
    }
    
    private func dismissKeyboard() {
        UIApplication.shared.endEditing()
    }
}

extension UIApplication {
    func endEditing(_ force: Bool = false) {
        self.windows.first?.endEditing(force)
    }
}

#Preview {
    AddTransactionView(viewModel: TransactionViewModel())
        .preferredColorScheme(.light)
}
