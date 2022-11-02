//
//  ViewController.swift
//  MapsExample
//
//  Created by PT. ARION INDONESIA on 28/10/22.
//

import UIKit
import GoogleMaps
import GoogleMapsUtils
class ViewController: UIViewController {
    
    @IBOutlet var mySwitch: UISwitch!
    @IBOutlet var resetLocation:UIButton!
    @IBOutlet var markerdata:UIButton!
    @IBOutlet var polylinedata:UIButton!
    @IBOutlet var getAllData:UIButton!
    @IBOutlet var polygondata:UIButton!
    var mapView:GMSMapView!
    @IBOutlet weak var mapSlider: UIView!
    var darkMode:Bool = false
    var state: String = ""
    let label = UILabel()
    var screenEdge: UIScreenEdgePanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        //         Creates a marker in the center of the map.
        
        mapSlider.frame = CGRectMake(self.view.frame.width , self.view.frame.height, -self.view.frame.width * 0.001, -self.view.frame.height)
        
        
        screenEdge = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(ViewController.functionMap(_:)))
        screenEdge.edges = .right
        view.addGestureRecognizer(screenEdge)
        
        
        let camera = GMSCameraPosition.camera(withLatitude: -7.983908, longitude: 112.621391, zoom: 13.0)
        mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.view.insertSubview(mapView, at: 0)
       

//        inisialisasi active button ketika dijalankan
        getAllData.tintColor = .white
        getAllData.backgroundColor = .green


        //        Google Maps style

        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }



        JsonData().getPolygon(mapview: mapView)
        JsonData().getMarker(mapview: mapView)
        JsonData().getPolyline(mapview: mapView, Color: UIColor.blue)
        
        self.view.insertSubview(mySwitch, at: 1)
        
        self.view.insertSubview(mapSlider, at:1)
       
    }
    
    @objc func functionMap(_ data:UIScreenEdgePanGestureRecognizer){
        if data.state == .ended{
            print("Data Masuk Brow")
            mapSlider.frame = CGRectMake(self.view.frame.width , self.view.frame.height, -self.view.frame.width * 0.3, -self.view.frame.height)
        }
        
    }
    
    
    
    @IBAction func switchdidChange(_ sender: UISwitch){
        if sender.isOn{
            
            darkMode = true
            getAllData.backgroundColor = .systemRed.withAlphaComponent(0.2)
            getAllData.tintColor = .systemRed
            markerdata.backgroundColor = .systemRed.withAlphaComponent(0.2)
            markerdata.tintColor = .systemRed
            polygondata.backgroundColor = .systemRed.withAlphaComponent(0.2)
            polygondata.tintColor = .systemRed
            polylinedata.backgroundColor = .systemRed.withAlphaComponent(0.2)
            polylinedata.tintColor = .systemRed
            do {
                // Set the map style by passing the URL of the local file.
                if let styleURL = Bundle.main.url(forResource: "darkStyle", withExtension: "json") {
                    mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
                } else {
                    NSLog("Unable to find darkStyle.json")
                }
                mapView.clear()
                if state == ""{
                    JsonData().getPolygon(mapview: mapView)
                    JsonData().getMarker(mapview: mapView)
                    JsonData().getPolyline(mapview: mapView, Color: UIColor.yellow)
                    getAllData.tintColor =  .black
                    getAllData.backgroundColor = .yellow
                }
                if state == "marker"{
                    JsonData().getMarker(mapview: mapView)
                    markerdata.tintColor =  .black
                    markerdata.backgroundColor = .yellow
                    
                }
                if state == "polyline"{
                    
                    JsonData().getPolyline(mapview: mapView, Color: UIColor.yellow)
                    polylinedata.tintColor =  .black
                    polylinedata.backgroundColor = .yellow
                }
                if state == "polygon"{
                    JsonData().getPolygon(mapview: mapView)
                    polygondata.tintColor =  .black
                    polygondata.backgroundColor = .yellow
                }
                
            } catch {
                NSLog("One or more of the map styles failed to load. \(error)")
            }
        }else{
            darkMode = false
            getAllData.backgroundColor = .systemBlue.withAlphaComponent(0.2)
            getAllData.tintColor = .systemBlue
            markerdata.backgroundColor = .systemBlue.withAlphaComponent(0.2)
            markerdata.tintColor = .systemBlue
            polygondata.backgroundColor = .systemBlue.withAlphaComponent(0.2)
            polygondata.tintColor = .systemBlue
            polylinedata.backgroundColor = .systemBlue.withAlphaComponent(0.2)
            polylinedata.tintColor = .systemBlue
          
            do {
                // Set the map style by passing the URL of the local file.
                if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                    mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
                } else {
                    NSLog("Unable to find style.json")
                }
                mapView.clear()
                if state == ""{
                    JsonData().getPolygon(mapview: mapView)
                    JsonData().getMarker(mapview: mapView)
                    JsonData().getPolyline(mapview: mapView, Color: UIColor.blue)
                    getAllData.tintColor =  .white
                    getAllData.backgroundColor = .green
                }
                if state == "marker"{
                    JsonData().getMarker(mapview: mapView)
                    markerdata.tintColor =  .white
                    markerdata.backgroundColor = .green
                    
                }
                if state == "polyline"{
                    
                    JsonData().getPolyline(mapview: mapView, Color: UIColor.blue)
                    polylinedata.tintColor =  .white
                    polylinedata.backgroundColor = .green
                }
                if state == "polygon"{
                    JsonData().getPolygon(mapview: mapView)
                    polygondata.tintColor =  .white
                    polygondata.backgroundColor = .green
                }
            } catch {
                NSLog("One or more of the map styles failed to load. \(error)")
            }
        
        }
    }
    
    
    @IBAction func resetbutton(_ reset: UIButton){
       if reset.isTouchInside{
           
           mapSlider.frame = CGRectMake(self.view.frame.width , self.view.frame.height, -self.view.frame.width * 0.001, -self.view.frame.height)
           
           let camera = GMSCameraPosition.camera(withLatitude: -7.983908, longitude: 112.621391, zoom: 13.0)
           mapView.camera = camera
           
        }
    }
    
    
    @IBAction func getMarkerButton(_ marker:UIButton){
        state = "marker"
        
        if marker.isTouchInside{
            if darkMode == false{
                getAllData.backgroundColor = .systemBlue.withAlphaComponent(0.2)
                getAllData.tintColor = .systemBlue
                polylinedata.backgroundColor = .systemBlue.withAlphaComponent(0.2)
                polylinedata.tintColor = .systemBlue
                polygondata.backgroundColor = .systemBlue.withAlphaComponent(0.2)
                polygondata.tintColor = .systemBlue
                
                markerdata.backgroundColor = .green
                markerdata.tintColor = .white
                marker.backgroundColor = markerdata.backgroundColor
                marker.tintColor = markerdata.tintColor
                mapView.clear()
                JsonData().getMarker(mapview: mapView)
            }
            
            else{
                getAllData.backgroundColor = .systemRed.withAlphaComponent(0.2)
                getAllData.tintColor = .systemRed
                polylinedata.backgroundColor = .systemRed.withAlphaComponent(0.2)
                polylinedata.tintColor = .systemRed
                polygondata.backgroundColor = .systemRed.withAlphaComponent(0.2)
                polygondata.tintColor = .systemRed
                
                markerdata.backgroundColor = .yellow
                markerdata.tintColor = .black
                
                mapView.clear()
                JsonData().getMarker(mapview: mapView)
                
            }
         
        }
    }
    
    @IBAction func getPolylineButton(_ polyline:UIButton){
        state = "polyline"
        
        if polyline.isTouchInside{
            if darkMode == false{
                getAllData.backgroundColor = .systemBlue.withAlphaComponent(0.2)
                getAllData.tintColor = .systemBlue
                markerdata.backgroundColor = .systemBlue.withAlphaComponent(0.2)
                markerdata.tintColor = .systemBlue
                polygondata.backgroundColor = .systemBlue.withAlphaComponent(0.2)
                polygondata.tintColor = .systemBlue
                
                
                polylinedata.backgroundColor = .green
                polylinedata.tintColor = .white
                
                mapView.clear()
                JsonData().getPolyline(mapview: mapView, Color: .blue)
                
            }else{
                getAllData.backgroundColor = .systemRed.withAlphaComponent(0.2)
                getAllData.tintColor = .systemRed
                markerdata.backgroundColor = .systemRed.withAlphaComponent(0.2)
                markerdata.tintColor = .systemRed
                polygondata.backgroundColor = .systemRed.withAlphaComponent(0.2)
                polygondata.tintColor = .systemRed
                
                
                polylinedata.backgroundColor = .yellow
                polylinedata.tintColor = .black
                
                mapView.clear()
                JsonData().getPolyline(mapview: mapView, Color: .yellow)
                
            }
        }
    }
    
    @IBAction func getPolygonData(_ polygon:UIButton){
        state = "polygon"
        
        if polygon.isTouchInside{
            if darkMode == false{
                getAllData.backgroundColor = .systemBlue.withAlphaComponent(0.2)
                getAllData.tintColor = .systemBlue
                markerdata.backgroundColor = .systemBlue.withAlphaComponent(0.2)
                markerdata.tintColor = .systemBlue
                polylinedata.backgroundColor = .systemBlue.withAlphaComponent(0.2)
                polylinedata.tintColor = .systemBlue
                
                polygon.tintColor =  .white
                polygon.backgroundColor = .green
                
                mapView.clear()
                JsonData().getPolygon(mapview: mapView)
            }else{
                getAllData.backgroundColor = .systemRed.withAlphaComponent(0.2)
                getAllData.tintColor = .systemRed
                markerdata.backgroundColor = .systemRed.withAlphaComponent(0.2)
                markerdata.tintColor = .systemRed
                polylinedata.backgroundColor = .systemRed.withAlphaComponent(0.2)
                polylinedata.tintColor = .systemRed
                
                polygon.tintColor =  .black
                polygon.backgroundColor = .yellow
                
                mapView.clear()
                JsonData().getPolygon(mapview: mapView)
                
            }
        }
    }
    
    @IBAction func getAllDataButton(_ data:UIButton){
        state = ""
        
        if data.isTouchInside{
            if darkMode == false{
                markerdata.backgroundColor = .systemBlue.withAlphaComponent(0.2)
                markerdata.tintColor = .systemBlue
                polylinedata.backgroundColor = .systemBlue.withAlphaComponent(0.2)
                polylinedata.tintColor = .systemBlue
                polygondata.backgroundColor = .systemBlue.withAlphaComponent(0.2)
                polygondata.tintColor = .systemBlue
                
                
                getAllData.tintColor = .white
                getAllData.backgroundColor = .green
                data.tintColor = getAllData.tintColor
                data.backgroundColor = getAllData.backgroundColor
                
                mapView.clear()
                JsonData().getMarker(mapview: mapView)
                JsonData().getPolyline(mapview: mapView, Color: UIColor.blue)
                JsonData().getPolygon(mapview: mapView)
            }else{
                markerdata.backgroundColor = .systemRed.withAlphaComponent(0.2)
                markerdata.tintColor = .systemRed
                polylinedata.backgroundColor = .systemRed.withAlphaComponent(0.2)
                polylinedata.tintColor = .systemRed
                polygondata.backgroundColor = .systemRed.withAlphaComponent(0.2)
                polygondata.tintColor = .systemRed
                
                
                getAllData.tintColor = .black
                getAllData.backgroundColor = .yellow
                data.tintColor = getAllData.tintColor
                data.backgroundColor = getAllData.backgroundColor
                
                mapView.clear()
                JsonData().getMarker(mapview: mapView)
                JsonData().getPolyline(mapview: mapView, Color: UIColor.yellow)
                JsonData().getPolygon(mapview: mapView)
                
            }
           
        }
    }

}




