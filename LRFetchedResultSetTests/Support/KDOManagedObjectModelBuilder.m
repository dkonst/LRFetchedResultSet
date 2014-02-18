//
//  KDOManagedObjectModelBuilder.m
//
//  Created by Konstantin Dorodov on 10.12.2013.
//

#import "KDOManagedObjectModelBuilder.h"


@interface KDOEntityDefinition ()
@property (nonatomic, strong) NSMutableArray *propertyList;
@end

@implementation KDOEntityDefinition : NSObject
- (NSMutableArray *)propertyList
{
    if (_propertyList)
        return _propertyList;
    _propertyList = [[NSMutableArray alloc] init];
    return _propertyList;
}
- (void)addAttribute:(NSString *)attributeName type:(NSAttributeType)attributeType isIndexed:(BOOL)isIndexed
{
    NSAttributeDescription *attribute = [[NSAttributeDescription alloc] init];
    [attribute setName:attributeName];
    [attribute setAttributeType:attributeType];
    [attribute setOptional:YES];
    [attribute setIndexed:isIndexed];
    [self.propertyList addObject:attribute];
}
@end

#pragma mark -

@interface KDOManagedObjectModelBuilder ()
@property (nonatomic, strong) NSManagedObjectModel *objectModel;
@property (nonatomic, strong) NSMutableArray *entityDescriptionArray;
@end

@implementation KDOManagedObjectModelBuilder
- (id)initWithManagedObjectModel:(NSManagedObjectModel *)objectModel
{
    self = [super init];
    if (self) {
        _objectModel = objectModel;
    }
    return self;
}

- (NSMutableArray *)entityDescriptionArray
{
    if (_entityDescriptionArray)
        return _entityDescriptionArray;
    _entityDescriptionArray = [[NSMutableArray alloc] init];
    return _entityDescriptionArray;
}

- (void)defineEntityNamed:(NSString *)entityName definition:(KDOEntityDefinitionBlock)definitionBlock
{
    NSEntityDescription *entity = [[NSEntityDescription alloc] init];
	[entity setName:entityName];
    KDOEntityDefinition *entityDefinition = [[KDOEntityDefinition alloc] init];
    definitionBlock(entityDefinition);
    [entity setProperties:entityDefinition.propertyList];
	[self.entityDescriptionArray addObject:entity];
}

- (NSManagedObjectModel *)build
{
    [self.objectModel setEntities:self.entityDescriptionArray];
    return self.objectModel;
}
@end
