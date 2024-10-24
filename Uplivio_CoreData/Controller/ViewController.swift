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

    // Motivational message label
    let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Loading motivational message..."
        label.textAlignment = .center
        label.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        return label
    }()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        // Kullanıcının dil tercihine göre JSON verisini ViewModel'e yükle
        let currentLanguage = Locale.preferredLanguages.first?.prefix(2) == "tr" ? "tr" : "en"
        viewModel.loadMessages(for: currentLanguage)

        // Güne göre mesajı ekranda göster
        messageLabel.text = viewModel.getMessageForToday()
        messageLabel.alpha = 0.0
    }

    // Animasyonu viewDidAppear'da başlatıyoruz
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fadeInText() // Animasyon burada başlıyor
    }

    // MARK: - Functions

    func fadeInText() {
        // UIView animasyonu ile opacity'yi değiştiriyoruz
        UIView.animate(withDuration: 3.0, // animasyon süresi (2 saniye)
                       delay: 0.0, // animasyon başlamadan önceki bekleme süresi
                       options: .curveEaseIn, // animasyon eğrisi
                       animations: {
                           self.messageLabel.alpha = 1.0 // Opaklığı 1.0'a (tamamen görünür) getiriyoruz
                       }, completion: nil)
    }

    // UI'yi ayarlayan fonksiyon
    func setupUI() {
        // Arka plan rengini gradient ile ayarla
        setGradientBackground()

        // Mesaj Label'ı ekle
        view.addSubview(messageLabel)

        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }

    func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds

        let colors = BackgroundColors.randomTwoColors()
        let color1 = colors.color1
        let color2 = colors.color2

        gradientLayer.colors = [color1.cgColor, UIColor.white.withAlphaComponent(1).cgColor,
                                color2.cgColor]

        gradientLayer.startPoint = CGPoint(x: 1, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)

        view.layer.insertSublayer(gradientLayer, at: 0)
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