//
//  BKViewController.h
//  Boook
//
//  Created by Edwin Iskandar on 10/18/12.
//  Copyright (c) 2012 Edwin Iskandar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BKBook.h"
#import "BKBaseViewController.h"

@interface BKBookViewController : BKBaseViewController <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

typedef enum {
	BookTableViewTagChapterContent = 1,
	BookTableViewTagTableOfContents
} BookTableViewTags;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITableView *tableOfContentsTableView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) BKBook *book;
@property (strong, nonatomic) NSMutableArray *pages;
@property (strong, nonatomic) IBOutlet UILabel *tipLabel;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *toolTipElements;
@property (strong, nonatomic) IBOutlet UIImageView *bookCover;
@property (strong, nonatomic) IBOutlet UIImageView *tableOfContentsBookCover;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *barButtonItem;
@property (strong, nonatomic) IBOutlet UIImageView *tableOfContentsShadow;

@property CGPoint lastContentOffset;
@property CGRect bookCoverFrame;
@property NSInteger chapterNumber;
@property BOOL loadingChapter;
@end