//
//  TableViewCell.h
//  CTADataRecoder
//
//  Created by Eddie Koranek on 9/29/14.
//  Copyright (c) 2014 Eddie Koranek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (nonatomic, weak)IBOutlet UILabel *cellLabel;
@property (nonatomic, weak)IBOutlet UIImageView *cellImage;

@end
