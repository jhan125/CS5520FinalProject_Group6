//
//  AppDelegate.swift
//  CS5520FinalProject_Group6
//
//  Created by NIKITA LIANG on 11/18/24.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseCore
import CoreData // Import CoreData framework

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Core Data Persistent Container
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model") // Replace with your Core Data file name
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    
    // MARK: - Save Core Data Context
//    func saveContext() {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
    
    func saveContext() {
            let context = persistentContainer.viewContext
            context.perform {
                if context.hasChanges {
                    do {
                        try context.save()
                        print("Core Data context saved successfully")
                    } catch {
                        let nserror = error as NSError
                        print("Failed to save Core Data context: \(nserror), \(nserror.userInfo)")
                        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                    }
                }
            }
        }
    
    // MARK: - App Lifecycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Firebase configuration
        FirebaseApp.configure()
        print("Firebase configured successfully")

        do {
            let settings = FirestoreSettings()
            settings.isPersistenceEnabled = false // Disable offline caching
            Firestore.firestore().settings = settings
            print("Firestore settings configured successfully")
        } catch {
            print("Error configuring Firestore: \(error.localizedDescription)")
        }
        
        if FirebaseApp.app() == nil {
            print("Firebase is not properly configured")
        } else {
            print("Firebase is properly configured")
        }

        
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
}

