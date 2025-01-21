import FirebaseFirestore

// Definición de la clase FirestoreService que implementa el protocolo FirestoreServiceProtocol
class FirestoreService: FirestoreServiceProtocol {
    
    private let db = Firestore.firestore()
    
    // Método para obtener las transacciones desde Firestore
    func fetchTransactions(completion: @escaping (Result<[Transaction], Error>) -> Void) {
        db.collection("transactions").getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
            } else {
                let transactions = snapshot?.documents.compactMap { doc -> Transaction? in
                    try? doc.data(as: Transaction.self)
                } ?? []
                completion(.success(transactions))
            }
        }
    }

    // Método para agregar una transacción a Firestore
    func addTransaction(transaction: Transaction, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            _ = try db.collection("transactions").addDocument(from: transaction)
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
}

