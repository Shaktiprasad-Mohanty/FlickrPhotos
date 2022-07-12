//
//  APIService.swift
//  FlickrPhotos
//
//  Created by MGLearniOS on 03/05/22.
//

import Foundation
protocol APISeviceProtocol{
    func callAPI(param:[String:Any]?,urlStr:String,completion:@escaping (_ result:Data?,_ isSuccess:Bool)-> Void)
}


class APIService: APISeviceProtocol {
    private let baseURl = "https://www.flickr.com/services/api/"
    func callAPI(param: [String : Any]?, urlStr: String, completion: @escaping (Data?, Bool) -> Void) {
        guard let url = URL(string: baseURl + urlStr) else {
            completion(nil,false)
            return
        }
        
        var request = URLRequest(url: url)
        if let param = param {
            request.httpMethod = "POST"
            
               guard let paramData = try? JSONSerialization.data(withJSONObject: param, options: [])else {
                   completion(nil,false)
                   return
               }
                request.httpBody = String(data: paramData, encoding: .utf8)?.data(using: .utf8)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
        }
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if(error != nil){
                completion(nil,false)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
                completion(nil,false)
                return
            }
            guard let data = data else {
                completion(nil,false)
                return
            }
            completion(data, true)
            
        }.resume()
    }
}
