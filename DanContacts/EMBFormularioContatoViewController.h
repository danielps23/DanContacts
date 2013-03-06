//
//  EMBFormularioContatoViewController.h
//  DanContacts
//
//  Created by ios3345 on 05/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contato.h"

@interface EMBFormularioContatoViewController : UIViewController

@property(nonatomic, weak) IBOutlet UITextField *nome;
@property(nonatomic, weak) IBOutlet UITextField *telefone;
@property(nonatomic, weak) IBOutlet UITextField *email;
@property(nonatomic, weak) IBOutlet UITextField *endereco;
@property(nonatomic, weak) IBOutlet UITextField *site;

@property(strong) NSMutableArray *contatos;

@property(strong) Contato *contato;

- (Contato *)pegaDadosDoFormulario;
- (void) atualizaContato;
- (IBAction)proximoElemento:(UITextField *)sender;

- (id) initWithContato:(Contato *)contato;


@end
