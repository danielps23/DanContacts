//
//  EMBListaContatosViewController.h
//  DanContacts
//
//  Created by ios3345 on 05/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contato.h"
#import "EMBListaContatosProtocol.h"
#import <MessageUI/MFMailComposeViewController.h>

@interface EMBListaContatosViewController : UITableViewController<EMBListaContatosProtocol, UIActionSheetDelegate,MFMailComposeViewControllerDelegate> {
    Contato *contatoLongPress;
}

@property(strong) NSMutableArray *contatos;

@property(strong) NSMutableDictionary *sections;

@property(strong) Contato *contatoSelecionado;

@property(strong) NSManagedObjectContext *contexto;

- (void) createSections;
- (void) populateSections;
- (NSArray *) orderedSections;
- (NSMutableArray *) contatosBySection: (NSInteger)section;
- (Contato *) contatoBySection: (NSInteger)section row:(NSInteger)row;
- (void) exibeMaisAcoes:(UIGestureRecognizer *) gesture;

- (void) ligar;
- (void) enviarEmail;
- (void) abrirSite;
- (void) mostrarMapa;

-(void)abrirAplicativoComURL:(NSString *) url;

@end
