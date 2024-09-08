import UIKit
import CoreLocation

class LocationViewController: UIViewController, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    private let locationLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLocationManager()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.textAlignment = .left
        locationLabel.font = UIFont.boldSystemFont(ofSize: 18) // Уменьшенный размер шрифта
        locationLabel.textColor = .black
        locationLabel.numberOfLines = 0 // Поддержка многострочного текста
        view.addSubview(locationLabel)
        
        // Ограничиваем зону отображения
        NSLayoutConstraint.activate([
            locationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20), // Ограничение по ширине
            locationLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 50) // Фиксированная высота
        ])
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        } else {
            locationLabel.text = "Location services are disabled"
        }
    }
    
    // MARK: - CLLocationManagerDelegate Methods
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            if let error = error {
                print("Geocoding error: \(error)")
                self?.locationLabel.text = "Failed to determine location"
                return
            }
            
            if let placemark = placemarks?.first, let city = placemark.locality {
                self?.locationLabel.text = "Город: \(city)"
            } else {
                self?.locationLabel.text = "Failed to determine city"
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Manager error: \(error)")
        locationLabel.text = "Failed to determine location"
    }
}
