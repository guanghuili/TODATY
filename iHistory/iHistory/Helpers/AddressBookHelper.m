//
//  AddressBookHelper.m
//  EKS
//
//  Created by ligh on 14/12/1.
//
//

#import "AddressBookHelper.h"


@implementation AddressBookHelper


+(AddressBookPerson *)personForABRecordRef:(ABRecordRef)personRef
{

    AddressBookPerson *person = [[[AddressBookPerson alloc] init] autorelease];
    
    //读取firstname
    NSString *personName = (NSString*)ABRecordCopyValue(personRef, kABPersonFirstNameProperty);
    NSString *lastname = (NSString*)ABRecordCopyValue(personRef, kABPersonLastNameProperty);
    
    if([NSString isBlankString:personName])
    {
        personName = @"";
    }

    if ([NSString isBlankString:lastname])
    {
        lastname = @"";
    }
    
    person.name = [NSString stringWithFormat:@"%@%@",lastname,personName];
    
    NSMutableArray *personArray = [NSMutableArray array];
    person.phones = personArray;
    
    //读取电话多值
    ABMultiValueRef phone = ABRecordCopyValue(personRef, kABPersonPhoneProperty);
    for (int k = 0; k<ABMultiValueGetCount(phone); k++)
    {
        NSString * personPhone = (NSString*)ABMultiValueCopyValueAtIndex(phone, k);
        [personArray addObject:personPhone];
    }

    return person;
    
}

+(NSArray *)allAddressBookPersons
{
    NSMutableArray *personalArray = [NSMutableArray array];
    
    ABAddressBookRef addressBook = nil;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)
    {
        addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        //等待同意后向下执行
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error)
                                                 {
                                                     
                                                     dispatch_semaphore_signal(sema);
                                                     
                                                     
                                                 });
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        dispatch_release(sema);
    }
    else
    {
        addressBook = ABAddressBookCreate();
    }
    
    if(!addressBook)
    {
        return personalArray;
    }
    
    
    CFArrayRef results = ABAddressBookCopyArrayOfAllPeople(addressBook);
    
    for(int i = 0; i < CFArrayGetCount(results); i++)
    {
        ABRecordRef personRef = CFArrayGetValueAtIndex(results, i);
        AddressBookPerson *person = [self personForABRecordRef:personRef];
        [personalArray addObject:person];
    }
    
    
    CFRelease(results);
    CFRelease(addressBook);

    
    return personalArray;

}


@end



@implementation AddressBookPerson

-(void)dealloc
{
    RELEASE_SAFELY(_name);
    RELEASE_SAFELY(_phones);
    [super dealloc];
}


- (id)copyWithZone:(NSZone *)zone
{
    AddressBookPerson *addressBookPerson = [[AddressBookPerson alloc] init];
    addressBookPerson.name = [_name copy];
    addressBookPerson.phones =  [_phones copy];
    return addressBookPerson;
}

@end