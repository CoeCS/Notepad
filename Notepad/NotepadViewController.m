//
//  NotepadViewController.m
//  Notepad
//
//  Created by Donald Curtis on 1/29/13.
//  Copyright (c) 2013 Donald Curtis. All rights reserved.
//

#import "NotepadViewController.h"

@interface NotepadViewController ()
- (IBAction)doneButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *texterViewer;
@end

@implementation NotepadViewController

- (void)textViewShouldReturn:(UITextView *)textView {
    if (textView == self.texterViewer) {
        [textView resignFirstResponder];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:app];
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    // paths[0];
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
    
    if ([fileManager fileExistsAtPath:plistPath] == YES)
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
        self.texterViewer.text = [dict objectForKey:@"text"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneButton:(id)sender {
    NSLog(@"DONE BUTTON");
    [self.texterViewer resignFirstResponder];
}

- (void)applicationDidEnterBackground:(NSNotification *)notification {
    NSLog(@"Entering Background");
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    // paths[0];
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
    
    [[NSDictionary dictionaryWithObjectsAndKeys:self.texterViewer.text, @"text", nil] writeToFile:plistPath atomically:YES];
}

@end
