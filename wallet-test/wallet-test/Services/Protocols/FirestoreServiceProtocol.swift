// Definición del protocolo FirestoreServiceProtocol, que describe los métodos necesarios para interactuar con Firestore
protocol FirestoreServiceProtocol {
    
    // Método para obtener las transacciones desde Firestore
    func fetchTransactions(completion: @escaping (Result<[Transaction], Error>) -> Void)
    
    // Método para agregar una transacción a Firestore
    func addTransaction(transaction: Transaction, completion: @escaping (Result<Void, Error>) -> Void)
}

