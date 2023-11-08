//
//  ViewController.swift
//  DEACProgressCard
//
//  Created by 12740181 on 11/03/2023.
//  Copyright (c) 2023 12740181. All rights reserved.
//

import UIKit
import DEACProgressCard

class ViewController: UIViewController {
    
    let progressCardImageView = DEACProgressCardImageView(frame: CGRect(x: 100, y: 100, width: 180, height: 180))

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(progressCardImageView)
        progressCardImageView.cardImage = "card.jpeg"
        progressCardImageView.totaldurationSecond = 30
        progressCardImageView.movingBlockColor = UIColor.red
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

