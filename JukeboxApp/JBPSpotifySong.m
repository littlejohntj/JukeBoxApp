//
//  JBPSpotifySong.m
//  JukeboxApp
//
//  Created by Todd Littlejohn on 2/4/17.
//  Copyright © 2017 TKC. All rights reserved.
//

#import "JBPSpotifySong.h"

/*
I will handle errors and successes of playing after I implement the jukebox
 */

@implementation JBPSpotifySong

- (id)initWithName:(NSString*)name andIdentifier:(NSString*)identifier
{
    self = [super initWithName:name andIdentifier:identifier];
    if (self) {
        self.manager = [JBPSpotifyServiceManager sharedInstance];
    }
    return self;
}

- (void)play
{
    if (self.isBeingPlayed) {
        
        [self.manager.player setIsPlaying:YES callback:^(NSError* error)
         {
             if (error != nil) {
                 // NEED TO HANDLE IF THIS HAPPENS ASAP SO I DONT FORGET
                 NSLog(@"failed to resume playing: %@", error);
                 return;
             } else {
                 NSLog(@"was able to continue playing");
                 // NEED TO SEND MESSAGE TO THE JUKEBOX THAT WE HAVE CONTINUED PLAYING
             }
         }];
        
    } else {
        
        self.isBeingPlayed = YES;
        
        [self.manager.player playSpotifyURI:self.identifier startingWithIndex:0 startingWithPosition:0 callback:^(NSError* error) {
            
            if (error != nil) {
                // NEED TO HANDLE IF THIS HAPPENS ASAP SO I DONT FORGET
                NSLog(@"*** failed to play: %@", error);
                return;
            } else {
                // NEED TO SEND MESSAGE TO THE JUKEBOX THAT WE HAVE STARTED PLAYING
            }
            
        }];
    }
    
}

- (void)pause
{
    if (self.isBeingPlayed) {
        
        [self.manager.player setIsPlaying:NO callback:^(NSError* error)
         {
             if (error != nil) {
                 // NEED TO HANDLE IF THIS HAPPENS ASAP SO I DONT FORGET
                 NSLog(@"failed to pause playing: %@", error);
                 return;
             } else {
                 NSLog(@"was able to pause playing");
                 // NEED TO SEND MESSAGE TO THE JUKEBOX THAT WE HAVE PAUSED
             }
         }];
        
    }
}

- (void)stopPlayingSong {
    [self pause];
    [super stopPlayingSong];
}



@end
