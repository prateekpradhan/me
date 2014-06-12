//
//  ViewController.m
//  TextWriter
//
//  Created by Prateek Pradhan on 31/07/13.
//  Copyright (c) 2013 Tinyview. All rights reserved.
//

#import "ViewController.h"
#import "SmoothedBIView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)clearButtonPressed:(id)sender{
    SmoothedBIView *view = (SmoothedBIView *)self.view;
    [view clear];
    
}
-(IBAction)drawButtonPressed:(id)sender{
    SmoothedBIView *view = (SmoothedBIView *)self.view;
    [view drawCharacters];
    
}

@end
