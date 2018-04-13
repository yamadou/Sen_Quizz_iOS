//
//  User.swift
//  XamXam
//
//  Created by Yamadou Traore on 4/12/18.
//  Copyright © 2018 com.yamadou. All rights reserved.
//

import Foundation
import FirebaseAuth


struct User {

    var uid: String
    var displayName: String?
    var photoUrl: URL?

    init(authData: FirebaseAuth.User) {
        uid = authData.uid
        if let displayName = authData.displayName {
            self.displayName = displayName
        }
        if let photoUrl = authData.photoURL {
            self.photoUrl = photoUrl
        }
    }
}

