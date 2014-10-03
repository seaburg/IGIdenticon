//
//  IGViewController.m
//  IGIdenticonExample
//
//  Created by Evgeniy Yurtaev on 8/2/13.
//  Copyright (c) 2013 Evgeniy Yurtaev. All rights reserved.
//

#import "IGViewController.h"
#import "IGGitHubIdenticon.h"
#import "IGCollectionViewCell.h"

@interface IGViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, copy) NSArray *icons;

@end

@implementation IGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                           target:self
                                                                                           action:@selector(insertItemButtonTapped:)];

    UINib *nib = [UINib nibWithNibName:NSStringFromClass([IGCollectionViewCell class]) bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:NSStringFromClass([IGCollectionViewCell class])];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat size = CGRectGetWidth(collectionView.frame) / 4.5;
    return CGSizeMake(size, size);
}

#pragma mark - UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IGCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([IGCollectionViewCell class]) forIndexPath:indexPath];
    cell.imageView.image = self.icons[indexPath.row];

    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.icons count];
}

#pragma mark - Actions

- (void)insertItemButtonTapped:(id)sender
{
    CGFloat iconSize = [self collectionView:self.collectionView layout:self.collectionView.collectionViewLayout sizeForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]].width;
    UIImage *icon = ([self.icons count] % 2) ? [IGIdenticon identiconWithUInt32:arc4random() size:iconSize] : [IGGitHubIdenticon identiconWithUInt32:arc4random() size:iconSize];

    NSMutableArray *icons = [NSMutableArray arrayWithArray:self.icons];
    [icons insertObject:icon atIndex:0];
    self.icons = icons;

    [self.collectionView insertItemsAtIndexPaths:@[ [NSIndexPath indexPathForRow:0 inSection:0] ]];
}

@end
