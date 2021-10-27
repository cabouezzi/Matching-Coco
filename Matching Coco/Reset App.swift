//
//  Reset App.swift
//  Matching Coco
//
//  Created by Chaniel Ezzi on 3/31/19.
//  Copyright © 2019 Lil Coco™. All rights reserved.
//

import Foundation

func resetApp() {
    UIApplication.shared.windows[0].rootViewController = UIStoryboard(
        name: "Main",
        bundle: nil
        ).instantiateInitialViewController()
}
