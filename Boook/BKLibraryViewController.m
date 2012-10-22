//
//  BKLibraryViewController.m
//  Boook
//
//  Created by Edwin Iskandar on 10/21/12.
//  Copyright (c) 2012 Edwin Iskandar. All rights reserved.
//

#import "BKLibraryViewController.h"
#import "BKBook.h"
#import "BKLibraryCell.h"
#import "BKBookViewController.h"
@interface BKLibraryViewController ()

@end

@implementation BKLibraryViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = @"Library";
	self.collectionView.alpha = 0.0f;
	
	[BKBook parseEpub:@"gullivers.epub"];
	[BKBook parseEpub:@"sherlock.epub"];
	[BKBook parseEpub:@"dickens-battle-of-life.epub"];
	[BKBook parseEpub:@"austen-pride-and-prejudice-illustrations.epub"];
	self.books = [BKBook findAll];

	[UIView animateWithDuration:.5f animations:^{
		self.collectionView.alpha = 1.0f;
		[self.activityIndicator stopAnimating];
	}];
	[self.collectionView reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//	int randomSize = arc4random() % 3;
//	switch (randomSize) {
//		case 0:
//			return CGSizeMake(125.0f, 200.0f);
//		case 1:
//			return CGSizeMake(50.0f, 100.0f);
//		default:
//			return CGSizeMake(200.0f, 250.0f);
//	}
	
	return CGSizeMake(155.0f, 250.0f);
	
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	
	BKBook *book = [self.books objectAtIndex:indexPath.row];
	
	BKLibraryCell *libraryCell = (BKLibraryCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"square" forIndexPath:indexPath];
	libraryCell.bookCoverImage.image = [UIImage imageWithContentsOfFile:[book pathToBookImage]];
	return libraryCell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return [self.books count];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	self.selectedIndex = indexPath.row;
	[self performSegueWithIdentifier:@"bookdetails" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"bookdetails"])
    {
        BKBookViewController *bookViewController = (BKBookViewController *)[segue destinationViewController];
		
		bookViewController.book = [self.books objectAtIndex:self.selectedIndex];
    }
}
@end