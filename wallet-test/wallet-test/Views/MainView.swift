import SwiftUI

struct MainView: View {
    @StateObject var viewModel = TransactionViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("Bienvenido a la aplicación")
                        .font(.title)
                        .bold()
                        .padding()
                    
                    Spacer()
                    
                    List(viewModel.transactions) { transaction in
                        TransactionRowView(transaction: transaction)
                    }

                    NavigationLink(destination: AddTransactionView(viewModel: viewModel)) {
                        Text("Añadir Transacción")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 20)
                    
                    Button(action: {
                        authViewModel.signOut()
                    }) {
                        Text("Cerrar sesión")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 20)
                }
                .padding()
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}


#Preview {
    MainView()
        .environmentObject(AuthViewModel())
}
