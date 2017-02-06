//
//  PlaylistViewController.m
//  JukeboxApp
//
//  Created by Todd Littlejohn on 2/4/17.
//  Copyright © 2017 TKC. All rights reserved.
//

#import "PlaylistViewController.h"
#import "JBPPlaylistController.h"
#import "JBPNormalPlaylist.h"
#import "JBPJukeBoxController.h"

@interface PlaylistViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) JBPPlaylistController* playlistController;
@property (weak, nonatomic) JBPJukeBoxController* jukeBox;

@end

@implementation PlaylistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _playlistController = [JBPPlaylistController sharedInstance];
    _jukeBox = [JBPJukeBoxController sharedInstance];
    self.title = @"Playlists";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [_playlistController.immutablePlaylists count];
    } else {
        return [_playlistController.mutablePlaylists count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [[UITableViewCell alloc] init];
    JBPNormalPlaylist* playlist;
    
    if (indexPath.section == 0) {
        playlist = [_playlistController getImmutablePlaylistAtIndex:indexPath.row];
    } else {
        playlist = [_playlistController getMutablePlaylistAtIndex:indexPath.row];
    }
    
    cell.textLabel.text = playlist.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        [_jukeBox setCurrentlyViewedPlaylist:[_playlistController getImmutablePlaylistAtIndex:indexPath.row]];
    } else {
        [_jukeBox setCurrentlyViewedPlaylist:[_playlistController getMutablePlaylistAtIndex:indexPath.row]];
    }
    
    [self performSegueWithIdentifier:@"toSongs" sender:self];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([_playlistController.mutablePlaylists count] > 0) {
        return 2;
    } else {
        return 1;
    }
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Service Playlists";
    } else {
        return @"Custom Playlists";
    }
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Delete"  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        [_playlistController deletePlaylistAtIndex:indexPath.row];
        if ([_playlistController.mutablePlaylists count] == 0) {
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
        } else {
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        
    }];
    
    deleteAction.backgroundColor = [UIColor redColor];
    
    return @[deleteAction];
    
}

- (IBAction)createNewPlaylist:(id)sender {
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"Create Playlist"
                                                                              message: nil
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Playlist Name";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleNone;
    }];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Create" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray * textfields = alertController.textFields;
        UITextField * playListTextField = textfields[0];
        NSString* playListName = playListTextField.text;
        if (!([playListName length] == 0)) {
            [_playlistController createNewMutablePlaylistWithName:playListName];
            [self.tableView reloadData];
        }
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
