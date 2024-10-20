import SwiftUI

struct ContentView: View {
    @AppStorage("hasLaunchedBefore") private var hasLaunchedBefore: Bool = false
    
    var body: some View {
        if !hasLaunchedBefore {
            FirstLaunchView(hasLaunchedBefore: $hasLaunchedBefore)
        } else {
            MainAppView()
        }
    }
}

struct FirstLaunchView: View {
    @Binding var hasLaunchedBefore: Bool
    
    var body: some View {
        VStack {
            WelcomeView() // Add your welcome content here
        }
    }
}

struct MainAppView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
        .accentColor(.blue)
    }
}

#Preview {
    ContentView()
}
