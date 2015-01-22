//
//  AppSheetPicker.m
//  EKS
//
//  Created by ligh on 14/12/5.
//
//

#import "AppSheetPicker.h"

@interface AppSheetPicker()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    
    IBOutlet UIPickerView   *_pickerView;
    
    NSArray                 *_itemArray;
}
@end

@implementation AppSheetPicker

- (void)dealloc
{
    RELEASE_SAFELY(_actionBlock);
    RELEASE_SAFELY(_itemArray);
    RELEASE_SAFELY(_pickerView);
    [super dealloc];
}


-(void)showPickerInView:(UIView *)inView withItemArray:(NSArray *)itemArray withBlock:(AppSheetPickerBlock)block
{
    RELEASE_SAFELY(_itemArray);
    RELEASE_SAFELY(_actionBlock);
    _itemArray = [itemArray retain];
    
    _actionBlock = [block copy];
    
    [_pickerView reloadAllComponents];
    
    [self showPickerInView:inView];
    
}

#pragma mark UIPickerViewDataSource

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _itemArray[row];
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _itemArray.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

#pragma mark UIPickerViewDelegate
-(void)okAction:(id)sender
{
    
    if (_actionBlock)
    {
        NSInteger selectedRow = [_pickerView selectedRowInComponent:0];
        _actionBlock(selectedRow,_itemArray[selectedRow]);
    }
    
    [self dismissPicker];
    
}

@end
