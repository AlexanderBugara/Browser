//
//  SceneDelegate.swift
//  Browser App
//
//  Created by Oleksandr Buhara on 7/21/23.
//

import UIKit
import Browser_Lib

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let navigator = UINavigationController()
        window?.rootViewController = navigator
        window?.makeKeyAndVisible()

        let token = ""
        let client = BrowserLibClient.shared(session: UserSession(token: token))

        let state = ContainerNetworkLoadingState(client: client)
        let containerViewController = ContainerViewController(initState: state)
        navigator.show(containerViewController, sender: nil)
    }

}

