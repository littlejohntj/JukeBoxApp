//
//  SongTableViewCell.h
//  JukeboxApp
//
//  Created by Todd Littlejohn on 2/5/17.
//  Copyright © 2017 TKC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SongsViewController.h"

@protocol SongTableViewCellDelegate <NSObject>

@required
- (void)initiateActionSheetForSongAtIndexPath:( NSIndexPath* _Nonnull ) indexPath;

@end

@interface SongTableViewCell : UITableViewCell

@property (weak, nonatomic, null_unspecified) IBOutlet UILabel* songNameLabel;
@property (weak, nonatomic, null_unspecified) IBOutlet UILabel* artistNameLabel;
@property (weak, nonatomic, null_unspecified) IBOutlet UIButton* optionsButton;
@property (strong, nonnull) NSIndexPath* indexPath;
@property (weak, nonatomic, null_unspecified) SongsViewController* delegate;

@end
