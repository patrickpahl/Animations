import UIKit

class AnimatedTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let carCell = "CarTableViewCell"

    @IBOutlet weak var tableView: UITableView!

    let categories = ["Porsche", "VW", "Alfa Romeo", "Honda", "Ford", "Tesla", "Chevrolet", "Jeep", "Nissan", "BMW", "Mercedes", "Rolls Royce", "Ferrari", "Acura", "Lexus", "Triumph", "Opel"]

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: carCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: carCell)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .black
        tableView.separatorColor = .black
        tableView.separatorInset = .zero
        animateTableView()
        let slideInBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(slideInAnimation))
        navigationItem.rightBarButtonItem = slideInBarButtonItem
    }

    func animateTableView() {
        tableView.reloadData()
        let visableCells = tableView.visibleCells
        let tableViewHeight = tableView.bounds.size.height
        // Getting the height so we can keep all the cells off the screen and then move them in
        for cell in visableCells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
            // Moving the cells down the height of the tableView
        }

        // Now we are moving up each cell after the other using the delay
        var delayCounter = 0
        for cell in visableCells {
            UIView.animate(withDuration: 2, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                cell.transform = CGAffineTransform.identity
                // Setting cell back to it's identity, original form
            }, completion: nil)
            delayCounter += 1
        }
    }

    @objc func slideInAnimation() {
        tableView.reloadData()
        let visableCells = tableView.visibleCells
        let tableViewWidth = tableView.bounds.size.width
        // Getting the height so we can keep all the cells off the screen and then move them in
        for cell in visableCells {
            cell.transform = CGAffineTransform(translationX: tableViewWidth, y: 0)
            // Moving the cells down the height of the tableView
        }

        // Now we are moving up each cell after the other using the delay
        var delayCounter = 0
        for cell in visableCells {
            UIView.animate(withDuration: 1, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 10, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                cell.transform = CGAffineTransform.identity
                // Setting cell back to it's identity, original form
            }, completion: nil)
            delayCounter += 1
        }
    }

    // TableView

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: carCell, for: indexPath) as? CarTableViewCell else { return UITableViewCell() }

        let sortedCategories = categories.sorted(by: { $0 < $1 })
        let category = sortedCategories[indexPath.row]
        cell.carLabel.text = category
        return cell
    }

}
