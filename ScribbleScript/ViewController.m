//
//  SettingsViewController.h
//  ScribbleScript
//
//  Created by Lauren Morita on 5/20/14.
//  Copyright (c) 2014 CosmicLatté. All rights reserved.
//


#import "ViewController.h"
#import "Twitter/TWTweetComposeViewController.h"

@interface ViewController ()

@end

@implementation ViewController;
@synthesize mainImage;
@synthesize tempDrawImage;

- (void)viewDidLoad
{
    red = 0.0/255.0;
    green = 0.0/255.0;
    blue = 0.0/255.0;
    brush = 10.0;
    opacity = 1.0;
    
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self setMainImage:nil];
    [self setTempDrawImage:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
/*
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
*/
- (IBAction)colorSelected: (id)sender {
    
    UIButton *selectedColor = (UIButton*)sender;
    
    switch(selectedColor.tag)
    {
        case 0://red
            red = 234.0/255.0;
            green = 56.0/255.0;
            blue = 46.0/255.0;
            break;
        case 1: //orange
            red = 248.0/255.0;
            green = 156.0/255.0;
            blue = 39.0/255.0;
            break;
        case 2: //yellow (darker)
            red = 255.0/255.0;
            green = 253.0/255.0;
            blue = 56.0/255.0;
            break;
        case 3: //lighter yellow
            red = 249.0/255.0;
            green = 252.0/255.0;
            blue = 164.0/255.0;
            break;
        case 4: //lime green
            red = 171.0/255.0;
            green = 253.0/255.0;
            blue = 57.0/255.0;
            break;
        case 5: //med green
            red = 99.0/255.0;
            green = 184.0/255.0;
            blue = 77.0/255.0;
            break;
        case 6: //dark green
            red = 13.0/255.0;
            green = 113.0/255.0;
            blue = 61.0/255.0;
            break;
        case 7: //aqua
            red = 199.0/255.0;
            green = 221.0/255.0;
            blue = 242.0/255.0;
            break;
        case 8: //lightest blue
            red = 20.0/255.0;
            green = 115.0/255.0;
            blue = 251.0/255.0;
            break;
        case 9: //medium blue
            red = 27.0/255.0;
            green = 76.0/255.0;
            blue = 175.0/255.0;
            break;
        case 10: //dk blue
            red = 19.0/255.0;
            green = 13.0/255.0;
            blue = 117.0/255.0;
            break;
        case 11: //light purple
            red = 162.0/255.0;
            green = 28.0/255.0;
            blue = 196.0/255.0;
            break;
        case 12: //dk purple
            red = 96.0/255.0;
            green = 49.0/255.0;
            blue = 142.0/255.0;
            break;
        case 13: //dk pink
            red = 252.0/255.0;
            green = 34.0/255.0;
            blue = 210.0/255.0;
            break;
        case 14: //light pink
            red = 245.0/255.0;
            green = 174.0/255.0;
            blue = 222.0/255.0;
            break;
        case 15: //tan
            red = 199.0/255.0;
            green = 151.0/255.0;
            blue = 101.0/255.0;
            break;
        case 16: //med brown
            red = 147.0/255.0;
            green = 102.0/255.0;
            blue = 56.0/255.0;
            break;
        case 17: //grey
            red = 149.0/255.0;
            green = 149.0/255.0;
            blue = 149.0/255.0;
            break;
        case 18: //white
            red = 255.0/255.0;
            green = 255.0/255.0;
            blue = 255.0/255.0;
            break;
        case 19: //black
            red = 0.0/255.0;
            green = 0.0/255.0;
            blue = 0.0/255.0;
            break;
    }
    opacity = 1.0;
}

- (IBAction)eraserPressed:(id)sender {
    
    red = 255.0/255.0;
    green = 243.0/255.0;
    blue = 231.0/255.0;
    opacity = 1.0;
}


- (IBAction)reset:(id)sender {
    
    self.mainImage.image = nil;
    
}

- (IBAction)settings:(id)sender {
}

- (IBAction)save:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@""
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Save to Camera Roll", @"Tweet it!", @"Cancel", nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        Class tweeterClass = NSClassFromString(@"TWTweetComposeViewController");
        
        if(tweeterClass != nil) {   // check for Twitter integration
            
            // check Twitter accessibility and at least one account is setup
            if([TWTweetComposeViewController canSendTweet]) {
                
                UIGraphicsBeginImageContextWithOptions(self.mainImage.bounds.size, NO,0.0);
                [self.mainImage.image drawInRect:CGRectMake(0, 0, self.mainImage.frame.size.width, self.mainImage.frame.size.height)];
                UIImage *SaveImage = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                
                TWTweetComposeViewController *tweetViewController = [[TWTweetComposeViewController alloc] init];
                // set initial text
                [tweetViewController setInitialText:@"Check out this drawing I made from a tutorial on raywenderlich.com:"];
                
                // add image
                [tweetViewController addImage:SaveImage];
                tweetViewController.completionHandler = ^(TWTweetComposeViewControllerResult result) {
                    if(result == TWTweetComposeViewControllerResultDone) {
                        // the user finished composing a tweet
                    } else if(result == TWTweetComposeViewControllerResultCancelled) {
                        // the user cancelled composing a tweet
                    }
                    [self dismissViewControllerAnimated:YES completion:nil];
                };
                
                [self presentViewController:tweetViewController animated:YES completion:nil];
            } else {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"You can't send a tweet right now, make sure you have at least one Twitter account setup and your device is using iOS5" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
            }
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"You must upgrade to iOS5.0 in order to send tweets from this application" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
        
    } else if(buttonIndex == 0) {
        
        UIGraphicsBeginImageContextWithOptions(self.mainImage.bounds.size, NO, 0.0);
        [self.mainImage.image drawInRect:CGRectMake(0, 0, self.mainImage.frame.size.width, self.mainImage.frame.size.height)];
        UIImage *SaveImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        UIImageWriteToSavedPhotosAlbum(SaveImage, self,@selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    // Was there an error?
    if (error != NULL)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Image could not be saved.Please try again"  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Close", nil];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Image was successfully saved in photoalbum"  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Close", nil];
        [alert show];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    lastPoint = [touch locationInView:self.view];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush );
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.tempDrawImage setAlpha:opacity];
    UIGraphicsEndImageContext();
    
    lastPoint = currentPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if(!mouseSwiped) {
        UIGraphicsBeginImageContext(self.view.frame.size);
        [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, opacity);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    UIGraphicsBeginImageContext(self.mainImage.frame.size);
    [self.mainImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:opacity];
    self.mainImage.image = UIGraphicsGetImageFromCurrentImageContext();
    self.tempDrawImage.image = nil;
    UIGraphicsEndImageContext();
}

/*- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    SettingsViewController * settingsVC = (SettingsViewController *)segue.destinationViewController;
    settingsVC.delegate = self;
    settingsVC.brush = brush;
    settingsVC.opacity = opacity;
    settingsVC.red = red;
    settingsVC.green = green;
    settingsVC.blue = blue;
    
}*/

#pragma mark - SettingsViewControllerDelegate methods

- (void)closeSettings:(id)sender {
    
    brush = ((SettingsViewController*)sender).brush;
    opacity = ((SettingsViewController*)sender).opacity;
    red = ((SettingsViewController*)sender).red;
    green = ((SettingsViewController*)sender).green;
    blue = ((SettingsViewController*)sender).blue;
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
