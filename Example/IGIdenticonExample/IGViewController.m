//
//  IGViewController.m
//  IGIdenticonExample
//
//  Created by Evgeniy Yurtaev on 8/2/13.
//  Copyright (c) 2013 Evgeniy Yurtaev. All rights reserved.
//

#import "IGViewController.h"
#import "IGIdenticon.h"

@interface IGViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *strings;
@property (nonatomic, strong) NSMutableArray *images;

@end

@implementation IGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

	self.strings = [[NSMutableArray alloc] init];
	self.images = [[NSMutableArray alloc] init];
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	
	self.strings = nil;
	self.images = nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.strings count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
	
	cell.textLabel.text = [self.strings objectAtIndex:indexPath.row];
	cell.imageView.image = [self.images objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark -
#pragma mark Actions

- (IBAction)insertNewRow:(id)sender
{
	NSString *string = [NSString stringWithFormat:@"%i.%i.%i.%i",
						arc4random_uniform(256),
						arc4random_uniform(256),
						arc4random_uniform(256),
						arc4random_uniform(256)];
	
	UIImage *identicon = [IGIdenticon identiconWithString:string size:64 backgroundColor:[UIColor whiteColor]];
	
	[self.strings insertObject:string atIndex:0];
	[self.images insertObject:identicon atIndex:0];
	
	NSIndexPath *insertRowIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
	[self.tableView insertRowsAtIndexPaths:@[insertRowIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
