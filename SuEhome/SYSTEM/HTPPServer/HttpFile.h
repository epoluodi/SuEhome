//
//  HttpFile.h
//  SuEhome
//
//  Created by Stereo on 2016/11/8.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "BaseHttp.h"
#define DownFile [NSString stringWithFormat:@"%@media/download",AppUrl]


typedef enum : NSUInteger {
    JPG,
    AAC,

} FILETYPE;

@interface HttpFile : BaseHttp
{
    FILETYPE _fileType;
}


-(instancetype)init:(FILETYPE) filetype;


-(NSData *)downloadFile:(NSString *)mediaid fileSize:(NSString *)filesize;


@end
