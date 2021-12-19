
//
//  WeatherVC.swift
//  WeatherForecast
//
//  Created by Hoang Le on 16/12/2021.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private var presenter: WeatherPresenter!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var titleLabel: UILabel!
    var forecasts = [Forecast]()
    private var inputTimer: Timer?
    private var searchText = ""
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 160
        //forecast = Forecast()
        self.searchBar.delegate = self
        presenter = WeatherPresenter(viewable: self, service: WeatherService())
        applyAccessibility()
    }
    
    @objc func fetchWeather() {
        presenter.searchWeather(searchText)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherCell {
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        } else {
            return WeatherCell()
        }
    }
}

extension WeatherVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        inputTimer?.invalidate()
        inputTimer = nil
        let searchText = searchText.trimmingCharacters(in: .whitespaces)
        if searchText.count >= 3 {
            self.tableView.setLoading(visible: true)
        } else {
            self.tableView.setLoading(visible: false)
        }
        inputTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fetchWeather), userInfo: nil, repeats: false)
    }
}

extension WeatherVC: WeatherViewable {
    func updateMainUI(forecasts: [Forecast]) {
        self.forecasts = forecasts
        tableView.reloadData()
        self.tableView.setLoading(visible: false)
    }
}

extension WeatherVC {
    func applyAccessibility() {
        titleLabel.isAccessibilityElement = true
        titleLabel.accessibilityTraits = UIAccessibilityTraits.none
        titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        titleLabel.adjustsFontForContentSizeCategory = true
        
        searchBar.isAccessibilityElement = true
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.adjustsFontForContentSizeCategory = true
        }
    }
}
