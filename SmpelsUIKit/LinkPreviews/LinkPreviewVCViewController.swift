//
//  LinkPreviewVCViewController.swift
//  SmpelsUIKit
//
//  Created by Tal Spektor on 24/01/2021.
//  Copyright © 2021 Tal Spektor. All rights reserved.
//

import LinkPresentation
import UIKit

class LinkPreviewVCViewController: UIViewController, BaseVC {
    var topTitle: String {
        return "\(LinkPreviewVCViewController.self)"
    }
    
    
    let url = "https://google.com/"

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchPreview()
    }
    
    func fetchPreview() {
        guard let url = URL(string: url) else { return }
        let linkView = LPLinkView()
        let provider = LPMetadataProvider()
        provider.startFetchingMetadata(for: url) { [weak self] (metadata, error) in
            guard let data = metadata, error == nil else { return }
            
            DispatchQueue.main.async {
                linkView.metadata = data
                self?.view.addSubview(linkView)
                linkView.frame = CGRect(x: 0, y: 0, width: 250, height: 250)
                linkView.center = self?.view.center ?? .zero
            }
        }
    }
}
