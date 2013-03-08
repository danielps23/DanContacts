//
//  EMBFormularioContatoViewController.h
//  DanContacts
//
//  Created by ios3345 on 05/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contato.h"
#import "EMBListaContatosProtocol.h"

@interface EMBFormularioContatoViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>

@property(nonatomic, weak) IBOutlet UITextField *nome;
@property(nonatomic, weak) IBOutlet UITextField *telefone;
@property(nonatomic, weak) IBOutlet UITextField *email;
@property(nonatomic, weak) IBOutlet UITextField *endereco;
@property(nonatomic, weak) IBOutlet UITextField *site;
@property (weak, nonatomic) IBOutlet UIButton *botaoFoto;

@property(strong) Contato *contato;

@property(weak) id<EMBListaContatosProtocol> delegate;

- (Contato *)pegaDadosDoFormulario;
- (void) atualizaContato;
- (IBAction)proximoElemento:(UITextField *)sender;

- (id) initWithContato:(Contato *)contato;

- (IBAction)selecionaFoto:(id)sender;


@end
