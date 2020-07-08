# ObjectPool

[![GitHub release](https://img.shields.io/github/release/pharo-ide/ObjectPool.svg)](https://github.com/pharo-ide/ObjectPool/releases/latest)
[![Build Status](https://github.com/pharo-ide/ObjectPool/workflows/Build/badge.svg?branch=master)](https://github.com/pharo-ide/ObjectPool/actions?query=workflow%3ABuild)
[![Coverage Status](https://codecov.io/github/pharo-ide/ObjectPool/coverage.svg?branch=master)](https://codecov.io/gh/pharo-ide/ObjectPool/branch/master)
[![Pharo 7.0](https://img.shields.io/badge/Pharo-7.0-informational)](https://pharo.org)
[![Pharo 8.0](https://img.shields.io/badge/Pharo-8.0-informational)](https://pharo.org)

Object Pool offers easy way to build pools for objects. One common situation
could be pooling database connections. This library was created for supporting pooling
of GlorpDBX database connections. However GlorpDBX related code is different
package.

Objects borrowed from OPPool have following basic lifecycle:

1. Objects are first created.
2. When objects are borrowed from pool they are activated..
3. When objects are returned to pool they are passivated.
4. When objects is no longer usable (some lifecycle operation fails) or needed it is destroyed.

To create pool for of OrderedCollections one could write:
```Smalltalk
OPBasicPool new
	creator: [OrderedCollection new].
```
To get new collection from the pool:
```Smalltalk
pool withPooled: [:o| "Do something"].
```
To also clear collections when they are returned add passivator
```Smalltalk
pool passivator:[:o|o removeAll].
```
Or to do that before borrow add activator:
```Smalltalk
pool activator:[:o|o removeAll].
```
To validate objects before borrow add following. Objects that do not validate are destroyed.
```Smalltalk
pool validator:[:o|o size = 0].
```
One can set maximum size of pool with #maxIdleIbjects. See more about pool configuration
in documentation of OPBasicPool.

## Installation
```Smalltalk
Metacello new
  baseline: 'ObjectPool';
  repository: 'github://pharo-ide/ObjectPool';
  load
```
Use following snippet for stable dependency in your project baseline:
```Smalltalk
spec
    baseline: 'ObjectPool'
    with: [ spec repository: 'github://pharo-ide/ObjectPool:v1.0.0' ]
```
