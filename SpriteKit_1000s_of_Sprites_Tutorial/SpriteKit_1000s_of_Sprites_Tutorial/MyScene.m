//
//  MyScene.m
//  SpriteKit_1000s_of_Sprites_Tutorial
//
//  Created by Sam  keene on 2/01/14.
//  Copyright (c) 2014 Sam  keene. All rights reserved.
//

#import "MyScene.h"

@interface MyScene()
@property (nonatomic, strong) SKTexture     *canvasTexture; // final texture with all particles
@property (nonatomic, strong) SKSpriteNode  *canvasSprite;  // final sprite to display the texture in
@property (nonatomic, strong) SKNode        *canvasNode;    // the node to do all the sprite positional calculations in memory
@end

@implementation MyScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
    }
    return self;
}

- (void)setupLEDs
{
    self.backgroundColor = [SKColor blackColor];
    
    // create the particle texture
    SKTexture *ledTexture = [SKTexture textureWithImageNamed:@"whitePixel"];
    self.canvasNode = [SKNode node];
    
    // cycle through and throw as many sprites into the node as you want
    for (int i = 0; i < 5000; i++) {
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:ledTexture];
        sprite.position = CGPointMake(arc4random_uniform(320), arc4random_uniform(568));
        sprite.colorBlendFactor = 1.;
        [self.canvasNode addChild:sprite];
    }
    
    // create a texture from the node, even though it hasn't been added to the scene
    self.canvasTexture = [self.view textureFromNode:self.canvasNode];
    
    // only ever create one sprite from our node's texture
    self.canvasSprite = [SKSpriteNode spriteNodeWithTexture:self.canvasTexture size:self.frame.size];
    
    // need to update the anchor point as the texture is centered in the sprite
    self.canvasSprite.anchorPoint = CGPointMake(0, 0);
    
    // add the sprite, notice this only happens once as this has overhead
    [self addChild:self.canvasSprite];
    
}


-(void)update:(CFTimeInterval)currentTime {
    
    // cycle through the children of the sprite and reposition
    // this is where most of the heavy lifting now happens, as opposed to at the drawing stage
    
    for (SKSpriteNode *sprite in self.canvasNode.children) {
        UIColor *randColor = (arc4random_uniform(10) >= 5) ? [UIColor redColor] : [UIColor greenColor];
        sprite.position = CGPointMake(arc4random_uniform(320), arc4random_uniform(568));
        [sprite setColor:randColor];
    }
    
    // re-draw the texture from the node hierarchy
    self.canvasTexture = [self.view textureFromNode:self.canvasNode];
    
    // swap out the old texture with the new one in our sprite << One OpenGL draw
    self.canvasSprite.texture = self.canvasTexture;
}

@end
