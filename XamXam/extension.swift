//
//  extensions.swift
//  XamXam
//
//  Created by Yamadou Traore on 5/2/18.
//  Copyright © 2018 com.yamadou. All rights reserved.
//

import Foundation

extension Date
{
    func toString( dateFormat format  : String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
