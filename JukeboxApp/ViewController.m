//
//  ViewController.m
//  JukeboxApp
//
//  Created by Todd Littlejohn on 2/3/17.
//  Copyright © 2017 TKC. All rights reserved.
//

#import "ViewController.h"
#import "JBPManger.h"
#import "JBPNode.h"
#import "JBPSong.h"
#import "JBPSpotifySong.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginTestButton:(id)sender {
    JBPManger* manager = [JBPManger sharedInstance];
    manager.spotifyManager.delegate = self;
    [manager setUpServices];
}

- (IBAction)goToPlaylists:(id)sender {
    [self performSegueWithIdentifier:@"toPlaylists" sender:self];
}



@end
