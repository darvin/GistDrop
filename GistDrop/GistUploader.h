//
//  GistUploader.h
//  GistDrop
//
//  Created by Sergey Klimov on 1/13/13.
//  Copyright (c) 2013 Sergey Klimov. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UAGithubEngine;
@class Gist;

typedef void (^GistUploaderResponseBlock)(Gist*);

@interface GistUploader : NSObject
@property (strong, nonatomic, readonly) UAGithubEngine* engine;


-(id) initForUser:(NSString*)username password:(NSString*) password;

-(BOOL) postText:(NSString*) text filename:(NSString*) filename description:(NSString*)description callback:(GistUploaderResponseBlock) callback;
-(BOOL) postFileAtURL:(NSURL*) url description:(NSString*)description callback:(GistUploaderResponseBlock) callback;


@end
