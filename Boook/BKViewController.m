//
//  BKViewController.m
//  Boook
//
//  Created by Edwin Iskandar on 10/18/12.
//  Copyright (c) 2012 Edwin Iskandar. All rights reserved.
//

#import "BKViewController.h"
#import "BKBook.h"
#import "BKChapter.h"
#import "BKChunk.h"
#import <CoreText/CoreText.h>
#import "BKPageCell.h"
#import "NSAttributedString+BoookAdditions.h"
#import "UILabel+BoookAdditions.h"

@interface BKViewController ()

@end

int const kLabelWidth = 300;
int const kLabelHeight = 454;

@implementation BKViewController

- (CGSize)sizeInLabel:(NSAttributedString *)attributedString {
	if (!self.dummyLabel) {
		self.dummyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kLabelWidth, kLabelHeight)];
		self.dummyLabel.numberOfLines = 0;
		self.dummyLabel.lineBreakMode = NSLineBreakByWordWrapping;
	}
	self.dummyLabel.attributedText = attributedString;
	CGSize sizeOfString = [self.dummyLabel sizeThatFits:CGSizeMake(kLabelWidth, CGFLOAT_MAX)];
//	CGSize sizeOfString = [attributedString.string sizeWithFont:[attributedString font] constrainedToSize:CGSizeMake(300.0f, 480.0f) lineBreakMode:NSLineBreakByWordWrapping];
//	NSLog(@"size of String = %@", [NSValue valueWithCGSize:sizeOfString]);
	
	return sizeOfString;
}

- (void)setupPages {
		
	self.pages = [NSMutableArray arrayWithCapacity:2];
	
	NSOrderedSet *chapters = [self.book chapters];
	
	// just hardcode chapter 5
	BKChapter *chapter5 = [chapters objectAtIndex:10];
	
	NSOrderedSet *chunks = chapter5.chunks;
	__block NSMutableAttributedString *attString=[[NSMutableAttributedString alloc] initWithString:@""];
	
	[chunks enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		BKChunk *chunk = (BKChunk *)obj;
		
		NSString *text = [chunk.text stringByAppendingString:@"\r\n\n"];
		if (text) {
			
			NSMutableAttributedString *chunkAttString = [[NSMutableAttributedString alloc] initWithString:text];
			
			if (chunk.typeValue == ChunkTypeHeading) {
				[chunkAttString setAttributes:[NSAttributedString attributesForTitle] range:NSMakeRange(0, chunkAttString.length)];
			} else {
				[chunkAttString setAttributes:[NSAttributedString attributesForParagraph] range:NSMakeRange(0, chunkAttString.length)];
				
				if (idx == 1) {
					[chunkAttString setAttributes:[NSAttributedString attributesForFirstParagraphTitle] range:NSMakeRange(0, 1)];
				}
			}
			
			// add footnotes
			if ([text rangeOfString:@"["].location != NSNotFound) {
				[chunkAttString setAttributes:[NSAttributedString attributesForFootNote] range:NSMakeRange([text rangeOfString:@"["].location, 4)];
			}
			
			// add a character at a time until we reach the proper height
			for (int i = 0; i < chunkAttString.length; i=i+30) {
				int maxRange = chunkAttString.length - i- 1;
				[attString appendAttributedString:[chunkAttString attributedSubstringFromRange:NSMakeRange(i, maxRange<30?maxRange:30)]];
				
				if ([self sizeInLabel: attString].height > kLabelHeight) {
					// call it a page
					[self.pages addObject:attString];
					
					// if there is a remaining fragment to this chunk, start off with that
					
					// start off the remainder with the rest of the cutoff string
					attString = [[NSMutableAttributedString alloc] initWithAttributedString:[chunkAttString attributedSubstringFromRange:NSMakeRange(i, chunkAttString.length - (i))]] ;
					//NSLog(@"attstring = %@", attString.string);
				}
			}
		}
	}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.tableView.alpha = 0.0f;
	[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"gray_global_bgr"]]];
	
	// parse a book
	self.book = [BKBook parseEpub:@"gullivers.epub"];
	
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
		
		[self setupPages];
		
		dispatch_async(dispatch_get_main_queue(), ^{
			[self.tableView reloadData];
			[self.activityIndicator stopAnimating];
			[UIView animateWithDuration:.3f animations:^{
				self.tableView.alpha = 1.0f;
			}];
		});
	});
	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.pages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	BKPageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"standard"];
	cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper_texture.png"]];
	
	NSAttributedString *pageContent = [self.pages objectAtIndex:indexPath.row];
	NSLog(@"pageContent = %@", pageContent);
	[cell.contentLabel setAttributedText:pageContent];
	
	cell.contentLabel.numberOfLines = 0;
	cell.contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
	[cell.contentLabel becomeFirstResponder];
	
	cell.pageNumberLabel.text = [NSString stringWithFormat:@"page %i / %i", indexPath.row + 1, [self.pages count]];
	
	return cell;
}
@end
