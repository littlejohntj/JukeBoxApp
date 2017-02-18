//
//  JBPSpotifyServiceManager.m
//  JukeboxApp
//
//  Created by Todd Littlejohn on 2/3/17.
//  Copyright © 2017 TKC. All rights reserved.
//

#import "JBPSpotifyServiceManager.h"
#import <SpotifyAuthentication/SpotifyAuthentication.h>
#import <SpotifyAudioPlayback/SpotifyAudioPlayback.h>
#import <SpotifyMetadata/SpotifyMetadata.h>
#import "JBPSong.h"
#import "JBPMusicStore.h"
#import "JBPPlaylistController.h"
#import "JBPSpotifySong.h"

@interface JBPSpotifyServiceManager () <SPTAudioStreamingDelegate>
    
@end

@implementation JBPSpotifyServiceManager

// MARK: Initilizers

+ (JBPSpotifyServiceManager*)sharedInstance
{
    
    static JBPSpotifyServiceManager *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[JBPSpotifyServiceManager alloc] init];
    });
    
    return _sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.auth = [SPTAuth defaultInstance];
        self.player = [SPTAudioStreamingController sharedInstance];
        self.auth.clientID = @"5353a7712d6c43ceb1ac77755fb7fdec";
        self.auth.redirectURL = [NSURL URLWithString:@"jukeboxapp://returnafterlogin"];
        self.auth.sessionUserDefaultsKey = @"current session";
        self.auth.requestedScopes = @[SPTAuthUserLibraryReadScope, SPTAuthStreamingScope, SPTAuthPlaylistReadPrivateScope];
        self.player.delegate = self;
        NSError *audioStreamingInitError;
        NSAssert([self.player startWithClientId:self.auth.clientID error:&audioStreamingInitError],
                 @"There was a problem starting the Spotify SDK: %@", audioStreamingInitError.description);
    }
    return self;
}

- (void)startAuthenticationFlow
{
    // Check if we could use the access token we already have
    if ([self.auth.session isValid]) {
        NSLog(@"here we go");
        
        // Use it to log in
        [self.player loginWithAccessToken:self.auth.session.accessToken];
        
    } else {
        NSLog(@"we elsed it yall");
        // Get the URL to the Spotify authorization portal
        NSURL *authURL = [self.auth spotifyWebAuthenticationURL];
        
        // Present in a SafariViewController
        self.authViewController = [[SFSafariViewController alloc] initWithURL:authURL];
        [self.delegate.view.window.rootViewController presentViewController:self.authViewController animated:YES completion:nil];
    }

}

// MARK: Authentication Functions

- (void)dismissAuthViewWithURLIfNeeded:(NSURL *) url
{
    if ([self.auth canHandleURL:url]) {
        
        [self.authViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        self.authViewController = nil;
        
        [self.auth handleAuthCallbackWithTriggeredAuthURL:url callback:^(NSError *error, SPTSession *session) {
            if (session) {
                [self.player loginWithAccessToken:self.auth.session.accessToken];
            }
        }];
    }
}

// MARK: Delegate Functions

- (void)audioStreamingDidLogin:(SPTAudioStreamingController *)audioStreaming
{
    NSLog(@"Spotify user login was valid.");
    [self setUpSpotifyPlaylist];
}

// MARK: Track Information Downloader Functions

- (void)setUpSpotifyPlaylist
{
    [SPTYourMusic savedTracksForUserWithAccessToken:self.auth.session.accessToken callback:^(NSError* error, SPTListPage* listPage)
     {
         if (error) {
             NSLog(@"Error trying to get user music");
         } else {
             
             [self listPageToArrayOfTracks:listPage];
         }
     }];
}

- (void)listPageToArrayOfTracks:(SPTListPage*)listpage
{
    
    NSMutableArray* ret = [NSMutableArray array];
    
    NSLog(@"%lu", (unsigned long)listpage.totalListLength);
    
    [self addTracksToArray:ret fromListPage:listpage];

}

- (void)addTracksToArray:(NSMutableArray*)array fromListPage:(SPTListPage*)lp
{
    __block SPTListPage *listPage = lp;
    
    [array addObjectsFromArray:listPage.items];
    
    if (listPage.hasNextPage) {
        
        NSError *__autoreleasing * urlError;
        NSURLRequest * listPageRequest = [listPage createRequestForNextPageWithAccessToken:self.auth.session.accessToken error:urlError];
        
        [[SPTRequest sharedHandler] performRequest:listPageRequest callback:^(NSError *error, NSURLResponse *response, NSData *data){
            
            if (error != nil) {
                NSLog(@"There was an error requesting the next listpage");
            } else {
                NSError *__autoreleasing * tmpError;
                listPage = [SPTListPage listPageFromData:data withResponse:response expectingPartialChildren:YES rootObjectKey:nil error:tmpError];
                [self addTracksToArray:array fromListPage:listPage];
            }
            
        }];
    } else {
        [self turnTracksToSongsAndPopulate:array];
    }
    
}

- (void)turnTracksToSongsAndPopulate:(NSMutableArray*)tracks
{
    NSMutableArray* spotifySongArray = [NSMutableArray array];
    NSMutableArray* spotifySongIdentifierArray = [NSMutableArray array];
    
    for (SPTPartialTrack* track in tracks) {
        JBPSpotifySong* newSong = [[JBPSpotifySong alloc] initWithName:track.name andIdentifier:[NSString stringWithFormat:@"%@", track.uri]];
        [newSong addAlbum:track.album.name];
        [newSong addSongDuration:track.duration];
        SPTPartialArtist * artist = track.artists.firstObject;
        [newSong addArtist:artist.name];
        [spotifySongArray addObject:newSong];
        [spotifySongIdentifierArray addObject:newSong.identifier];
    }
    
    [[JBPMusicStore sharedInstance] addSongsToMusicStore:spotifySongArray];
    [[JBPPlaylistController sharedInstance] createNewImmutablePlaylistWithName:@"Spotify Music" andIdentifiers:spotifySongIdentifierArray];
}

@end
