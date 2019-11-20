//
//  ViewController.swift
//  GoogleMapsSwiftDemo
//
//  Created by shiga on 19/11/19.
//  Copyright © 2019 Shigas. All rights reserved.
//

import UIKit
import GooglePlaces
import MapKit

// https://medium.com/better-programming/easy-google-maps-setup-tutorial-swift-4-f6d5c093817e

class ViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    var resultsViewController:GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupSearchController()
    }

    func setupSearchController()  {
        self.resultsViewController = GMSAutocompleteResultsViewController()
        self.resultsViewController?.delegate = self

        self.searchController = UISearchController(searchResultsController: resultsViewController)
        self.searchController?.searchResultsUpdater = resultsViewController
        
        let searcBar = searchController?.searchBar
        searcBar?.sizeToFit()
        searcBar?.placeholder = "search for places"
        navigationItem.titleView = searchController?.searchBar
        definesPresentationContext = true
        searchController?.hidesNavigationBarDuringPresentation = false
        
    }

}


extension ViewController:GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didAutocompleteWith place: GMSPlace) {
        
        // 1
           searchController?.isActive = false

           // 2
           mapView.removeAnnotations(mapView.annotations)

           // 3
           let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
           let region = MKCoordinateRegion(center: place.coordinate, span: span)
           mapView.setRegion(region, animated: true)

           // 4
           let annotation = MKPointAnnotation()
           annotation.coordinate = place.coordinate
           annotation.title = place.name
           annotation.subtitle = place.formattedAddress
           mapView.addAnnotation(annotation)
        
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didFailAutocompleteWithError error: Error) {
        
        print("Error: \(error.localizedDescription)")

        
    }
    
    
}
