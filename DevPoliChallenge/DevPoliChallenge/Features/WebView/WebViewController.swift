//
//  WebViewController.swift
//  DevPoliChallenge-MeuPerfil
//
//  Created by Jessica Serqueira on 14/09/23.
//  Copyright © 2023 DevPoli. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var webURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
    }
    
    func setupWebView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        
        webView.allowsBackForwardNavigationGestures = true
        webView.translatesAutoresizingMaskIntoConstraints = true
        
        if let webURL = webURL {
            webView.load(URLRequest(url: webURL))
        }
        
        let backButton = UIBarButtonItem(
            image: UIImage(named: "left"),
            style: .plain,
            target: self,
            action: #selector(webViewBackButtonTapped)
        )
        navigationItem.leftBarButtonItem = backButton
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc func webViewBackButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
