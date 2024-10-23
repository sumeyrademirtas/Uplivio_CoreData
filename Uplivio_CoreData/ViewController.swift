//
//  ViewController.swift
//  Uplivio_CoreData
//
//  Created by Sümeyra Demirtaş on 10/23/24.
//

import UIKit

class ViewController: UIViewController {
   
    // MARK: - Properties

    // Motivational message label
    let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Loading motivational message..."
        label.textAlignment = .center
        label.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()



    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
//        fetchDailyMotivationMessage()
    }

    // MARK: - Functions



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
                                color2.cgColor
        ]
        
        gradientLayer.startPoint = CGPoint(x: 1, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)

        view.layer.insertSublayer(gradientLayer, at: 0)
    }

}

