//
//  BKViewController.m
//  Boook
//
//  Created by Edwin Iskandar on 10/18/12.
//  Copyright (c) 2012 Edwin Iskandar. All rights reserved.
//

#import "BKBookViewController.h"
#import "BKBook.h"
#import "BKChapter.h"
#import "BKChunk.h"
#import <CoreText/CoreText.h>
#import "BKPageCell.h"
#import "NSAttributedString+BoookAdditions.h"
#import "UILabel+BoookAdditions.h"

@interface BKBookViewController ()

@end

CGFloat const kPageVerticalMargin = 15.0f;
CGFloat const kPageHorizontalMargin = 15.0f;
CGFloat const kParagraphIndent = kPageHorizontalMargin + 20.0f;
CGFloat const kPagelWidth = 300.0f;
CGFloat const kPageHeight = 444.0f;

@implementation BKBookViewController

- (UILabel *)sizedLabelWithAttributedText:(NSAttributedString *)wordAttText {
	
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kPagelWidth, kPageHeight)];
	[label setAttributedText:wordAttText];
	[label sizeToFit];
	[label setBackgroundColor:[UIColor clearColor]];
	return label;
}

- (void)setupPages {
		
	// setup the pages array. Each object within the array will contain another array containing the UILabels that make up the page
	self.pages = [NSMutableArray array];
	__block NSMutableArray *page = [NSMutableArray array];
	
	NSOrderedSet *chapters = [self.book chapters];
	
	// just hardcode chapter 5
	BKChapter *chapter = [chapters objectAtIndex:1];
	
	NSOrderedSet *chunks = chapter.chunks;
	__block NSMutableAttributedString *attString=[[NSMutableAttributedString alloc] initWithString:@""];
	
	__block CGPoint pageCursor = CGPointMake(kPageHorizontalMargin, kPageVerticalMargin); // track where each words fits on the page so we know how to start a new page
	
	[chunks enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		BKChunk *chunk = (BKChunk *)obj;
	
		NSString *text = [chunk.text stringByAppendingString:@"\n"];
		if (text) {
			NSMutableAttributedString *chunkAttString = [[NSMutableAttributedString alloc] initWithString:text];
			
			if (chunk.typeValue == ChunkTypeHeading) {
				[chunkAttString setAttributes:[NSAttributedString attributesForHeading] range:NSMakeRange(0, chunkAttString.length)];
			} else if (chunk.typeValue == ChunkTypeSubHeading) {
				[chunkAttString setAttributes:[NSAttributedString attributesForSubHeading] range:NSMakeRange(0, chunkAttString.length)];
			} else {
				[chunkAttString setAttributes:[NSAttributedString attributesForParagraph] range:NSMakeRange(0, chunkAttString.length)];
			}
			
			// add footnotes
			if ([text rangeOfString:@"["].location != NSNotFound) {
				[chunkAttString setAttributes:[NSAttributedString attributesForFootNote] range:NSMakeRange([text rangeOfString:@"["].location, 4)];
			}
			
			// split into words
			NSArray *wordAttStrings = [chunkAttString componentsSeperatedBySubString:@" "];
			
			// create labels into word and organize them into pages
			[wordAttStrings enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
				NSAttributedString *wordAttString = (NSAttributedString *)obj;
				
				UILabel *wordLabel = [self sizedLabelWithAttributedText:wordAttString];
			
				// set up the pageCursor position for the next label
				if ((pageCursor.x + wordLabel.frame.size.width) > kPagelWidth) {
					// start a new page if we exceeded the page width
					pageCursor = CGPointMake(kPageHorizontalMargin, pageCursor.y + wordLabel.frame.size.height);
				}
				
				if (pageCursor.y > kPageHeight) {
					// we've exceeded the page size so finish up this page
					[self.pages addObject:page];
					page = [NSMutableArray array];
					
					pageCursor = CGPointMake(kPageHorizontalMargin, kPageVerticalMargin);
				}
				wordLabel.frame = CGRectOffset(wordLabel.frame, pageCursor.x, pageCursor.y);
				
				// shift page cursor
				pageCursor = CGPointMake(pageCursor.x + wordLabel.frame.size.width, pageCursor.y);
				
				// add paragraph spacing if word has line break characters
				if ([wordLabel.text rangeOfString:@"\n"].location != NSNotFound) {
					NSLog(@"supposed to make line break");
					pageCursor = CGPointMake(kParagraphIndent, pageCursor.y + wordLabel.frame.size.height + 20.0f);
				}
				
				[page addObject:wordLabel];
			}];
		}
	}];
	
	if ([chunks count] < 1) {
		[self.pages addObject:attString];
	}
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = self.book.title;
	[[UIBarButtonItem appearance] setTintColor:[UIColor blackColor]];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	self.tableView.alpha = 0.0f;

	[self setupPages];
		
	[self.tableView reloadData];
	[self.activityIndicator stopAnimating];
	[UIView animateWithDuration:.3f animations:^{
		self.tableView.alpha = 1.0f;
	}];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.pages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	BKPageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"standard"];
	
	// don't redraw if the same cell
	cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper_texture.png"]];
	
	NSArray *page = [self.pages objectAtIndex:indexPath.row];
	// add all the words onto the page
	for (int i = 0; i < [page count]; i ++) {
		UILabel *wordLabel = [page objectAtIndex:i];
		[cell.textView addSubview:wordLabel];
	}
	
	cell.pageNumberLabel.text = [NSString stringWithFormat:@"page %i / %i", indexPath.row + 1, [self.pages count]];
	return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
	if (self.lastContentOffset.y > self.tableView.contentOffset.y) {
		// up
		//[self.navigationController setNavigationBarHidden:NO animated:YES];
	}
	else if (self.lastContentOffset.y < self.tableView.contentOffset.y) {
		//[self.navigationController setNavigationBarHidden:YES animated:YES];
	}
	
	self.lastContentOffset = self.tableView.contentOffset;
}
@end
