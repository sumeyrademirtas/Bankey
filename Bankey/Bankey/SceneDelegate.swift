//
//  SceneDelegate.swift
//  Bankey
//
//  Created by Sümeyra Demirtaş on 26.06.2024.
//

import UIKit

let appColor: UIColor = .systemTeal

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    let loginViewController = LoginViewController()
    let onboardingViewController = OnboardingContainerViewController()
    let mainViewController = MainViewController()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .systemBackground
        //window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        loginViewController.delegate = self
        onboardingViewController.delegate = self
        
        registerForNotifications()
        
        displayLogin()
    }
    
    private func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(didLogout), name: .logout, object: nil)
    }

    private func displayLogin() {
        setRootViewController(loginViewController)
    }

    private func displayNextScreen() {
        if LocalState.hasOnboarded {
            prepMainView()
            setRootViewController(mainViewController)
        } else {
            setRootViewController(onboardingViewController)
        }
    }

    private func prepMainView() {
        mainViewController.setStatusBar()
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = appColor
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}

extension SceneDelegate: LoginViewControllerDelegate {
    func didLogin() {
        displayNextScreen()
    }
}

extension SceneDelegate: OnboardingContainerViewControllerDelegate {
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true
        prepMainView()
        setRootViewController(mainViewController)
    }
}

extension SceneDelegate: LogoutDelegate {
    @objc func didLogout() {
        setRootViewController(loginViewController)
    }
}


extension SceneDelegate {
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }

        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
}
