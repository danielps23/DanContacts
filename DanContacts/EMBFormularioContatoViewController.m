//
//  EMBFormularioContatoViewController.m
//  DanContacts
//
//  Created by ios3345 on 05/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EMBFormularioContatoViewController.h"
#import "Contato.h"
#import <CoreLocation/CoreLocation.h>

@implementation EMBFormularioContatoViewController
@synthesize botaoFoto;
@synthesize latitude;
@synthesize longitude;

@synthesize nome, telefone, email, endereco, site;
@synthesize contato, delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithContato:(Contato *)_contato {
    self = [super init];
    if (self) {
        self.contato = _contato;
        
        UIBarButtonItem *confirmar = [[UIBarButtonItem alloc] initWithTitle:@"Confirmar" style:UIBarButtonItemStylePlain target:self action:@selector(atualizaContato)];
        self.navigationItem.rightBarButtonItem = confirmar;
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
    if (self.contato) {
        nome.text = contato.nome;
        telefone.text = contato.telefone;
        email.text = contato.email;
        endereco.text = contato.endereco;
        site.text = contato.site;
        latitude.text = [contato.latitude stringValue];
        longitude.text = [contato.longitude stringValue];
        if ( contato.foto ) {
            [botaoFoto setImage:contato.foto forState:UIControlStateNormal];
        }
    }
}

- (void)viewDidUnload
{
    [self setBotaoFoto:nil];
    [self setLatitude:nil];
    [self setLongitude:nil];
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
    if (!self.contato) {
        contato = [[Contato alloc] init];
    }
    
    contato.nome = self.nome.text;
    contato.telefone = self.telefone.text;
    contato.email = self.email.text;
    contato.endereco = self.endereco.text;
    contato.site = self.site.text;
    contato.latitude = [NSNumber numberWithFloat:[latitude.text floatValue]];
    contato.longitude = [NSNumber numberWithFloat:[longitude.text floatValue]];
    if (botaoFoto.imageView.image) {
        contato.foto = botaoFoto.imageView.image;         
    }
    
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

- (void) atualizaContato {
    Contato *contatoAtualizado = [self pegaDadosDoFormulario];
    [self.navigationController popViewControllerAnimated:YES];
    
    if (self.delegate) {
        [self.delegate contatoAtualizado:contatoAtualizado];
    }
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
    Contato *novoContato = [self pegaDadosDoFormulario];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (self.delegate) {
        [self.delegate contatoAdicionado:novoContato];
    }
}

- (IBAction)selecionaFoto:(id)sender {
    if ( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ) {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Escolha a foto do contato" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Tirar foto", @"Escolher da biblioteca", nil];
        [ sheet showInView:self.view];
    } else {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = YES;
        picker.delegate = self;
        [self presentModalViewController:picker animated:YES];
    }
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *imagemSelecionada = [info valueForKey:UIImagePickerControllerEditedImage];
    [botaoFoto setImage:imagemSelecionada forState:UIControlStateNormal];
    [picker dismissModalViewControllerAnimated:YES];
}

- (void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    switch (buttonIndex) {
        case 0:
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        case 1:
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;    
        default:
            break;
    }
    
    [self presentModalViewController:picker animated:YES];
}

- (IBAction)buscarCoordenadas:(id)sender {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:endereco.text completionHandler:
     ^(NSArray *resultados, NSError *error) {
         if ( ( error == nil ) && ([resultados count] > 0)) {
             CLPlacemark *resultado = [resultados objectAtIndex:0];
             CLLocationCoordinate2D coordenada = resultado.location.coordinate;
             latitude.text = [NSString stringWithFormat:@"%f", coordenada.latitude];
             longitude.text = [NSString stringWithFormat:@"%f", coordenada.longitude];
         }
     }
     ];
}

@end
