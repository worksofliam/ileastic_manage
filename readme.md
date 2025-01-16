
## ileastic_manage

Simple SQL tools to manage services/programs created for [ILEastic](https://github.com/sitemule/ILEastic). Provides procedures to start and stop services, and a view to see which ILEastic services are running.


```sql
-- Start the HELLOWORLD service
call ileastic.start('ILEASTIC', 'HELLOWORLD');

-- See the services that are running
select * from ileastic.services;

-- Stop the HELLOWORLD service
call ileastic.stop('HELLOWORLD');
```

### Future cool ideas

- [ ] Stop all services
- [ ] Start all services in a specific library (by looking at imports in the program object, which can be done with SQL)
- [ ] In the same manner as start, but show a list of objects/services that can be started in a certain library - perhaps even show if they're already running.

### How to build

This assumes you already have [ILEastic](https://github.com/sitemule/ILEastic) installed already.

I did not create a build script for this yet. Simplist way to build these SQL objects is with VS Code (or ACS even) with Code for IBM i (+ the database extension).

1. Clone this repo & open it in VS Code
2. Connect to the system with Code for IBM i
3. Execute the `create` statements in this order:
   1. `ensureLibrary`
   2. `services`
   3. `stop`
   4. `start`