//
//  Extensions.swift
//  Netflix-UI
//
//  Created by Ceren Güneş on 9.08.2023.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}

