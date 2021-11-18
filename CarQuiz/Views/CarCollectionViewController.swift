//
//  CarCollectionCollectionViewController.swift
//  CarQuiz
//
//  Created by Ethan Perkins on 11/18/21.
//

import UIKit



class CarCollectionCollectionViewController: UICollectionViewController {
    
    private var displayedCars: [Car] = []
    private var targetedCar: Car?
    private var selectedType = "superCar"

    override func viewDidLoad() {
        super.viewDidLoad()
        shuffleCars(for: selectedType)

    }
    
    func shuffleCars(for type: String) {
        if type == "superCar" {
            let superCarGroup = CarController.superCar.prefix(3)
            displayedCars = Array(superCarGroup)
            targetedCar = CarController.superCar.randomElement()
        } else if type == "americanCar" {
            let americanCarGroup = CarController.americanCar.prefix(3)
            displayedCars = Array(americanCarGroup)
            targetedCar = CarController.americanCar.randomElement()
        }
        updateViews()
    }
    
    func updateViews() {
        guard let car = targetedCar else { return }
        displayedCars.append(car)
        collectionView.reloadData()
        title = "Find the \(car.make) \(car.model)"
    }
    
    func presentAlert(for car: Car) {
        let success = car == targetedCar
        let alertController = UIAlertController(title: success ? "Good Job!" : "You suck!", message: nil, preferredStyle: .alert)
        
        let doneAction = UIAlertAction(title: "Done", style: .cancel)
        let shuffleAction = UIAlertAction(title: "Shuffle!", style: .default) { _ in
            self.shuffleCars(for: self.selectedType)
        }
        
        alertController.addAction(doneAction)
        
        if success {
            alertController.addAction(shuffleAction)
        }
        
        present(alertController, animated: true)
    }

    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "filterVC" {
            let vc = segue.destination as? FilterViewController
            vc?.delegate = self
        }
      
        
    }


    // MARK: UICollectionViewDataSource




    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return displayedCars.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "carCell", for: indexPath) as? CarCollectionViewCell else { return UICollectionViewCell() }
    
        let car = displayedCars[indexPath.row]
        cell.displayImage(for: car)
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let car = displayedCars[indexPath.row]
        
        presentAlert(for: car)
    }

}

extension CarCollectionCollectionViewController: FilterSelectionDelegate {
    func selected(type: String) {
        selectedType = type
        shuffleCars(for: selectedType)
    }
    
    
}
