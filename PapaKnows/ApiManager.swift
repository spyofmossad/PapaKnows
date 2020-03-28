//
//  ApiManager.swift
//  PapaKnows
//
//  Created by Dmitry on 27.03.2020.
//  Copyright © 2020 Dmitry. All rights reserved.
//

import Foundation
import UIKit

class ApiManager {
    
    private static var baseUrl = "https://www.papajohns.by/"
    
    private static func getData(forUrl url: URL, _ completion: @escaping (Data) -> ()) {
        
        return URLSession.shared.dataTask(with: url, completionHandler: {(data, _, error) in
            
            guard error == nil else {
                print(error?.localizedDescription ?? "Request failed")
                return
            }
            
            guard let data = data else { return }
            
            completion(data)

        }).resume()
    }
            
    static func getCodes(_ completion: @escaping ([Code]) -> ()){
        
        guard let url = URL(string: baseUrl + "api/stock/codes") else { return }
        
        getData(forUrl: url, { data in
            DispatchQueue.main.async {
                completion(Code.parse(data: data))
            }
        })
    }
    
    static func getImage(by url: String, _ completion: @escaping ((UIImage) -> ())) {
        
        guard let url = URL(string: baseUrl + url) else { return }
            
        getData(forUrl: url, { data in
            DispatchQueue.main.async {
                guard let image = UIImage(data: data) else { return }
                completion(image)
            }
        })
    }
}
