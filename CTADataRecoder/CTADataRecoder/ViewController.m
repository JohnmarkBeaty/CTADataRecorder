//
//  ViewController.m
//  CTADataRecoder
//
//  Created by Eddie Koranek on 7/23/14.
//  Copyright (c) 2014 Eddie Koranek. All rights reserved.
//

#import "ViewController.h"
#import <sqlite3.h>



@interface ViewController ()

@property(nonatomic, retain)IBOutlet CLLocationManager *locationManager;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
    
    
    
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:102.0/255.0 green:245.0/255.0 blue:149.0/255.0 alpha:1];
    [_locationManager requestAlwaysAuthorization];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
