as yet unclassified
introduction
	^HelpTopic title: 'Introduction' contents:
'Object Pool offers easy way to build pools for objects. One common situation
could be pooling database connections. This library was created for supporting pooling
of GlorpDBX database connections. However GlorpDBX related code is different
package.

Objects borrowed from OPPool have following basic lifecycle:

1. Objects are first created.
2. When objects are borrowed from pool they are activated..
3. When objects are returned to pool they are passivated.
4. When objects is no longer usable (some lifecycle operation fails) or needed it is destroyed.

See documentation of #OPPool for more information abour lifecycle. There is also
OPBasicPool that does validation to check if objects are still usable.

This library was developed for University of Jyväskylä under MIT-license.

panu.suominen@iki.fi
'.