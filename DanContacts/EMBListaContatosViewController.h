//
//  EMBListaContatosViewController.h
//  DanContacts
//
//  Created by ios3345 on 05/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contato.h"

@interface EMBListaContatosViewController : UITableViewController

@property(strong) NSMutableArray *contatos;

@property(strong) NSMutableDictionary *sections;

- (void) createSections;
- (void) populateSections;
- (NSArray *) orderedSections;
- (NSMutableArray *) contatosBySection: (NSInteger)section;
- (Contato *) contatoBySection: (NSInteger)section row:(NSInteger)row;

@end
