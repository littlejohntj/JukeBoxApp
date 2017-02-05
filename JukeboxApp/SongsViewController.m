//
//  SongsViewController.m
//  JukeboxApp
//
//  Created by Todd Littlejohn on 2/4/17.
//  Copyright © 2017 TKC. All rights reserved.
//

#import "SongsViewController.h"
#import "JBPPlaylistController.h"
#import "JBPNormalPlaylist.h"
#import "JBPMusicStore.h"
#import "JBPSong.h"

@interface SongsViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) JBPNormalPlaylist* playlist;
@end

@implementation SongsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _playlist = [[JBPPlaylistController sharedInstance] getImmutablePlaylistAtIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_playlist.songIdentifers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [[UITableViewCell alloc] init];
    NSString* songIdentifier = [_playlist getSongIdeniferAtIndex:indexPath.row];
    JBPSong* song = [[JBPMusicStore sharedInstance] getSongFromIdentifier:songIdentifier];
    cell.textLabel.text = song.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString* songIdentifier = [_playlist getSongIdeniferAtIndex:indexPath.row];
    JBPSong* song = [[JBPMusicStore sharedInstance] getSongFromIdentifier:songIdentifier];
    [song play];
    
}

@end
