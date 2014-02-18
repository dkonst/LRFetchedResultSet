//
//  KDOManagedObjectModelBuilder.h
//
//  Created by Konstantin Dorodov on 10.12.2013.
//

#import <Foundation/Foundation.h>

@class KDOEntityDefinition;

typedef void(^KDOEntityDefinitionBlock)(KDOEntityDefinition *);

@interface KDOEntityDefinition : NSObject
- (void)addAttribute:(NSString *)attributeName type:(NSAttributeType)attributeType isIndexed:(BOOL)isIndexed;
@end

@interface KDOManagedObjectModelBuilder : NSObject
- (id)initWithManagedObjectModel:(NSManagedObjectModel *)objectModel;
- (void)defineEntityNamed:(NSString *)entityName definition:(KDOEntityDefinitionBlock)definitionBlock;
- (NSManagedObjectModel *)build;
@end
