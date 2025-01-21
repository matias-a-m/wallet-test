import SwiftUI
import FirebaseAuth
import Combine

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var errorMessage: String?
    
    private let authService: AuthServiceProtocol
    
    init(authService: AuthServiceProtocol = AuthService.shared) {
        self.authService = authService
        
        // Revisar si el usuario ya está autenticado
        if let _ = Auth.auth().currentUser {
            isAuthenticated = true
        } else {
            isAuthenticated = false
        }

        NotificationCenter.default.addObserver(self, selector: #selector(checkSessionExpiration), name: .sessionExpirationCheck, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .sessionExpirationCheck, object: nil)
    }

    func signIn(email: String, password: String) {
        authService.signIn(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.isAuthenticated = true
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func signUp(email: String, password: String) {
        authService.signUp(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.isAuthenticated = true
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func signOut() {
        authService.signOut { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.isAuthenticated = false
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    @objc func checkSessionExpiration() {
        if let lastLoginTime = UserDefaults.standard.object(forKey: "lastLoginTime") as? Date {
            let currentTime = Date()
            let elapsedTime = currentTime.timeIntervalSince(lastLoginTime)
            
            if elapsedTime > 3600 { // 1 hora de sesión expirada
                signOut()
            }
        }
    }
}


extension Notification.Name {
    static let sessionExpirationCheck = Notification.Name("sessionExpirationCheck")
}
