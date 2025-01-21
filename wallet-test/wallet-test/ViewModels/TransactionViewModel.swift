import Foundation

final class TransactionViewModel: ObservableObject {
    
    @Published var transactions: [Transaction] = []
    @Published var errorMessage: String?
    
    private let service: FirestoreServiceProtocol

    init(service: FirestoreServiceProtocol = FirestoreService()) {
        self.service = service
    }
    
      func addTransaction(transaction: Transaction, completion: @escaping (Result<Void, Error>) -> Void) {
          transactions.append(transaction)
          completion(.success(()))
      }
        func loadTransactions() {
        service.fetchTransactions { [weak self] result in
    
            switch result {
            case .success(let transactions):
                DispatchQueue.main.async {
                    self?.transactions = transactions
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
