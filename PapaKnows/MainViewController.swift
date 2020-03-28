//
//  MainOneViewController.swift
//  PapaKnows
//
//  Created by Dmitry on 28.03.2020.
//  Copyright © 2020 Dmitry. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var promoImage: UIImageView!
    @IBOutlet var promoDescription: UILabel!
    @IBOutlet var promoPicker: UIPickerView!
    
    private var codes: [Code] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ApiManager.getCodes({ result in
            self.codes.append(contentsOf: result)
            self.promoPicker.reloadAllComponents()
            self.setData(for: 0)
        })
    }
    
    private func setData(for row: Int) {
        if let imageUrl = codes[row].imageUrl {
            ApiManager.getImage(by: imageUrl, ({ image in self.promoImage.image = image }))
        } else {
            self.promoImage.image = UIImage(named: "default")
        }
        
        let text = codes[row].description.split(separator: "-")
        
        promoDescription.text =
        """
        Номер кода: \(String(text[0]))
        
        Код или условие: \(String(text[1]))
        
        Описание: \(String(text[2]))
        
        Минимальный заказ: \(String(text[3]))
        
        Города: \(String(text[4]))
        """
    }

}

extension MainViewController {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        codes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return codes[row].code
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        setData(for: row)
    }
}
