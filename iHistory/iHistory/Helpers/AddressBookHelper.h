//
//  AddressBookHelper.h
//  EKS
//
//  Created by ligh on 14/12/1.
//
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

//通讯录联系人
@interface AddressBookPerson : NSObject <NSCopying>

@property (retain,nonatomic) NSString *name;
@property (retain,nonatomic) NSArray  *phones;


@end

//通讯录助手
@interface AddressBookHelper : NSObject

+(NSArray *) allAddressBookPersons;
+(AddressBookPerson *) personForABRecordRef:(ABRecordRef) personRef;


@end


