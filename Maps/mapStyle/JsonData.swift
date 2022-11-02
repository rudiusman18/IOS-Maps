//
//  JsonData.swift
//  Maps
//
//  Created by PT. ARION INDONESIA on 01/11/22.
//

import Foundation
import GoogleMaps
import GoogleMapsUtils

class JsonData : UIViewController{
    
    func getMarker(mapview: GMSMapView){
        //        membaca data marker secara local
        let parseData = Bundle.main.url(forResource: "total_penerima_bpnt_blimbing" , withExtension: "json")
        let userdata = try? Data(contentsOf: parseData!)
        let decoder = JSONDecoder()
        let result = try? decoder.decode(UserModel.self, from: userdata!)
        
        for item in result!.multiLocation{
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: Double(item.latitude)!, longitude: Double(item.longitude)!)
            marker.title = item.title
            marker.snippet = item.miniInfo.components(separatedBy: "<br>")[0] + "\n" + item.miniInfo.components(separatedBy: "<br>")[1] + "\nAlamat: " + item.address
            marker.map = mapview
        }
    }
    
    func getPolygon(mapview: GMSMapView){
        //    Membaca data rawan gempa
        
        guard let path1 = Bundle.main.path(forResource: "risiko_bencana_gabungan", ofType: "json") else {
            return
        }
        
        let url1 = URL(fileURLWithPath: path1)
        
        let geoJsonParser1 = GMUGeoJSONParser(url: url1)
        geoJsonParser1.parse()
        let style1 = GMUStyle(styleID: "random", stroke: UIColor.gray, fill: UIColor.lightGray.withAlphaComponent(0.5), width: 2, scale: 1, heading: 0, anchor: CGPoint(x: 0, y: 0), iconUrl: nil, title: nil, hasFill: true, hasStroke: true)
        
        for feature in geoJsonParser1.features {
            feature.style = style1
        }
        
        
        let renderer1 = GMUGeometryRenderer(map: mapview, geometries: geoJsonParser1.features)
        renderer1.render()
    }
    
    
    func getPolyline(mapview: GMSMapView, Color:UIColor){
        //        Membaca data jaringan listrik secara lokal
        guard let path = Bundle.main.path(forResource: "jaringan_listrik_kota_malang", ofType: "json") else {
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        let geoJsonParser = GMUGeoJSONParser(url: url)
        geoJsonParser.parse()
        
        let style = GMUStyle(styleID: "random", stroke: Color, fill: UIColor.orange.withAlphaComponent(0.5), width: 2, scale: 1, heading: 0, anchor: CGPoint(x: 0, y: 0), iconUrl: nil, title: nil, hasFill: false, hasStroke: false)
        
        for feature in geoJsonParser.features {
            feature.style = style
        }
        
        let renderer = GMUGeometryRenderer(map: mapview, geometries: geoJsonParser.features)
        renderer.render()
    }
    
    
}
