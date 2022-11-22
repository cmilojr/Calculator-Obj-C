//
//  ViewController.m
//  Calculator
//
//  Created by Camilo Jimenez on 22/11/22.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self lblExpression] setText: @""];
    [[self lblResult] setText: @"= "];
}


// all action buttons pressed
- (IBAction) btnAction: (UIButton *) sender {
    
    //check if Expression is exists
    if([[[self lblExpression] text] length] == 0){
        return;
    }
    
    NSString *mul = @"x";
    NSString *div = @"/";
    
    //check action is multiply or divition
    if([[[sender titleLabel] text] isEqualToString: mul] || [[[sender titleLabel] text] isEqualToString: div]) {
        
        //add parenthesis
        NSString *expression = [NSString stringWithFormat:@"(%@)%@", [[self lblExpression] text], [[sender titleLabel] text]];
        [[self lblExpression] setText: expression];
    }
    else{
        NSString *expression = [NSString stringWithFormat:@"%@%@", [[self lblExpression] text], [[sender titleLabel] text]];
        [[self lblExpression] setText: expression];
    }
    
    //initialize result
    [[self lblResult] setText: @"= "];
}

//Eqal button pressed
- (IBAction) btnEqal: (UIButton *) sender {
    
    //check if expression is exists
    if([[[self lblExpression] text] length] == 0){
        return;
    }
    
    @try {
        //add one decimal point to last number to get result as recimal points
        NSString *numericExpression = [NSString stringWithFormat: @"%@.0", [[self lblExpression] text]];
        
        //replace '*' instead of 'x'
        numericExpression = [numericExpression stringByReplacingOccurrencesOfString: @"x"
                                                                         withString:@"*"];
        
        NSExpression *expression = [NSExpression expressionWithFormat: numericExpression];
        
        NSNumber *result = [expression expressionValueWithObject: nil
                                                         context: nil];
        
        NSLog(@"%@", [NSString stringWithFormat:@"%@", result]);
        [[self lblResult] setText: [NSString stringWithFormat:@"= %@", result]];
    } @catch (NSException *exception) {
        NSLog(@"%@", [exception reason]);
        
        [self displayAlert];
    } @finally {}
}

- (IBAction)btnClear:(UIButton *)sender {
    
    //check if expression is exists
    if([[[self lblExpression] text] length] == 0){
        return;
    }
    
    NSString *numericExpression = [[self lblExpression] text];
    
    //get last character
    NSString *lastChar = [numericExpression substringFromIndex: [numericExpression length] - 1];
    
    //check the char is '0)'
    if([lastChar isEqualToString:@")"]){
        
        //then delete '(' and ')'
        NSString *Prefix = @"(";
        NSString *Suffix = @")";
        NSRange needleRange = NSMakeRange([Prefix length],
                                          [numericExpression length] - [Prefix length] - [Suffix length]);
        numericExpression = [numericExpression substringWithRange: needleRange];
    }else{
        //remove last character
        numericExpression = [numericExpression substringToIndex: [numericExpression length] -1];
    }
    
    //update
    [[self lblExpression] setText: numericExpression];
    [[self lblResult] setText: @"= "];
}

- (IBAction)btnReset:(UIButton *)sender {
    [[self lblResult] setText: @"= "];
    [[self lblExpression] setText: @""];
}

- (IBAction)btnNumberClick:(UIButton *)sender {
    if([[[self lblExpression] text] length] != 0){
        NSString *lastChar = [[[self lblExpression] text] substringFromIndex: [[[self lblExpression] text] length] - 1];
        
        if([lastChar isEqualToString:@"."] && [[[sender titleLabel] text] isEqualToString:@"."]){
            return;
        }
    }
    
    //check if enterd double dot
    NSString *expression = [NSString stringWithFormat: @"%@%@", [[self lblExpression] text], [[sender titleLabel] text]];
    
    [[self lblExpression] setText: expression];
    [[self lblResult] setText: @"= "];
}

-(void) displayAlert{
    NSString *title = @"Alert";
    NSString *message = @"Incorrect Expression";
    NSString *okButtonText = @"ok";
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle: title
                                                                   message: message
                                                            preferredStyle: UIAlertControllerStyleAlert];
    
    UIAlertAction *okButton = [UIAlertAction actionWithTitle: okButtonText
                                                       style: UIAlertActionStyleCancel
                                                     handler: nil];
    
    [alert addAction: okButton];
    
    [self presentViewController:alert
                       animated: YES
                     completion: nil];
}
@end
