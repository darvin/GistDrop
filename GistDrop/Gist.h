//
//  Gist.h
//  GistDrop
//
//  Created by Sergey Klimov on 1/13/13.
//  Copyright (c) 2013 Sergey Klimov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Gist : NSObject
typedef enum {
    GistTypeText,
    GistTypeImage,
    GistTypeGeneric
} GistType;

@property (strong, readonly) NSString* filename;
@property (strong, readonly) NSURL * url;
@property (strong, readonly) NSURL * rawUrl;
@property (strong, readonly) NSString* gitRepo;
@property (readonly) NSString* fileType;
@property (readonly) GistType gistType;
@property (readonly) BOOL public;

-(id) initWithGithubEngineResponse:(NSDictionary*) dict;


@end
