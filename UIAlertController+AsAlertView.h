//
//  UIAlertController+AsAlertView.h
//
//  Created by DimasSup on 03.02.16.
//

#import <UIKit/UIKit.h>

NS_CLASS_AVAILABLE_IOS(8_0) @protocol UIAlertViewDelegate_Modern <NSObject>
@optional
// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)alertView:(nonnull UIAlertController *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

- (void)alertView:(nonnull UIAlertController *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex; // before animation and hiding view
- (void)alertView:(nonnull UIAlertController *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;  // after animation

@end

@interface UIAlertController (AsAlertView)
+(nonnull UIAlertController*)initWithTitle:(nullable NSString *)title message:(nullable __weak NSString *)message delegate:(nullable id <UIAlertViewDelegate_Modern>)delegate cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

-(NSInteger)cancelButtonIndex;
-(void)show;
@end
