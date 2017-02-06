//
//  SongsViewController.m
//  JukeboxApp
//
//  Created by Todd Littlejohn on 2/4/17.
//  Copyright © 2017 TKC. All rights reserved.
//

#import "SongsViewController.h"
#import "JBPJukeBoxController.h"
#import "SongTableViewCell.h"
#import "JBPPlaylistController.h"

@interface SongsViewController () <UITableViewDataSource, UITableViewDelegate, SongTableViewCellDelegate>

@property (nonatomic, weak) JBPJukeBoxController* jukeBox;
@property (weak, nonatomic) IBOutlet UIButton *playPauseButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *shuffleButton;
@property (weak, nonatomic) IBOutlet UILabel *songNameAndArtistLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SongsViewController


// MARK: View Loads

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _jukeBox = [JBPJukeBoxController sharedInstance];
    [self updatePlayPauseButtonImage];
    [self updateCurrentSongLabel];
    [self.songNameAndArtistLabel setTextColor:[UIColor whiteColor]];
    [_tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self updatePlayPauseButtonImage];
    [self updateCurrentSongLabel];
    [_tableView reloadData];
    self.title = [_jukeBox.currentlyViewedPlaylist getName];
}

// MARK: Actions

- (IBAction)ShuffleButtonTouched:(id)sender {
    [_jukeBox setPlaylistAndPlayRandom];
    [self updatePlayPauseButtonImage];
    [self updateCurrentSongLabel];
}

- (IBAction)nextButtonTouched:(id)sender {
    [_jukeBox getNextSongAndPlayIt];
    [self updatePlayPauseButtonImage];
    [self updateCurrentSongLabel];
}

- (IBAction)playPauseButtonTouched:(id)sender {
    
    if ([_jukeBox getIsCurrentlyPlaying]) {
        [_jukeBox pauseCurrentSong];
        
    } else {
        if ([_jukeBox hasCurrentSong]) {
            [_jukeBox playCurrentSong];
        } else {
            NSLog(@"User tried to play with no song availible.");
        }
    }
    
    [self updatePlayPauseButtonImage];
}

// MARK: TableView Functions

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_jukeBox.currentlyViewedPlaylist.songIdentifers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"songCell";
    SongTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    JBPSong* song = [_jukeBox getSongFromCurrentlyViewedAtIndex:indexPath.row];
    cell.songNameLabel.text = [song getName];
    cell.artistNameLabel.text = [song getArtistName];
    cell.delegate = self;
    cell.indexPath = indexPath;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"WTF");
    [_jukeBox setPlaylistAndPlayAtIndex:indexPath.row];
    [self updateCurrentSongLabel];
    [self updatePlayPauseButtonImage];
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

// MARK: Update Label Functions

- (void)updatePlayPauseButtonImage
{
    if ([_jukeBox getIsCurrentlyPlaying]) {
        [_playPauseButton setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    } else {
        [_playPauseButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    }
}

- (void)updateCurrentSongLabel
{
    if ([_jukeBox hasCurrentSong]) {
        self.songNameAndArtistLabel.text = [NSString stringWithFormat:@"%@ • %@", [_jukeBox getCurentSongName], [_jukeBox getCurrentSongArtist]];
    } else {
        self.songNameAndArtistLabel.text = @"";
    }
}




// MARK: Alert Functions

- (void)initiateActionSheetForSongAtIndexPath:(NSIndexPath*)indexPath {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:[_jukeBox getSongFromCurrentlyViewedAtIndex:indexPath.row].name
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* playlistAction = [UIAlertAction actionWithTitle:@"Add to Playlist" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [self initiateActionSheetToAddSongToPlaylist:indexPath];
    }];
    
    UIAlertAction* queueAction = [UIAlertAction actionWithTitle:@"Add to Queue" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [_jukeBox addSongToQueueFromIndex:indexPath.row];
    }];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [alert addAction:queueAction];
    [alert addAction:playlistAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)initiateActionSheetToAddSongToPlaylist:(NSIndexPath*)indexPath
{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:[_jukeBox getSongFromCurrentlyViewedAtIndex:indexPath.row].name
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    
    NSMutableArray* mutablePlaylists = [JBPPlaylistController sharedInstance].mutablePlaylists;
    
    NSLog(@"%lu", (unsigned long)[mutablePlaylists count]);
    
    for (JBPPlaylist* playlist in mutablePlaylists) {
        
        UIAlertAction* tmpAction = [UIAlertAction actionWithTitle:[playlist getName] style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            [playlist addSongIdentifier:[_jukeBox getSongFromCurrentlyViewedAtIndex:indexPath.row].identifier];
            NSLog(@"%lu", (unsigned long)[playlist.songIdentifers count]);
        }];
        
        [alert addAction:tmpAction];
        
    }
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

@end
