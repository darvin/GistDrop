//
//  Gist.m
//  GistDrop
//
//  Created by Sergey Klimov on 1/13/13.
//  Copyright (c) 2013 Sergey Klimov. All rights reserved.
//

#import "Gist.h"

@implementation Gist
@synthesize url=_url, rawUrl=_rawUrl, filename=_filename, gistType=_gistType, gitRepo=_gitRepo, public=_public,fileType=_fileType;

-(id) initWithGithubEngineResponse:(NSDictionary*) dict {
    if ((self=[super init])) {
        _url = dict[@"html_url"];
        NSDictionary *files = dict[@"files"];
        NSDictionary * fileDict = files[[[files allKeys] lastObject]];
        NSLog(@"");
    }
    return self;
}

@end
