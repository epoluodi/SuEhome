//
//  HttpEnterpriseaddressbook.h
//  SuEhome
//
//  Created by Stereo on 2016/11/28.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "BaseHttp.h"
#define ORGQUERYURL  [NSString stringWithFormat:@"%@addrbook/org/query",IMUrl]

@interface HttpEnterpriseaddressbook : BaseHttp


-(ReturnData *)queryOrg;


@end
