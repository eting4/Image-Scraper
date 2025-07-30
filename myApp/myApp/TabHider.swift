import SwiftUI

struct HideTabBar: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let vc = UIViewController()
        vc.hidesBottomBarWhenPushed = true
        return vc
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
