//
//  ViewController.h
//  Calculator
//
//  Created by Camilo Jimenez on 22/11/22.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@property (strong, nonatomic) IBOutlet UILabel *lblExpression;
@property (strong, nonatomic) IBOutlet UILabel *lblResult;

- (IBAction)btnAction:(UIButton *)sender;


- (IBAction)btnEqal:(UIButton *)sender;


- (IBAction)btnClear:(UIButton *)sender;

- (IBAction)btnReset:(UIButton *)sender;

- (IBAction)btnNumberClick:(UIButton *)sender;

@end

