//
//  JBPManger.m
//  JukeboxApp
//
//  Created by Todd Littlejohn on 2/3/17.
//  Copyright © 2017 TKC. All rights reserved.
//

#import "JBPManger.h"

@implementation JBPManger

+ (JBPManger*)sharedInstance
{
    
    static JBPManger *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[JBPManger alloc] init];
    });
    
    return _sharedInstance;
}

- (id)init
{
    self = [super init];
    self.spotifyManager = [JBPSpotifyServiceManager sharedInstance];
    return self;
}

- (void)setUpServices
{
    // Will do better once I add another service
    [self.spotifyManager startAuthenticationFlow];

}


@end
