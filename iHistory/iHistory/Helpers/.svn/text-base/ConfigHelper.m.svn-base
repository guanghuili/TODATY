//
//  ConfigHelper.m
//  Carte
//
//  Created by ligh on 14-7-1.
//
//

#import "ConfigHelper.h"
#define ConfigStoreIDKey @"StoreIDKey"
#define YMKey @"YMKey"
#define KBaiduMapKey @"BaiduMapKey"
#define KAppleIDKey @"AppleID"

@implementation ConfigHelper

+(NSString *)storeID
{
    return [self objectForInfoDictionaryKey:ConfigStoreIDKey];
}


+(id) objectForInfoDictionaryKey:(NSString *) key
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:key];
}


+(NSString *)appScheme
{
    NSArray *schemes = [self objectForInfoDictionaryKey:@"CFBundleURLTypes"];
    for (NSDictionary *dic in schemes)
    {
        if ([dic[@"CFBundleURLName"] isEqualToString:@"appSchemes"])
        {
            return dic[@"CFBundleURLSchemes"][0];
        }
    }
    
    return @"PMSSchemes";
}

+(NSString *) YMAppKey
{
    return [self objectForInfoDictionaryKey:YMKey];
}

+(NSString *) BaiduMapKey
{
    return [self objectForInfoDictionaryKey:KBaiduMapKey];
}

+(NSString *) appleID
{
    return [self objectForInfoDictionaryKey:KAppleIDKey];
}



@end
