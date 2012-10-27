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
#import "BKLabel.h"
#import "BKTOCCell.h"

@interface BKBookViewController ()

@end

CGFloat const kPageVerticalMargin = 15.0f;
CGFloat const kPageHorizontalMargin = 15.0f;
CGFloat const kParagraphIndent = kPageHorizontalMargin + 20.0f;
CGFloat const kPagelWidth = 300.0f;
CGFloat const kPageHeight = 444.0f;
CGFloat const kPageBounceChapterThreshold = 50.0f;

CGFloat const kImageHorizontalMargin = 40.0f;
CGFloat const kImageVerticalMargin = 20.0f;

@implementation BKBookViewController

#pragma mark book rendering
- (UILabel *)sizedLabelWithAttributedText:(NSAttributedString *)wordAttText {
	BKLabel *label = [[BKLabel alloc] initWithFrame:CGRectMake(0, 0, kPagelWidth, kPageHeight)];
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
	
	BKChapter *chapter = [chapters objectAtIndex:self.chapterNumber];
	
	NSOrderedSet *chunks = chapter.chunks;
	__block CGPoint pageCursor = CGPointMake(kPageHorizontalMargin, kPageVerticalMargin); // track where each words fits on the page so we know how to start a new page
	
	[chunks enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		BKChunk *chunk = (BKChunk *)obj;
		
		// handle images
		if (chunk.typeValue == ChunkTypeImage) {
			UIImageView *imageChunk = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:chunk.image]];
			imageChunk.contentMode = UIViewContentModeScaleAspectFill;
			imageChunk.clipsToBounds = YES;
			imageChunk.frame = CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width -(kImageHorizontalMargin*2), kPageHeight*((kPagelWidth-(kImageHorizontalMargin*2))/imageChunk.frame.size.width));
			
			if (pageCursor.y + imageChunk.frame.size.height + kImageVerticalMargin > kPageHeight  ) {
				// we've exceeded the page size so finish up this page
				[self.pages addObject:page];
				page = [NSMutableArray array];
				pageCursor = CGPointMake(kPageHorizontalMargin, kPageVerticalMargin);
			} else {
				pageCursor = CGPointMake(kPageHorizontalMargin, pageCursor.y + kImageVerticalMargin);
			}
			imageChunk.frame = CGRectMake(kImageHorizontalMargin, pageCursor.y, imageChunk.frame.size.width, imageChunk.frame.size.height);
			
			// shift page cursor
			pageCursor = CGPointMake(kPageHorizontalMargin, pageCursor.y + imageChunk.frame.size.height + kImageVerticalMargin);
			
			[page addObject:imageChunk];
			
		} else {
		
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
						// start a new line if we exceeded the page width
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
						pageCursor = CGPointMake(kParagraphIndent, pageCursor.y + wordLabel.frame.size.height + 20.0f);
					}
					
					[page addObject:wordLabel];
				}];
			}
		}
	}];
	
	// add the final page
	[self.pages addObject:page];
}

#pragma mark view lifecycle methods
- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = self.book.title;
	// reset tips
	[self hideTip];
	
	// display book cover
	self.bookCover.image = [UIImage imageWithContentsOfFile:[self.book pathToBookImage]];
	// also in the table of contents
	self.tableOfContentsBookCover.image = [UIImage imageWithContentsOfFile:[self.book pathToBookImage]];
	
	// keep track of original frame so we can reset it
	self.bookCoverFrame = self.bookCover.frame;
}

- (void)setupChapter {
	[self setupPages];
	
	[self.tableView reloadData];
	[self.activityIndicator stopAnimating];
	
	// turn page effect for cover
	[UIView transitionWithView:self.bookCover
					  duration:1.0
					   options: UIViewAnimationOptionTransitionCurlUp animations:^{
		 self.bookCover.frame = CGRectMake(-320.0f, 0.0f, 10.0f, 10.0f);
	 } completion:^(BOOL finished){
		 //
	 }];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	[self setupChapter];
	// show highlighting tip after 5 seconds
	int64_t delayInSeconds = 3.0;
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
		[self showTipWithMessage:@"Swipe right to hightlight, left to undo"];
	});
}

#pragma mark table view delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	int rowsInSection = 0;
	switch (tableView.tag) {
		case BookTableViewTagChapterContent: {
			// main book content
			rowsInSection = [self.pages count];
			break;
		}
			
		case BookTableViewTagTableOfContents: {
			// table of contents
			rowsInSection = [self.book.chapters count];
			break;
		}
	}
	return rowsInSection;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	switch (tableView.tag) {
		case BookTableViewTagChapterContent: {
			// Main page content cell
			
			BKPageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"standard"];
			// don't redraw if the same cell
			cell.textView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper_texture.png"]];
			
			NSArray *page = [self.pages objectAtIndex:indexPath.row];
			// add all the words (or images) onto the page
			for (int i = 0; i < [page count]; i ++) {
				UIView *wordOrImageChunk = [page objectAtIndex:i];
				[cell.textView addSubview:wordOrImageChunk];
				
				if ([wordOrImageChunk isKindOfClass:[UIImageView class]]) {
					// for images bring them to the back so text overlays
					[cell.textView sendSubviewToBack:wordOrImageChunk];
				}
			}
			
			// enable hightlighting for text
			UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panText:)];
			panGestureRecognizer.delegate = self;
			[cell.textView addGestureRecognizer:panGestureRecognizer];
			
			cell.pageNumberLabel.text = [NSString stringWithFormat:@"page %i / %i", indexPath.row + 1, [self.pages count]];
			
			return cell;
		}
		break;
		case BookTableViewTagTableOfContents: {
			// background table of contents cell
			
			BKTOCCell *cell = [tableView dequeueReusableCellWithIdentifier:@"chapter"];
			cell.contentView.backgroundColor = [UIColor darkGrayColor];
			BKChapter *chapter = [self.book.chapters objectAtIndex:indexPath.row];
			cell.chapterLabel.text = [chapter title];
			return cell;
		}
		break;
	}
	return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (tableView.tag == BookTableViewTagTableOfContents) {
		[self toggleTableOfContents:self.barButtonItem];
		[self loadNewChapter:indexPath.row];
	}
}

#pragma mark Gesture Recognizer methods to support text highlighting
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
	// only listen for horizontal pans or else tableview wont scroll
    UIView *textView = [gestureRecognizer view];
    CGPoint translation = [gestureRecognizer translationInView:textView];
    return (fabsf(translation.x) > fabsf(translation.y));
}

- (void)panText:(UIPanGestureRecognizer *)panGestureRecognizer  {
	UIView *textView = [panGestureRecognizer view];
	CGPoint touchedPoint = [panGestureRecognizer locationInView:textView];
	
	[[textView subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		BKLabel *label = (BKLabel *)obj;
		if ([label respondsToSelector:@selector(highLight)] && CGRectContainsPoint(label.frame, touchedPoint)) {
			
			CGPoint velocity = [panGestureRecognizer velocityInView:textView];
			if(velocity.x > 0) {
				// highlight on swipe right
				[label highLight];
				
				// show tip for tap and hold
				static dispatch_once_t onceToken;
				dispatch_once(&onceToken, ^{
					[self showTipWithMessage:@"Tap and hold to share highlighted text"];
				});
	
			}
			else {
				// unhighlight on swipe left
				[label unhighLight];
			}
		} 
	}];
}

#pragma mark tip notifications
- (void) hideTip {
	[self.toolTipElements enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
		view.frame = CGRectMake(0.0f, -30.0f, view.frame.size.width, view.frame.size.height);
	}];
}
- (void) hideTipAnimated:(BOOL)animated {
	if (animated) {
		[UIView animateWithDuration:.3f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
			[self hideTip];
		} completion:^(BOOL finished) {
			//
		}];
	} else {
		[self hideTip];
	}
}

- (void) showTipWithMessage:(NSString *)tipMessage {
	self.tipLabel.text = tipMessage;
	
	[UIView animateWithDuration:.3f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
		[self.toolTipElements enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
			view.frame = CGRectMake(0.0f, 0.0f, view.frame.size.width, view.frame.size.height);
		}];
	} completion:^(BOOL finished) {
		// hide the tip 5 seconds later
		int64_t delayInSeconds = 4.0;
		dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
		dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
			[self hideTipAnimated:YES];
		});
	}];
}


#pragma mark sharing text
- (NSString *)highlightedText {
	__block NSString *highlightedText = @"";
	[self.pages enumerateObjectsUsingBlock:^(NSArray *page, NSUInteger idx, BOOL *stop) {
		[page enumerateObjectsUsingBlock:^(BKLabel *label, NSUInteger idx, BOOL *stop) {
			if ([label isKindOfClass:[BKLabel class]] && [label isHighLighted]) {
				highlightedText = [[highlightedText stringByAppendingString:label.text] stringByAppendingString:@" "];
			}
		}];
	}];
	return highlightedText;
}

- (IBAction)shareText {
	NSString *text = [self highlightedText];
	
	// add quotes to text
	text = [NSString stringWithFormat:@"\"%@\"", text];
	UIImage *image = [UIImage imageWithContentsOfFile:[self.book pathToBookImage]];
	
	NSArray *activityItems = [NSArray arrayWithObjects:text,image , nil];
	UIActivityViewController *activityViewController = [[UIActivityViewController alloc]
									 initWithActivityItems: activityItems applicationActivities:nil];
	[self presentViewController:activityViewController animated:YES completion:nil];
}

#pragma mark scroll view methods
- (void)loadNewChapter:(NSInteger)newChapterNumber {
	self.loadingChapter = YES;
	[self.activityIndicator startAnimating];
	
	// put back book cover first
	[UIView transitionWithView:self.bookCover
					  duration:.5f
					   options: UIViewAnimationOptionTransitionCurlDown animations:^{
						   self.bookCover.frame = self.bookCoverFrame;
					   } completion:^(BOOL finished){
						   // now load the chapter again
						   self.chapterNumber = newChapterNumber;
						   [self setupChapter];
						   self.loadingChapter = NO;
						   [self.tableView setContentOffset:CGPointZero];
					   }];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	if (self.loadingChapter) {
		return;
	}
	
	if (scrollView.contentOffset.y < -kPageBounceChapterThreshold && self.chapterNumber > 0) {
		// snapped up so try and get the previous chapter
		[self loadNewChapter:self.chapterNumber-1];
	}
	
	if (scrollView.contentOffset.y + self.tableView.frame.size.height > self.tableView.contentSize.height + kPageBounceChapterThreshold) {
		// snapped down so get next chapter
		[self loadNewChapter:self.chapterNumber+1];
	}
}

#pragma mark Table of Contents
- (IBAction)toggleTableOfContents:(UIBarButtonItem *)buttonItem {
	[UIView animateWithDuration:.5f animations:^{
		if (self.tableView.frame.origin.x == 0.0f) {
			self.tableOfContentsTableView.alpha = 1.0f;
			self.tableOfContentsShadow.alpha = .4f;
			self.tableView.frame = CGRectMake(-[UIScreen mainScreen].bounds.size.width/2, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
			buttonItem.title = @"☰";
		} else {
			self.tableView.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
			self.tableOfContentsShadow.alpha = 0.0f;
			buttonItem.title = @"☰";
			self.tableOfContentsTableView.alpha = 0.0f;
		}
	}];
}

@end
