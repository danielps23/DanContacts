//
//  EMBContatosNoMapaViewController.m
//  DanContacts
//
//  Created by ios3345 on 08/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EMBContatosNoMapaViewController.h"

@implementation EMBContatosNoMapaViewController
@synthesize mapa;

- (id) init {
    if ( self = [super init] ) {
        UIImage *imageTabItem = [UIImage imageNamed:@"mapa-contatos.png"];
        UITabBarItem *tabItem = [[UITabBarItem alloc] initWithTitle:@"Mapa" image:imageTabItem tag:0];
        self.tabBarItem = tabItem;
        self.navigationItem.title = @"Localizacao";
    }
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    MKUserTrackingBarButtonItem *botaoLocalizacao = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapa];
    self.navigationItem.leftBarButtonItem = botaoLocalizacao;
}

- (void)viewDidUnload
{
    [self setMapa:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
