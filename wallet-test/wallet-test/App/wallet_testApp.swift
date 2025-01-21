import SwiftUI
import Firebase

@main
struct wallet_testApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var authViewModel = AuthViewModel()

    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            NavigationView {
                // Si el usuario está autenticado, navega a la vista principal
                if authViewModel.isAuthenticated {
                    MainView()
                        .navigationBarBackButtonHidden(true)
                        .environmentObject(authViewModel)  
                } else {
                    LoginView()
                        .environmentObject(authViewModel)
                }
            }
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .background {
                    authViewModel.checkSessionExpiration()
                }
            }
        }
    }
}
