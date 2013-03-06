//
//  EMBListaContatosViewController.h
//  DanContacts
//
//  Created by ios3345 on 05/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMBListaContatosViewController : UITableViewController

@property(strong) NSMutableArray *contatos;

@property(strong) NSMutableDictionary *sections;

- (void) createSections;
- (void) populateSections;
- (NSArray *) orderedSections;

@end
