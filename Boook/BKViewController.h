//
//  BKViewController.h
//  Boook
//
//  Created by Edwin Iskandar on 10/18/12.
//  Copyright (c) 2012 Edwin Iskandar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BKBook.h"

@interface BKViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) BKBook *book;
@property (strong, nonatomic) NSMutableArray *pages;
@property (strong, nonatomic) UILabel *dummyLabel;
@end
