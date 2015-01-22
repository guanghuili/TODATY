//
//  AppTextView.m
//  EKS
//
//  Created by ligh on 14/12/5.
//
//

#import "AppTextView.h"

@implementation AppTextView

#pragma mark - 重写父类方法
- (void)setText:(NSString *)text {
    [super setText:text];
    [self drawPlaceholder];
    return;
}

- (void)setPlaceholder:(NSString *)placeholder {
    if (![placeholder isEqual:_placeholder]) {
        _placeholder = placeholder;
        [self drawPlaceholder];
    }
    return;
}

#pragma mark - 父类方法
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self configureBase];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
        {
    if (self = [super initWithFrame:frame]) {
        [self configureBase];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (_shouldDrawPlaceholder) {
        [_placeholderTextColor set];
        [_placeholder drawInRect:CGRectMake(8.0f, 8.0f, self.frame.size.width - 16.0f,
                                            self.frame.size.height - 16.0f) withFont:self.font];
    }
    return;
}

- (void)configureBase {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                            selector:@selector(textChanged:)
                                name:UITextViewTextDidChangeNotification
                              object:self];
    
    self.placeholderTextColor = [UIColor colorWithWhite:0.802f alpha:1.0f];
    _shouldDrawPlaceholder = NO;
    return;
}



- (void)drawPlaceholder
{
    BOOL prev = _shouldDrawPlaceholder;
    _shouldDrawPlaceholder = self.placeholder && self.placeholderTextColor && self.text.length == 0;
    
    if (prev != _shouldDrawPlaceholder) {
        [self setNeedsDisplay];
    }
    return;
}

- (void)textChanged:(NSNotification *)notification
{
    [self drawPlaceholder];
    self.text = [self.text stringByTrimmingCharactersInSet:NSCharacterSet.newlineCharacterSet];
    return;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
    [super dealloc];
}


@end
