//
//  BKLibraryViewController.h
//  Boook
//
//  Created by Edwin Iskandar on 10/21/12.
//  Copyright (c) 2012 Edwin Iskandar. All rights reserved.
//

#import "BKBaseViewController.h"

@interface BKLibraryViewController : BKBaseViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSArray *books;
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property int selectedIndex;
@end
