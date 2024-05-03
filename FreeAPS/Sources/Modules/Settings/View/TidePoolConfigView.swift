import Foundation
import LoopKit
import LoopKitUI
import SwiftUI

struct TidePoolSetupView: UIViewControllerRepresentable {
    let serviceUIType: ServiceUI.Type
    let pluginHost: PluginHost
    let serviceOnBoardDelegate: ServiceOnboardingDelegate
    let serviceDelegate: CompletionDelegate

    func makeUIViewController(context _: UIViewControllerRepresentableContext<TidePoolSetupView>) -> UIViewController {
        let result = serviceUIType.setupViewController(
            colorPalette: .default,
            pluginHost: pluginHost
        )
        switch result {
        case let .createdAndOnboarded(serviceUI):
            serviceOnBoardDelegate.serviceOnboarding(didCreateService: serviceUI)
            serviceOnBoardDelegate.serviceOnboarding(didOnboardService: serviceUI)
            return UIViewController()
        case var .userInteractionRequired(setupViewControllerUI):
            setupViewControllerUI.serviceOnboardingDelegate = serviceOnBoardDelegate
            setupViewControllerUI.completionDelegate = serviceDelegate
            return setupViewControllerUI
        }
    }

    func updateUIViewController(_: UIViewController, context _: UIViewControllerRepresentableContext<TidePoolSetupView>) {}
}

struct TidePoolSettingsView: UIViewControllerRepresentable {
    let serviceUI: ServiceUI
    let serviceOnBoardDelegate: ServiceOnboardingDelegate
    let serviceDelegate: CompletionDelegate?

    func makeUIViewController(context _: UIViewControllerRepresentableContext<TidePoolSettingsView>) -> UIViewController {
        var vc = serviceUI.settingsViewController(colorPalette: .default)
        vc.completionDelegate = serviceDelegate
        vc.serviceOnboardingDelegate = serviceOnBoardDelegate
        return vc
    }

    func updateUIViewController(_: UIViewController, context _: UIViewControllerRepresentableContext<TidePoolSettingsView>) {}
}
