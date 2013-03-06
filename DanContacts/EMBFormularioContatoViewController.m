//
//  EMBFormularioContatoViewController.m
//  DanContacts
//
//  Created by ios3345 on 05/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EMBFormularioContatoViewController.h"
#import "Contato.h"

@implementation EMBFormularioContatoViewController

@synthesize nome, telefone, email, endereco, site;
@synthesize contatos;

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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (id) init {
    self = [super init];
    if ( self ) {
        self.navigationItem.title =@"Cadastro";
        
        UIBarButtonItem *cancela = [[UIBarButtonItem alloc] initWithTitle:@"Cancela" style:UIBarButtonItemStylePlain target:self action:@selector(escondeFormulario)];
        self.navigationItem.leftBarButtonItem = cancela;
        
        UIBarButtonItem *adiciona = [[UIBarButtonItem alloc] initWithTitle:@"Adiciona" style:UIBarButtonItemStylePlain target:self action:@selector(criaContato)];
        self.navigationItem.rightBarButtonItem = adiciona;
    }
    
    return self;
}

- (Contato *) pegaDadosDoFormulario {
    Contato *contato = [[Contato alloc] init];
    contato.nome = self.nome.text;
    contato.telefone = self.telefone.text;
    contato.email = self.email.text;
    contato.endereco = self.endereco.text;
    contato.site = self.site.text;
    
    return contato;
//    NSLog(@"contato com nome: %@", contato.nome);
    
//    [self.contatos addObject:contato];
    
//    [self.view endEditing:YES];
    
//    [site resignFirstResponder];
    
//    NSMutableDictionary *dadosDoContato = [[NSMutableDictionary alloc] init];
//    [dadosDoContato setObject:[nome text] forKey:@"nome"];
//    [dadosDoContato setObject:[telefone text] forKey:@"telefone"];
//    [dadosDoContato setObject:[email text] forKey:@"email"];
//    [dadosDoContato setObject:[endereco text] forKey:@"endereco"];
//    [dadosDoContato setObject:[site text] forKey:@"site"];
//    NSLog(@"dados: %@", dadosDoContato);
}

- (IBAction)proximoElemento:(UITextField *)sender {
    if ( sender == self.nome ) {
        [self.telefone becomeFirstResponder];
    } else if ( sender == self.telefone ) {
        [self.email becomeFirstResponder];
    } else if ( sender == self.email ) {
        [self.endereco becomeFirstResponder];
    } else if ( sender == self.endereco ) {
        [self.site becomeFirstResponder];
    } else if ( sender == self.site ) {
        [self.email resignFirstResponder];
    }
}

- (void) escondeFormulario {
    [self dismissModalViewControllerAnimated:YES];
}

- (void) criaContato {
    Contato *contato = [self pegaDadosDoFormulario];
    [self.contatos addObject:contato];
    NSLog(@"Contatos cadastrados: %d", self.contatos.count);
    [ self dismissModalViewControllerAnimated:YES];
}

@end
