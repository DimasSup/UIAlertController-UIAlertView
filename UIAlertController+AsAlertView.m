//
//  UIAlertController+AsAlertView.m
//
//  Created by DimasSup on 03.02.16.
//

#import "UIAlertController+AsAlertView.h"
#import <objc/runtime.h>

@interface UIAlertController (iOS9TintFix)

+ (void)tintFix;

- (void)swizzledViewWillAppear:(BOOL)animated;

@end

@implementation UIAlertController (iOS9TintFix)

+ (void)tintFix {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		Method method  = class_getInstanceMethod(self, @selector(viewWillAppear:));
		Method swizzle = class_getInstanceMethod(self, @selector(swizzledViewWillAppear:));
		method_exchangeImplementations(method, swizzle);
		
		
		method  = class_getInstanceMethod(self, @selector(viewWillTransitionToSize:withTransitionCoordinator:));
		swizzle = class_getInstanceMethod(self, @selector(swizzledViewWillTransitionToSize:withTransitionCoordinator:));
		method_exchangeImplementations(method, swizzle);
	});
}

- (void)swizzledViewWillAppear:(BOOL)animated {
	[self swizzledViewWillAppear:animated];
	for (UIView *view in self.view.subviews) {
		if (view.tintColor == self.view.tintColor) {
			//only do those that match the main view, so we don't strip the red-tint from destructive buttons.
			self.view.tintColor = [UIColor colorWithRed:0.000 green:0.478 blue:1.000 alpha:1.000];
			[view setNeedsDisplay];
		}
	}
}
-(void)swizzledViewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
	[self swizzledViewWillTransitionToSize:size withTransitionCoordinator:coordinator];
	for (UIView *view in self.view.subviews) {
		if (view.tintColor == self.view.tintColor) {
			//only do those that match the main view, so we don't strip the red-tint from destructive buttons.
			self.view.tintColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
			[view setNeedsDisplay];
		}
	}
}

@end




@implementation UIAlertController (AsAlertView)
+(void)initialize
{
	[super initialize];
	[self tintFix];
}

+(nonnull UIAlertController*)initWithTitle:(NSString *)title message:(NSString *)message delegate:(__weak id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString*)otherButtonTitles,...
{
	UIAlertController* controller = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
	
	NSMutableArray *tmplist = [NSMutableArray arrayWithObject:otherButtonTitles];
	if(otherButtonTitles!=nil)
	{
		va_list args;
		va_start(args,otherButtonTitles);
		
		id arg;
		while((arg = va_arg(args, id)) != nil)
			[tmplist addObject:arg];
		
		va_end(args);
	}
	int c = 0;
	
	if(tmplist.count<=1)
	{
		[controller addAction:[UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
			int c2 = c;
			if([delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]){
				[delegate alertView:controller clickedButtonAtIndex:c2];
			}
			if([delegate respondsToSelector:@selector(alertView:willDismissWithButtonIndex:)]){
				[delegate alertView:controller willDismissWithButtonIndex:c2];
			}
			if([delegate respondsToSelector:@selector(alertView:didDismissWithButtonIndex:)]){
				[delegate alertView:controller didDismissWithButtonIndex:c2];
			}
			
		}]];
		c++;
	}
	
	for (NSString* arg  in tmplist)
	{
		[controller addAction:[UIAlertAction actionWithTitle:arg style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
			int c2 = c;
			if([delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]){
				[delegate alertView:controller clickedButtonAtIndex:c2];
			}
			if([delegate respondsToSelector:@selector(alertView:willDismissWithButtonIndex:)]){
				[delegate alertView:controller willDismissWithButtonIndex:c2];
			}
			if([delegate respondsToSelector:@selector(alertView:didDismissWithButtonIndex:)]){
				[delegate alertView:controller didDismissWithButtonIndex:c2];
			}
			
		}]];
		c++;
		
	}
	if(tmplist.count>1)
	{
		[controller addAction:[UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
			int c2 = c;
			if([delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]){
				[delegate alertView:controller clickedButtonAtIndex:c2];
			}
			if([delegate respondsToSelector:@selector(alertView:willDismissWithButtonIndex:)]){
				[delegate alertView:controller willDismissWithButtonIndex:c2];
			}
			if([delegate respondsToSelector:@selector(alertView:didDismissWithButtonIndex:)]){
				[delegate alertView:controller didDismissWithButtonIndex:c2];
			}
			
		}]];
		c++;
	}
	
	
	return controller;
}
-(void)show
{
	UIViewController* vc = [[UIApplication sharedApplication].keyWindow rootViewController];
	if(vc)
	{
		[vc presentViewController:self animated:YES completion:^{
			
		}];
	}
}
-(NSInteger)cancelButtonIndex
{
	return [self.actions indexOfObjectPassingTest:^BOOL(UIAlertAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		if(obj.style == UIAlertActionStyleCancel)
		{
			*stop = YES;
			return YES;
		}
		return NO;
	}];
}

@end
