//
//  ViewController.m
//  KeyboardNotificationTest
//
//  Created by yopi on 2013/03/03.
//  Copyright (c) 2013年 yopi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,retain)UITextField* textField;
@property (nonatomic,retain)UIButton* resignButton;
@property (nonatomic,retain)UIView* toolbar;
-(void)hideKeyboard:(NSNotification*) notivication;
-(void)keyboardWillShow:(NSNotification*) notification;
-(void)keyboardDidShow:(NSNotification*) notification;
-(void)keyboardWillHide:(NSNotification*) notification;
-(void)keyboardDidHide:(NSNotification*) notification;
-(void)keyboardWillFrameChange:(NSNotification*) notivication;
-(void)keyboardDidFrameChange:(NSNotification*) notification;


@end

@implementation ViewController

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
  return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  self.view.backgroundColor = [UIColor lightGrayColor];
  
  self.textField = [[[UITextField alloc] initWithFrame:CGRectMake(100,self.view.frame.size.height - 40, 200, 40)] autorelease];
  self.textField.backgroundColor = [UIColor whiteColor];
  self.textField.borderStyle = UITextBorderStyleRoundedRect;
  self.textField.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
  [self.view addSubview:self.textField];

  self.resignButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  self.resignButton.frame = CGRectMake(220, 30, 60, 44);
  [self.resignButton setTitle:@"resign" forState:UIControlStateNormal];
  [self.resignButton addTarget:self action:@selector(hideKeyboard) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:self.resignButton];
  
  self.toolbar = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 44)] autorelease];
  self.toolbar.backgroundColor = [UIColor blackColor];
  self.textField.inputAccessoryView = self.toolbar;

  
  //set notification
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
  
 // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
  
 // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];

//  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
  
//  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidFrameChange:) name:UIKeyboardDidChangeFrameNotification object:nil];



}

- (void)dealloc
{
  self.textField = nil;
  self.resignButton = nil;
  self.toolbar = nil;
  [super dealloc];
}

-(void)hideKeyboard {
  if ([self.textField canResignFirstResponder]) {
    [self.textField resignFirstResponder];
  }
}

-(void)keyboardWillShow:(NSNotification*)notification
{
  NSLog(@"keyboard will show");
  [self printKeyboardRect:notification];
}

-(void)keyboardDidShow:(NSNotification*)notification
{
  NSLog(@"keyboard did show");
  [self printKeyboardRect:notification];

}

-(void)keyboardWillHide:(NSNotification*)notification
{
  NSLog(@"keyboard will hide");
  [self printKeyboardRect:notification];

}

-(void)keyboardDidHide:(NSNotification*)notification
{
  NSLog(@"keyboard did hide");
  [self printKeyboardRect:notification];

}

-(void)keyboardWillFrameChange:(NSNotification*)notification
{
  NSLog(@"keyboard will frame change");
  [self printKeyboardRect:notification];

}

-(void)keyboardDidFrameChange:(NSNotification*)notification
{
  NSLog(@"keyboard did frame change");
  [self printKeyboardRect:notification];

}

-(void)printKeyboardRect:(NSNotification*)notification
{
  CGRect keyboardRect;
  keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
  keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
  
  CGFloat height = keyboardRect.origin.y - self.textField.frame.size.height;

  if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    // iPad
    if (height + self.textField.frame.size.height + self.toolbar.frame.size.height == self.view.frame.size.height) {
      height += self.toolbar.frame.size.height;
    }
  }else {
    height = keyboardRect.origin.y - self.textField.frame.size.height;
  }
  
  self.textField.frame = CGRectMake(100,
                                    height,
                                    self.textField.frame.size.width,self.textField.frame.size.height);
  
  
  NSLog(@"  keyboardRect=%@",NSStringFromCGRect(keyboardRect));
}



@end
