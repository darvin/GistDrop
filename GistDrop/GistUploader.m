//
//  GistUploader.m
//  GistDrop
//
//  Created by Sergey Klimov on 1/13/13.
//  Copyright (c) 2013 Sergey Klimov. All rights reserved.
//

#import "GistUploader.h"
#import <UAGithubEngine/UAGithubEngine.h>
#import <taskit/Taskit.h>
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


-(BOOL) postText:(NSString*) text filename:(NSString*) filename description:(NSString*)description callback:(GistUploaderResponseBlock) callback {
    if (!filename) {
        filename = @"file.txt"; //TODO autodetect file type
        
    }
    
    
    NSDictionary* gistDict = @{
    @"description": description?description:@"",
        @"public": @YES,
        @"files": @{
            filename: @{
                @"content": text
            }
        }
    };
    
    
    [_engine createGist:gistDict success:^(id response) {
        Gist* gist = [[Gist alloc] initWithGithubEngineResponse:[response lastObject]];
        callback(nil, gist);
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
        callback(error, nil);
    }];
    return YES;
}

-(NSString*) launchExec:(NSString*)exePath withArguments:(NSArray*) arguments inDirectory:(NSString*) directory {
    NSTask *task = [NSTask new];
    [task setLaunchPath:exePath];
    [task setArguments:arguments];
    if ([directory length])
        [task setCurrentDirectoryPath:directory];
    
    NSPipe *pipe = [NSPipe pipe];
    [task setStandardOutput:pipe];
    
    [task launch];
    
    NSData *data = [[pipe fileHandleForReading] readDataToEndOfFile];
    
    [task waitUntilExit];
    
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}

-(NSString*) createTemporaryDirectory {
    NSString *tempDirectoryTemplate =
    [NSTemporaryDirectory() stringByAppendingPathComponent:@"myapptempdirectory.XXXXXX"];
    const char *tempDirectoryTemplateCString =
    [tempDirectoryTemplate fileSystemRepresentation];
    char *tempDirectoryNameCString =
    (char *)malloc(strlen(tempDirectoryTemplateCString) + 1);
    strcpy(tempDirectoryNameCString, tempDirectoryTemplateCString);
    
    char *result = mkdtemp(tempDirectoryNameCString);
    if (!result)
    {
        return nil;
    }
    
    NSString *tempDirectoryPath =
    [[NSFileManager defaultManager]
     stringWithFileSystemRepresentation:tempDirectoryNameCString
     length:strlen(result)];
    free(tempDirectoryNameCString);
    return tempDirectoryPath;
}

-(void) updateRepo:(NSString*)gitRepoUrl fileNamed:(NSString*)filename withContentsOfURL:(NSURL*) url callback:(void (^)(NSError*)) callback {
    if (![gitRepoUrl length]) {
        callback([NSError errorWithDomain:@"gistdrop" code:1 userInfo:@{NSLocalizedDescriptionKey:@"git repo link suppose to be here"}]);
        return;
    }
    NSString* git = [[NSBundle mainBundle] pathForResource:@"git" ofType:nil inDirectory:@"git/bin/"];
    
    git = [[self launchExec:@"/usr/bin/which" withArguments:@[@"git"] inDirectory:nil] stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    
    NSString* td = [self createTemporaryDirectory];
    
    if (![td length]) {
        callback([NSError errorWithDomain:@"gistdrop" code:2 userInfo:@{NSLocalizedDescriptionKey:@"temporary directory cannot be created"}]);
        return;
    };

    
    NSString *gitClone = [self launchExec:git withArguments:@[@"clone", gitRepoUrl, @"./"] inDirectory:td];
    
    
    NSLog(@"done");
}


-(BOOL) postFileAtURL:(NSURL *)url description:(NSString *)description callback:(GistUploaderResponseBlock)callback {
    NSString* filename = [url lastPathComponent];
    [self postText:@"--this is temporary content--" filename:filename description:description callback:^(NSError *error, Gist *g) {
        if (error)
            callback(error,nil);
        else
            [self updateRepo:g.gitRepo fileNamed:filename withContentsOfURL:url callback:^(NSError* error){
            if (error)
                callback(error,nil);
            else
                callback(nil, g);
        }];
    }];
    
    return YES;
}

@end
