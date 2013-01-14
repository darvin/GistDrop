//
//  GistUploader.m
//  GistDrop
//
//  Created by Sergey Klimov on 1/13/13.
//  Copyright (c) 2013 Sergey Klimov. All rights reserved.
//

#import "GistUploader.h"
#import <UAGithubEngine/UAGithubEngine.h>
#import "Gist.h"
@implementation GistUploader {
    UAGithubEngine* _engine;
}
@synthesize engine = _engine;

-(id) initForUser:(NSString *)username password:(NSString *)password {
    if ((self=[super init])) {
       _engine = [[UAGithubEngine alloc] initWithUsername:username password:password withReachability:YES];
    }
    return self;
}


-(BOOL) postText:(NSString*) text callback:(GistUploaderResponseBlock) callback {
    NSDictionary* gistDict = @{
        @"description": @"the description for this gist",
        @"public": @YES,
        @"files": @{
            @"file1.txt": @{
                @"content": text
            }
        }
    };
    
    
    [_engine createGist:gistDict success:^(id response) {
        Gist* gist = [[Gist alloc] initWithGithubEngineResponse:[response lastObject]];
        callback(gist);
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
        callback(nil);
    }];
    return YES;
}

@end
