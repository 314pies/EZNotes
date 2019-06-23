//
//  NoteTableViewCell.swift
//  FirebaseStarterApp
//
//  Created by Ian Chen on 2019/6/22.
//  Copyright © 2019 Instamobile. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    func setTitle(titleText:String){
        TitleText.text = titleText
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var TitleText: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
