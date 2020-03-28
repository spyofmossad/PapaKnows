//
//  Promo.swift
//  PapaKnows
//
//  Created by Dmitry on 27.03.2020.
//  Copyright © 2020 Dmitry. All rights reserved.
//

import Foundation

struct Code {
    let code: String
    let description: String
    let imageUrl: String?
}


extension Code {
    static func parse(data: Data) -> [Code] {
        var codes: [Code] = []
        
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                let innerDict = json.first?.value as? [[String : Any]] {
                    for item in innerDict {
                        if let code = Code.parseNode(json: item) {
                            codes.append(code)
                        } else {
                            print("Invalid record")
                        }
                    }
                }
        } catch let error {
            print(error)
        }
        
        return codes
    }
    
    private static func parseNode(json: [String: Any]) -> Code? {
        guard
            let name = json["name"] as? String,
            let code = json["code"] as? String
        else {
            return nil
        }
        
        return self.init(
            code: code,
            description: name,
            
            imageUrl: {() -> String? in
                if let imageUrl = json["image"] as? String {
                    return imageUrl
                } else {
                    return nil
                }}()
        )
    }
}


