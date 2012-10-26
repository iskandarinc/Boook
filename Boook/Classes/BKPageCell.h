//
//  BKPageCell.h
//  Boook
//
//  Created by Edwin Iskandar on 10/19/12.
//  Copyright (c) 2012 Edwin Iskandar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BKPageCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel *pageNumberLabel;
@property (nonatomic, strong) IBOutlet UIView *textView;
@end

