//
//  JBPSpotifyServiceManager.h
//  JukeboxApp
//
//  Created by Todd Littlejohn on 2/3/17.
//  Copyright © 2017 TKC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpotifyAuthentication/SpotifyAuthentication.h>
#import <SpotifyAudioPlayback/SpotifyAudioPlayback.h>
#import <SafariServices/SafariServices.h>
#import <SpotifyMetadata/SpotifyMetadata.h>

@interface JBPSpotifyServiceManager : NSObject

@property (nonatomic, strong) SPTAuth *auth;
@property (nonatomic, strong) SPTAudioStreamingController *player;
@property (nonatomic, strong) UIViewController *authViewController;
@property (nonatomic, strong) UIViewController *delegate;

+ (JBPSpotifyServiceManager*)sharedInstance;
- (id)init;
- (void)startAuthenticationFlow;
- (void)dismissAuthViewWithURLIfNeeded:(NSURL *) url;

// degegate function
- (void)audioStreamingDidLogin:(SPTAudioStreamingController *)audioStreaming;

- (void)setUpSpotifyPlaylist;
- (void)turnTracksToSongsAndPopulate:(NSMutableArray*)tracks;

@end
