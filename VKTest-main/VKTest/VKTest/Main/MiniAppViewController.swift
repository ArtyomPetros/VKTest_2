import UIKit

class MainViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupScrollView()
        setupStackView()
        addViewControllers()
    }

    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupStackView() {
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }

    private func addViewControllers() {
       
        let locationVC = LocationViewController()
        addChild(locationVC)
        stackView.addArrangedSubview(locationVC.view)
        locationVC.didMove(toParent: self)
        
       
        locationVC.view.heightAnchor.constraint(equalToConstant: 50).isActive = true

       
        let xoVC = XO()
        addChild(xoVC)
        stackView.addArrangedSubview(xoVC.view)
        xoVC.didMove(toParent: self)
        
        
        xoVC.view.heightAnchor.constraint(equalToConstant: 350).isActive = true

       
        let notesVC = NotesViewController()
        addChild(notesVC)
        stackView.addArrangedSubview(notesVC.view)
        notesVC.didMove(toParent: self)
        
        
        notesVC.view.heightAnchor.constraint(equalToConstant: 500).isActive = true
    }
}
