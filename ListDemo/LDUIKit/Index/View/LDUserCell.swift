//
//  LDUserCell.swift
//  ListDemo
//
//  Created by 张玥 on 2021/3/5.
//

import UIKit
import Reusable

class LDUserCell: UITableViewCell, NibReusable  {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func cellWithTableView(table:UITableView)-> Self!{
        let identifier:NSString = "LDUserCell";
        var cell = table.dequeueReusableCell(withIdentifier: identifier as String)
        if (cell == nil) {
            cell = Bundle.main.loadNibNamed(identifier as String, owner: nil, options: nil)?.last as? LDUserCell
        }
        return cell as? Self;
    }
    
    var model: LDUserModel? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model.login
            scoreLabel.text = String("\(model.score ?? 0)")
            urlLabel.text = model.html_url
            avatarImageView.kf.setImage(with: URL(string: model.avatar_url!))
        }
    }
}
