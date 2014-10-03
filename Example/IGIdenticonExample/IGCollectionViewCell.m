//
//  IGCollectionViewCell.m
//  IGIdenticonExample
//
//  Created by Evgeniy Yurtaev on 03/10/14.
//  Copyright (c) 2014 Evgeniy Yurtaev. All rights reserved.
//

#import "IGCollectionViewCell.h"

@implementation IGCollectionViewCell

- (void)prepareForReuse
{
    [super prepareForReuse];

    self.imageView.image = nil;
}

@end
