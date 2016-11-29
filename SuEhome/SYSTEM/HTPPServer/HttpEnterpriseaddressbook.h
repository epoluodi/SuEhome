//
//  HttpEnterpriseaddressbook.h
//  SuEhome
//
//  Created by Stereo on 2016/11/28.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "BaseHttp.h"
#import "DBmanger.h"
#define ORGQUERYURL  [NSString stringWithFormat:@"%@addrbook/org/query",IMUrl]
#define DEPTQUERYURL  [NSString stringWithFormat:@"%@addrbook/dept/query",IMUrl]
#define MEMBERQUERYURL  [NSString stringWithFormat:@"%@addrbook/user/query",IMUrl]

@interface HttpEnterpriseaddressbook : BaseHttp


-(ReturnData *)queryOrg;
-(ReturnData *)queryDept;
-(ReturnData *)queryMember;
@end
