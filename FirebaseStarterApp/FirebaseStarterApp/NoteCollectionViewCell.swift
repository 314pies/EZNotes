//
//  NoteCollectionViewCell.swift
//  FirebaseStarterApp
//
//  Created by Ian Chen on 2019/6/26.
//  Copyright © 2019 Instamobile. All rights reserved.
//

import UIKit

class NoteCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var TitleText: UILabel!
    func setTitle(titleText:String){
        TitleText.text = titleText
    }
}
