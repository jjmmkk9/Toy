//
//  UIViewController.swift
//  Toy
//
//  Created by 비긴어브랜드 on 1/23/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var countLabel: UILabel!
    var count: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func incrementCount(_ sender: UIButton) {
        count += 1
        countLabel.text = "Count: \(count)"
    }
}
