import FirebaseAuth

// Definición de la clase AuthService que implementa el protocolo AuthServiceProtocol
class AuthService: AuthServiceProtocol {
    
    static let shared = AuthService()

    private init() {}

    // Método para iniciar sesión
    func signIn(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    // Método para registrarse
    func signUp(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func signOut(completion: @escaping (Result<Void, Error>) -> Void) {
         do {
             try Auth.auth().signOut()
             completion(.success(()))
         } catch let error {
             completion(.failure(error)) 
         }
     }
 

}

