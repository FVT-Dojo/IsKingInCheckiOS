import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    var configuration: [String: String] = [:]

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        parseArguments()
        
        // Example usage
        if let environment = configuration["environment"] {
            print("App launched in \(environment) mode")
        }
        
        return true
    }
    
    private func parseArguments() {
        let arguments = ProcessInfo.processInfo.arguments
        
        for i in 0..<arguments.count {
            let argument = arguments[i]
            
            if argument.hasPrefix("--") {
                let key = String(argument.dropFirst(2))
                
                // Check if next value is not another argument (which would start with "--")
                if i + 1 < arguments.count, !arguments[i + 1].hasPrefix("--") {
                    let value = arguments[i + 1]
                    configuration[key] = value
                } else {
                    // Handle flags that don't have following values or mark as true/false
                    configuration[key] = "true"
                }
            }
        }
    }
}
