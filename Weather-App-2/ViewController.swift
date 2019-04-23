//
//  ViewController.swift
//  Weather-App-2
//
//  Created by mitchell hudson on 11/12/15.
//  Copyright © 2015 mitchell hudson. All rights reserved.
//

//  Last Update 020516

// TODO: Save weather location in NSUserDefaults
// TODO: Add SMS
// TODO: Add email
// TODO: Tweet Weather
// TODO: Email Image of Weather

// Get location for weather

import UIKit
import Social
import CoreLocation // 1 import CoreLocation

// 4 Add Persmission Keys to info plist
// “NSLocationWhenInUseUsageDescription” or “NSLocationAlwaysUsageDescription”

// 2 Add the delegate protocol
class ViewController: UIViewController,
    CLLocationManagerDelegate,
    UIImagePickerControllerDelegate, // For image picker
    UINavigationControllerDelegate {   // For image picker
    
    // 3 Make a location manager
    let locationManager = CLLocationManager()
    // Make an instance of WeatherService with your OpenWeatherMap ID.
    var weatherService: WeatherServiceInterface = WeatherService()
    var weather: Weather?
    
    
    // MARK: IBOutlets
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var cityButton: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialLayout()
        self.weatherService.delegate = self
        
        // 5 Set delegate and authorization
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func initialLayout() {
        self.descriptionLabel.isHidden = true
        self.iconImageView.isHidden = true
        self.tempLabel.isHidden = true
        self.humidityLabel.isHidden = true
        self.windLabel.isHidden = true
        self.cityButton.isHidden = false
        self.cityButton.setTitle("Press to enter a city", for: .normal)
    }
    
    private func nonInitialLayout() {
        self.descriptionLabel.isHidden = false
        self.iconImageView.isHidden = false
        self.tempLabel.isHidden = false
        self.humidityLabel.isHidden = false
        self.windLabel.isHidden = false
        self.cityButton.isHidden = false
    }
    
    // MARK: IBActions
    
    // -- City Button
    
    /** Handles taps on the City button */
    
    @IBAction func cityButtonTapped(sender: UIButton) {
        print("City button")
        openSetWeatherAlert()
    }
    
    
    
    /** This method opens an alert dialog and asks for the city name, or location. */
    
    func openSetWeatherAlert() {
        let alert = UIAlertController(title: "Get Weather", message: "Enter City, or use your location!", preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let ok = UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction) -> Void in
            let textField = alert.textFields![0]
            let cityText = textField.text!
            self.weatherService.getWeather(for: cityText)
        }
        
        let location = UIAlertAction(title: "Use Location", style: .default) { (action: UIAlertAction) -> Void in
            //
            self.getGPSLocation()
        }
        
        alert.addTextField { (textField: UITextField) -> Void in
            textField.placeholder = "City Name, Country"
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        alert.addAction(location)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // -- Photo Button
    /** Opens the photo picker */
    @IBAction func photoButtonTapped(sender: AnyObject) {
        self.openPhotoPicker()
    }
    
    /** Open a photo picker to add an image or take a photo */
    func openPhotoPicker() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .camera
        self.present(picker, animated: true, completion: nil)
    }
    
    /** Handles results from the photopicker. */
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.backgroundImageView.image = image
        self.dismiss(animated: true, completion: nil)
    }
    
    /** Use this button to share the weather on Twitter, Email, or SMS */
    @IBAction func shareButtonTapped(sender: AnyObject) {
        // open sharing alert
        // Tweet
        // Email
        // SMS
        openSharingAlert()
    }
    
    /** Opens an Actionsheet with sharing options. */
    func openSharingAlert() {
        let alert = UIAlertController(title: "Share the Weather", message: "", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let tweet = UIAlertAction(title: "Tweet", style: .default) { (action: UIAlertAction) -> Void in
            //
            self.tweetWeather()
        }
        let email = UIAlertAction(title: "Email", style: .default) { (action:UIAlertAction) -> Void in
            // 
            self.emailWeather()
        }
        let sms = UIAlertAction(title: "SMS", style: .default) { (action: UIAlertAction) -> Void in
            // 
            self.smsWeather()
        }
        
        alert.addAction(cancel)
        alert.addAction(tweet)
        alert.addAction(email)
        alert.addAction(sms)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    /** Use this method to Tweet the weather. */
    func tweetWeather() {
        print("Tweet the Weather")
        // TODO: Format weather for Tweet
        // TODO: Send Tweet
        // TODO: Make Screenshot
    }
    
    /** Use this method to Email the weather. */
    func emailWeather() {
        print("Email the Weather")
        // TODO: Format attributed text for email
        // TODO: Send Email
        // TODO: Get screenshot
    }
    
    /** Use this method to test message the weather. */
    func smsWeather() {
        print("SMS the Weather")
        // TOOD: Format weather as message 
        // TODO: Send message
    }
    
    
    
    
    // MARK: Location 
    /** Get the GPS location.  */
    func getGPSLocation() {
        print("Starting location Manager")
        locationManager.startUpdatingLocation()
    }
    
    // 6 Add delegate methods
    /** Handles callback from location manager. */
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        // Get weather for location
        print("Did update To Location")
        print(newLocation)
        locationManager.stopUpdatingLocation()
    }
    
    /** Handles location updates. Use this to get the weather for the current location. */
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Did update locations")
        print(locations)
        self.weatherService.getWeather(for: locations[0])
        locationManager.stopUpdatingLocation()
    }
    
    /** Handle error messages from the location manager. */
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("location error \(error) \(error.userInfo)")
    }
    
    
}



extension ViewController: WeatherServiceDelegate {
    
    /// If weather service request success will return.
    ///
    /// - Parameter weather: weather data be structed by ourself from "openweathermap.org"
    func setWeather(weather: Weather) {
        self.descriptionLabel.text  = weather.description
        self.tempLabel.text         = String(format: "%.1f˚", weather.tempF)
        self.humidityLabel.text     = String(format: "Humidity: %.0f%", weather.humidity)
        self.windLabel.text         = String(format: "Wind: %.0fmph", weather.windSpeed)
        self.iconImageView.image = UIImage(named: weather.icon)
        self.cityButton.setTitle(weather.cityName, for: .normal)
        self.weather = weather
        self.nonInitialLayout()
    }
    
    /// Handles error message from Weather Service instance.
    ///
    /// - Parameter message: error message sent from WeatherSerivce
    func weatherErrorWithMessage(message: String) {
        self.basicAlert(title: "Weather Service Error", message: message)
    }
    
}

