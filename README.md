# UIAlertController-UIAlertView

Use UIAlertController instead deprecated in 8.0 UIAlertView.

Expample:

**UIAlertView** Old
```objective-c
[[[UIAlertView alloc] initWithTitle:@"Title Text" message:@"Message Text" delegate:nil cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil] show];
```

with **UIAlertController+UIAlertView**
```objective-c
[[UIAlertController initWithTitle:@"Title Text" message:@"Message Text" delegate:nil cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil] show];
```

You can use delegate - **UIAlertViewDelegate_Modern** instead **UIAlertViewDelegate**
```objective-c
- (void)alertView:(nonnull UIAlertController *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
- (void)alertView:(nonnull UIAlertController *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex;
- (void)alertView:(nonnull UIAlertController *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex; 
```
All of them calling at the same time.
For any question or suggestion email me **dima.teleban@gmail.com**
