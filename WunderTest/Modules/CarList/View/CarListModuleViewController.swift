import UIKit

class CarListModuleViewController: UIViewController {
    
    var presenter: CarListModulePresenter!
    
    @IBOutlet weak var tableView: UITableView!
    
    private let tableViewCellReuseId = String(describing: CarListTableViewCell.self)
    
    var cars: [CarListViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
        
        presenter.viewDidLoad()
    }
    
    func initTableView() {
        let tableViewCellNib = UINib(nibName: tableViewCellReuseId, bundle: .main)
        tableView.register(tableViewCellNib, forCellReuseIdentifier: tableViewCellReuseId)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

extension CarListModuleViewController: CarListModuleView {
    func showCars(_ cars: [CarListViewModel]) {
        self.cars = cars
        tableView.reloadData()
    }
}

extension CarListModuleViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellReuseId) as! CarListTableViewCell
        cell.configureWith(cars[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(CarListModuleConstants.tableCellHeight)
    }
}

extension CarListModuleViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(cars[indexPath.item])
    }
}
