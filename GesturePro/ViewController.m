//
//  ViewController.m
//  GesturePro
//
//  Created by yike on 2017/8/24.
//  Copyright © 2017年 yike. All rights reserved.
//

#import "ViewController.h"
#import "UIView+YYAdd.h"

@interface DragBtnView : UIView{
    CGPoint startlocation;
    CGPoint position;
}
@property (nonatomic, strong)UIImage *contentImg;
@property (nonatomic, copy)NSString *name;
@end
@interface DragView : UIView {
    CGPoint startlocation;
    CGPoint position;
}
@property (nonatomic, strong) NSMutableArray *btnArr;
@property (nonatomic, strong) DragBtnView *upBtn;
@property (nonatomic, strong) DragBtnView *downBtn;
@property (nonatomic, strong) DragBtnView *rightBtn;
@property (nonatomic, strong) DragBtnView *leftBtn;
@end

@implementation DragBtnView

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)setContentImg:(UIImage *)contentImg {
    _contentImg = contentImg;
    self.layer.contents = (__bridge id _Nullable)(_contentImg.CGImage);
    
}

- (void)setName:(NSString *)name {
    _name = [name copy];
    self.layer.contents = _name;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    startlocation = [[touches anyObject] locationInView:self];
    position = self.center;
        self.backgroundColor = [UIColor whiteColor];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    self.center = position;
        self.backgroundColor = [UIColor redColor];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    self.center = CGPointMake(self.center.x + ([[touches anyObject] locationInView:self].x - startlocation.x), self.center.y + ([[touches anyObject] locationInView:self].y - startlocation.y));
    CGPoint tmp = [[touches anyObject] locationInView:self];
    
    if (tmp.x >= 0 && tmp.x <= self.width && tmp.y >= 0 && tmp.y <= self.height) {
        self.backgroundColor = [UIColor whiteColor];
    } else {
        self.backgroundColor = [UIColor redColor];
    }
}

@end
@implementation DragView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        [self setUI];
    }
    return self;
}

- (void)setUI {
    
    _leftBtn = [[DragBtnView alloc] init];
    _leftBtn.name = @"⏪";
    _leftBtn.backgroundColor = [UIColor redColor];
    
    
    
    _rightBtn = [[DragBtnView alloc] init];
    _rightBtn.name = @"⏩";
    _rightBtn.backgroundColor = [UIColor redColor];
    
    
    _upBtn = [[DragBtnView alloc] init];
    _upBtn.name = @"⏫";
    _upBtn.backgroundColor = [UIColor redColor];
    
    
    _downBtn = [[DragBtnView alloc] init];
    _downBtn.name = @"⏬";
    _downBtn.backgroundColor = [UIColor redColor];
    
    
    [self addSubview:_leftBtn];
    [self addSubview:_rightBtn];
    [self addSubview:_upBtn];
    [self addSubview:_downBtn];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    startlocation = [[touches anyObject] locationInView:self];
    position = self.center;
    
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    self.center = position;

}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
//    self.center = CGPointMake(self.center.x + ([[touches anyObject] locationInView:self].x - startlocation.x), self.center.y + ([[touches anyObject] locationInView:self].y - startlocation.y));
    
    CGPoint tmp = [[touches anyObject] locationInView:self];
    int i = 0;
    
    CGPoint leftP = [self convertPoint:tmp toView:_leftBtn];
    if (leftP.x >= 0 && leftP.x <= 100 && leftP.y >= 0 && leftP.y <= 100) {
        _leftBtn.backgroundColor = [UIColor whiteColor];
        i++;
    }
    
    
    CGPoint rightP = [self convertPoint:tmp toView:_rightBtn];
    if (rightP.x >= 0 && rightP.x <= 100 && rightP.y >= 0 && rightP.y <= 100) {
        _rightBtn.backgroundColor = [UIColor whiteColor];
        i++;
    }
    
    CGPoint upP = [self convertPoint:tmp toView:_upBtn];
    if (upP.x >= 0 && upP.x <= 100 && upP.y >= 0 && upP.y <= 100) {
        _upBtn.backgroundColor = [UIColor whiteColor];
        i++;
    }
    
    CGPoint downP = [self convertPoint:tmp toView:_downBtn];
    if (downP.x >= 0 && downP.x <= 100 && downP.y >= 0 && downP.y <= 100) {
        _downBtn.backgroundColor = [UIColor whiteColor];
        i++;
    }
    
    if (i == 0) {
        self.center = CGPointMake(self.center.x + ([[touches anyObject] locationInView:self].x - startlocation.x), self.center.y + ([[touches anyObject] locationInView:self].y - startlocation.y));
        
    }
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect leftR = {{0, self.width / 3}, {self.width / 3, self.width / 3}};
    _leftBtn.frame = leftR;
    
    CGRect rightR = {{self.width * 2 / 3, self.width / 3}, {self.width / 3, self.width / 3}};
    _rightBtn.frame = rightR;
    
    CGRect upR = {{self.width / 3, 0}, {self.width / 3, self.width / 3}};
    _upBtn.frame = upR;
    
    CGRect downR = {{self.width / 3, self.width * 2 / 3}, {self.width / 3, self.width / 3}};
    _downBtn.frame = downR;
    
}
@end
@interface ViewController ()
@property (nonatomic, strong)DragView *dragView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dragView = [[DragView alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
    _dragView.center = self.view.center;
    [self.view addSubview:_dragView];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end


