//
//  ViewController.swift
//  Uplivio_CoreData
//
//  Created by Sümeyra Demirtaş on 10/23/24.
//

import SwiftUI
import UIKit

class ViewController: UIViewController {
    // MARK: - Properties

    // ViewModel'den veri çeken property
    let viewModel = MessageViewModel()
    let messageView = MessageView()


    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view = messageView

        // Kullanıcının dil tercihine göre JSON verisini ViewModel'e yükle
        let currentLanguage = Locale.preferredLanguages.first?.prefix(2) == "tr" ? "tr" : "en"
        viewModel.loadMessages(for: currentLanguage)

        // Güne göre mesajı ekranda göster
        messageView.messageLabel.text = viewModel.getMessageForToday()
        messageView.messageLabel.alpha = 0.0
        
        updateMessageLabel()
    }

    // Animasyonu viewDidAppear'da başlatıyoruz
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        messageView.fadeInText()
    }

    // MARK: - Functions

    private func updateMessageLabel() {
        messageView.messageLabel.text = viewModel.getMessageForToday()
    }
 

    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}

#if DEBUG
import SwiftUI

// SwiftUI Preview için gerekli olan yapı
struct ViewController_Preview: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview().edgesIgnoringSafeArea(.all)
    }

    struct ViewControllerPreview: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> ViewController {
            return ViewController()
        }

        func updateUIViewController(_ uiViewController: ViewController, context: Context) {}
    }
}
#endif
