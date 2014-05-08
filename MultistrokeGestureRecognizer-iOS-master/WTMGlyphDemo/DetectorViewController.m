//
//  DetectorViewController.m
//  WTMGlyphDemo
//
//  Created by Prateek Pradhan on 03/01/14.
//  Copyright (c) 2014 torin.nguyen@2359media.com. All rights reserved.
//

#import "DetectorViewController.h"
#define GESTURE_SCORE_THRESHOLD         1.5f

@interface DetectorViewController () <WTMGlyphDelegate>

@end

@implementation DetectorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Auto Detect : OFF" style:UIBarButtonItemStyleBordered target:self action:@selector(autoDetectButtonClicked:)];
    item.tag = 1;
    self.navigationItem.leftBarButtonItem = item;
    self.detectorView.delegate = self;
    self.detectorView.frame = CGRectMake(0, 0, 587, 856);
    self.detectorView.disableAutoDetection = YES;
    self.detectorView.glyphDetector.timeoutSeconds = 10;
    self.detectButton.enabled = YES;
    
    self.detectorView.backgroundColor = [UIColor darkGrayColor];
    // Do any additional setup after loading the view from its nib.
    [self.detectorView loadTemplatesWithNames:@"A",@"V",@"P",@"T",@"B", nil];
    self.outputTextField.text = @"";
}
-(void)autoDetectButtonClicked:(UIBarButtonItem *)sender{
    if(sender.tag == 1){
        sender.title =@"Auto Detect : ON";
        sender.tag = 2;
        self.detectorView.disableAutoDetection = NO;
        self.detectorView.glyphDetector.timeoutSeconds = 5;
        self.detectButton.enabled = NO;
        
    }else{
        sender.title =@"Auto Detect : OFF";
         sender.tag = 1;
        self.detectorView.disableAutoDetection = YES;
        self.detectorView.glyphDetector.timeoutSeconds = 10;
        self.detectButton.enabled = YES;
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSString *glyphNames = [self.detectorView getGlyphNamesString];
    if ([glyphNames length] > 0) {
        NSString *statusText = [NSString stringWithFormat:@"   Loaded with %@ templates.\n\nStart drawing. ", glyphNames];
        self.infoLabel.text = statusText;

        
        
    }
}
#pragma mark WTMGlyphDetectorViewDelegate Methods
- (void)wtmGlyphDetectorView:(WTMGlyphDetectorView*)theView glyphDetected:(WTMGlyph *)glyph withScore:(float)score
{
    //Reject detection when quality too low
    if (score < GESTURE_SCORE_THRESHOLD){
        self.resultLabel.text = @"   No Match Found";
        return;
    }
    self.resultLabel.text  = [NSString stringWithFormat:@"   Gesture Detected:%@ score %.3f",glyph.name,score];
    self.outputTextField.text = [NSString stringWithFormat:@"%@%@",self.outputTextField.text,glyph.name];
   
}
- (void)glyphResults:(NSArray *)results{
    self.results = results;
    [self.leftColumnTable reloadData];
}
-(IBAction)detectButtonPressed:(id)sender{
    self.resultLabel.text =@"Detecting...";
    [self.detectorView logStrokes];
    [self.detectorView.glyphDetector detectGlyph];
    
}
-(IBAction)clearButtonPressed:(id)sender{
    self.outputTextField.text = @"";
}
#pragma mark tableViewDelegate Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.results.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *result =[self.results objectAtIndex:indexPath.row];
    UITableViewCell *cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSNumber *score = [result objectForKey:@"score"];
    cell.textLabel.text = [NSString stringWithFormat:@"Name:%@ Score:%.3f ",[result objectForKey:@"name"],[score floatValue]];
    return cell;
}

-(BOOL)shouldAutorotate{
    return NO;
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return NO;
}
@end
