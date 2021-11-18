//
//  FilterViewController.swift
//  CarQuiz
//
//  Created by Ethan Perkins on 11/18/21.
//

import UIKit

protocol FilterSelectionDelegate: class {
    func selected(type: String)
}

class FilterViewController: UIViewController {

    weak var delegate: FilterSelectionDelegate?
    
    @IBAction func superCarButtonTapped(_ sender: Any) {
        delegate?.selected(type: "superCar")
        self.dismiss(animated: true)
    }
    
    @IBAction func americanCarButtonTapped(_ sender: Any) {
        delegate?.selected(type: "americanCar")
        self.dismiss(animated: true)
    }
    
    
}
