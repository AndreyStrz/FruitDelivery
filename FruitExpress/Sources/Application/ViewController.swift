//
//  ViewController.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 19.09.2024.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let backgroundImageView = UIImageView(image: UIImage(named: "background"))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.frame = view.bounds
        backgroundImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(backgroundImageView, at: 0)
        
        let loadingLabel = UILabel()
        loadingLabel.text = "Loading..." // у меня не лоадер а кнопка(нужен ли лоадер?)
        loadingLabel.textColor = .yellow
        loadingLabel.font = UIFont(name: "Times New Roman", size: 31)
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
                
        view.addSubview(loadingLabel)
        
        // Создаем и настраиваем индикатор активности
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .yellow
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating() // Запускаем анимацию индикатора
        
        view.addSubview(activityIndicator)
        
        // Устанавливаем Constraints для центрации текста
        NSLayoutConstraint.activate([
            loadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            // Устанавливаем Constraints для индикатора активности ниже текста
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: loadingLabel.bottomAnchor, constant: 20)
        ])
    }

    
    func openApp() {
        DispatchQueue.main.async {
            let viewController = RootViewController.instantiate()
            self.setRootViewController(viewController)
        }
    }
    
    func openWeb(stringURL: String) {
        DispatchQueue.main.async {
            let webView = ADJWebHandler(url: stringURL)
            self.setRootViewController(webView)
        }
    }
    
    func setRootViewController(_ viewController: UIViewController) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController = viewController
        }
    }
    
    func createURL(mainURL: String, deviceID: String, advertiseID: String) -> (String) {
        var url = ""
        
        url = "\(mainURL)?gkty=\(deviceID)&anbt=\(advertiseID)"
        
        return url
    }
}
