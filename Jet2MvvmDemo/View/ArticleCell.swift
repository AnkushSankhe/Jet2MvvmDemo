//
//  ArticleCell.swift
//  Jet2MvvmDemo
//
//  Created by Ankush on 03/07/20.
//  Copyright © 2020 Ankush. All rights reserved.
//

import UIKit
import SDWebImage


class ArticleCell: UITableViewCell {
    
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var userProfilePic: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userDesignLable: UILabel!
    @IBOutlet weak var articleContentLable: UILabel!
    @IBOutlet weak var articleTitleLable: UILabel!
    @IBOutlet weak var likesLable: UILabel!
    @IBOutlet weak var commentLable: UILabel!
    @IBOutlet weak var lastSeenLable: UILabel!
    @IBOutlet weak var articleUrl: UITextView!
    @IBOutlet weak var articleImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var articleTitleLableHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var articleUrlHeightConstraint: NSLayoutConstraint!

    var articleViewModel: ArticleViewModel! {
        didSet {
           // userNameLabel?.text = articleViewModel.
            likesLable.text = articleViewModel.likes + " Likes"
            commentLable.text = articleViewModel.comment + " Comments"
            userProfilePic.sd_setImage(with: URL(string: articleViewModel.user[0].avatar ), completed: nil)
            
            userNameLabel.text = String(articleViewModel.user[0].name) + " " + String(articleViewModel.user[0].lastname)
            userDesignLable.text = String(articleViewModel.user[0].designation)
            articleContentLable.text = String(articleViewModel.content)
            lastSeenLable.text = articleViewModel.lastSeen
            
            if articleViewModel.media.count > 0
            {
                articleTitleLable.text = articleViewModel.media[0].title
                articleUrl.text = articleViewModel.media[0].url
                articleImageView.sd_setImage(with: URL(string: articleViewModel.media[0].image ), completed: nil)
                
                articleImageViewHeightConstraint.constant = 149
                articleTitleLableHeightConstraint.constant = 21
                articleUrlHeightConstraint.constant = 37
            }
            else
            {
                articleImageViewHeightConstraint.constant = 0
                articleTitleLableHeightConstraint.constant = 0
                articleUrlHeightConstraint.constant = 0
            }
            self.setNeedsLayout()
            
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        
    }
    
    fileprivate func setup()
    {
       self.userProfilePic.layer.cornerRadius = self.userProfilePic.frame.width/2
        self.userProfilePic.clipsToBounds = true
        
        self.userProfilePic.layer.borderWidth = 1
        self.userProfilePic.layer.borderColor = UIColor.red.cgColor

    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

}
