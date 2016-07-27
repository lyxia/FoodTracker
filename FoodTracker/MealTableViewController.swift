//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by lyxia on 2016/7/26.
//  Copyright © 2016年 lyxia. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {
    
    //MARK: Properties
    var meals = [Meal]()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = editButtonItem()
        
        if let loadMeals = loadMealsData() {
            meals = loadMeals
        } else {
            //setup sample data
            loadSampleMeals()
        }
    }
    
    func loadSampleMeals() {
        let photo1 = UIImage(named: "meal1")
        let meal1 = Meal(name: "Caprese Salad", photo: photo1, rating:4)
        
        let photo2 = UIImage(named: "meal2")
        let meal2 = Meal(name: "Chicken and Potatoes", photo: photo2, rating:5)
        
        let photo3 = UIImage(named: "meal3")
        let meal3 = Meal(name: "Pasta with Meatballs", photo: photo3, rating:3)
        
        self.meals += [meal1!, meal2!, meal3!]
        saveMealsData()
    }
    
    func loadMealsData() -> [Meal]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Meal.FilePath) as? [Meal]
    }
    
    func saveMealsData() {
        if NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.FilePath) {
            print("save meals data success!")
        } else {
            print("failed to save meals date!")
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }

    let cellIdentifier = "MealTableViewCell"
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MealTableViewCell

        let meal = meals[indexPath.row]
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            meals.remove(at: indexPath.row)
            saveMealsData()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // MARK: Segue
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? ViewController, let meal = sourceViewController.meal {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                meals[selectedIndexPath.row] = meal
                saveMealsData()
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                let newIndexPath = IndexPath(item: meals.count, section: 0)
                meals.append(meal)
                saveMealsData()
                tableView.insertRows(at: [newIndexPath], with: .bottom)
            }
        }
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let mealDetailViewController = segue.destinationViewController as! ViewController
            if let selectedMealCell = sender as? MealTableViewCell {
                let indexPath:NSIndexPath! = tableView.indexPath(for: selectedMealCell)
                let selectedMeal = meals[(indexPath.row)]
                mealDetailViewController.meal = selectedMeal
            }
        } else if segue.identifier == "AddItem" {
            
        }
    }

}
