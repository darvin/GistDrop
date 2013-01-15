//
//  Gist.m
//  GistDrop
//
//  Created by Sergey Klimov on 1/13/13.
//  Copyright (c) 2013 Sergey Klimov. All rights reserved.
//

#import "Gist.h"

@implementation Gist
@synthesize url=_url, rawUrl=_rawUrl, filename=_filename, gistType=_gistType, gitRepo=_gitRepo, public=_public,fileType=_fileType, mimestring=_mimestring;

-(id) initWithGithubEngineResponse:(NSDictionary*) dict {
    if ((self=[super init])) {
        _url = dict[@"html_url"];
        NSDictionary *files = dict[@"files"];
        NSDictionary * fileDict = files[[[files allKeys] lastObject]];
        _rawUrl = [NSURL URLWithString:fileDict[@"raw_url"]];
        _filename = fileDict[@"filename"];
        _fileType = fileDict[@"language"];
        _mimestring = fileDict[@"type"];
        _public = [dict[@"public"] boolValue];
        
        _gitRepo = dict[@"git_push_url"];
        //FIXME for some reason GitHub api gives wrong url for push
        _gitRepo = [NSString stringWithFormat:@"git@gist.github.com:%@.git", dict[@"id"] ];
    }
    return self;
}

@end
