//
//  EMBListaContatosProtocol.h
//  DanContacts
//
//  Created by ios3345 on 07/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contato.h"

@protocol EMBListaContatosProtocol <NSObject>

- (void) contatoAdicionado:(Contato *) contato;
- (void) contatoAtualizado:(Contato *) contato;

@end
