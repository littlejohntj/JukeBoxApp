//
//  SongTableViewCell.m
//  JukeboxApp
//
//  Created by Todd Littlejohn on 2/5/17.
//  Copyright © 2017 TKC. All rights reserved.
//

#import "SongTableViewCell.h"
#import "JBPJukeBoxController.h"
#import "SongsViewController.h"

@implementation SongTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.artistNameLabel.text = @"tacoCat";
}

- (IBAction)optionsButtonSelected:(id)sender {
    [self.delegate initiateActionSheetForSongAtIndexPath:self.indexPath];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
