//
//  BKBaseViewController.m
//  Boook
//
//  Created by Edwin Iskandar on 10/21/12.
//  Copyright (c) 2012 Edwin Iskandar. All rights reserved.
//

#import "BKBaseViewController.h"
#import "NSAttributedString+BoookAdditions.h"

@interface BKBaseViewController ()

@end

@implementation BKBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"gray_global_bgr"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
