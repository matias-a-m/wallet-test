// Definición del protocolo AuthServiceProtocol, que describe los métodos necesarios para la autenticación
protocol AuthServiceProtocol {
    
    // Método para iniciar sesión
    func signIn(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
    
    // Método para registrarse (crear cuenta)
    func signUp(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)

    // Método para cerrar sesión
    func signOut(completion: @escaping (Result<Void, Error>) -> Void)
}
