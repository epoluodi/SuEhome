//
//  HttpFile.m
//  SuEhome
//
//  Created by Stereo on 2016/11/8.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "HttpFile.h"
#import <Common/FileCommon.h>
@implementation HttpFile


-(instancetype)init:(FILETYPE)filetype
{
    _fileType = filetype;
    self = [super init];
    return self;
}


-(NSData *)downloadFile:(NSString *)mediaid fileSize:(NSString *)filesize
{
    _http.WebServiceUrl = DownFile;

    
    [_http addParamsString:@"mediaId" values:mediaid];
    [_http addParamsString:@"imgSize" values:filesize];
    NSData *data = [_http httprequest:[_http getDataForArrary]];
    if (!data )
        return nil;
    if (data.length <= 50)
        return nil;

    NSFileManager *filenamger = [NSFileManager defaultManager];
    NSString *path = [FileCommon getCacheDirectory];
    NSString *strfiletype;
    switch (_fileType) {
        case JPG:
            strfiletype = @".jpg";
            break;
            
        case AAC:
            strfiletype = @".aac";
            break;
    }
    
    NSString* _filename = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@%@",mediaid,filesize,  strfiletype]];
    NSLog(@"下载文件存储: %@",_filename);
    [filenamger createFileAtPath:_filename contents:data attributes:nil];
    return data;
}

@end
