import SwiftUI
import FirebaseCore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        if let _ = Auth.auth().currentUser {
            // El usuario está autenticado, por lo que no es necesario iniciar sesión
            // Puedes manejar el redireccionamiento a la vista principal aquí
        }
        
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Puedes agregar lógica aquí si quieres hacer algo cuando la app entre en segundo plano
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        if let _ = Auth.auth().currentUser {
            // El usuario sigue autenticado
        }
    }
}
