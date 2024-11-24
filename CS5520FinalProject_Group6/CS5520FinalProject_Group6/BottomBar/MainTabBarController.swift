//
//  MainTabBarController.swift
//  CS5520FinalProject_Group6
//
//  Created by Jiali Han on 11/19/24.
//  Implemented the bottom bar that can navigates to different screens.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        // Create view controllers for each tab
        let profileVC = ProfileViewController()
        //let quizVC = TestSelectionViewController()
        let homepageVC = HomeViewController()
        let resultsVC = SummaryViewController()
        
        // Wrap each view controller in a navigation controller
        let profileNav = UINavigationController(rootViewController: profileVC)
        let quizNav = UINavigationController(rootViewController: homepageVC)
        let resultsNav = UINavigationController(rootViewController: resultsVC)
        
        // Assign tab bar items
        profileNav.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 0)
        quizNav.tabBarItem = UITabBarItem(title: "Quiz", image: UIImage(systemName: "questionmark.circle"), tag: 1)
        resultsNav.tabBarItem = UITabBarItem(title: "Results", image: UIImage(systemName: "chart.bar"), tag: 2)
        
        // Set the view controllers of the tab bar
        self.viewControllers = [profileNav, quizNav, resultsNav]
        
        // Customize appearance
        //customizeTabBarAppearance()
        // Customize appearance if needed
        tabBar.tintColor = .blue
        tabBar.backgroundColor = .white
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let navController = viewController as? UINavigationController,
           /*
            let resultsVC = navController.viewControllers.first as? SummaryViewController {
                        resultsVC.fetchTestRecords() // Refresh test records when "Results" tab is selected
                    }
            */
           let homepageVC = navController.viewControllers.first as? HomeViewController {
            navController.popToRootViewController(animated: false)
        }
    }
    
    private func customizeTabBarAppearance() {
        // Create an instance of UITabBarAppearance
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        // Set the background color dynamically from Assets
        appearance.backgroundColor = UIColor(named: "PrimaryColor")// Automatically adapts to light/dark mode
        
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(named: "TabItemSelected")
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor(named: "TabItemSelected") ?? .blue
        ]
        
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(named: "TabItemUnselected")
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor(named: "TabItemUnselected") ?? .gray
        ]
        // Apply appearance to the tab bar
        tabBar.standardAppearance = appearance
        
        // For iOS 15+, apply scrollEdgeAppearance as well
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }
}
