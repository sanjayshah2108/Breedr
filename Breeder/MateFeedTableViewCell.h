//
//  MateFeedTableViewCell.h
//  Breeder
//
//  Created by Sanjay Shah on 2017-10-17.
//  Copyright © 2017 Sanjay Shah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MateFeedTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextView *petAgeLabel;

@property (weak, nonatomic) IBOutlet UITextView *petBreedLabel;

@property (weak, nonatomic) IBOutlet UIImageView *petImageView;

@property (weak, nonatomic) IBOutlet UIButton *messageButton;



@end
