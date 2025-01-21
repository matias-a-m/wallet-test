import SwiftUI

struct TransactionRowView: View {
    let transaction: Transaction
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(transaction.title)
                    .font(.headline)
                Text(transaction.date, style: .date)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            
            Text("$\(transaction.amount, specifier: "%.2f")")
                .font(.body) // Estilo estándar
                .foregroundColor(transaction.amount < 0 ? .red : .green)
        }
        .padding()
    }
}

#Preview {
    TransactionRowView(transaction: Transaction(title: "Compra en supermercado", amount: -50.75, date: Date()))
        .preferredColorScheme(.light) 
}
