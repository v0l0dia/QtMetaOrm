QtMetaOrm
=========

Header-only Object Relational Mapping library, based on Qt framework. The key goals are: 
 - to be as much declarative as possible in C++
 - avoid library dependencies, excepting Qt
 - provide both intrusive and non-intrusive implementation
 - provide easy and essential [Django][]-style ORM functionality

[Django]: https://www.djangoproject.com/

### Comparison

Though ORM patterns are more suitable for dynamic languages, such as Python, in the world of C++ we have several 
libraries, providing very interesting functionality: [ODB][], [Wt][], [QxORM][], [LightSQL][] and even more. Most
of them are well-documented and updated frequently.

This project is inspired by [QtOrm][], just another one ORM library, which tends to be more "django-style" than others.
And yes, Django ORM is what QtMetaORM tends to be like, but there's no goal to copy full feature stack and follow
Django model system as it is done in QtOrm.

[ODB]: http://www.codesynthesis.com/products/odb/
[Wt]: http://www.webtoolkit.eu/wt
[QxORM]: http://www.qxorm.com/qxorm_en/home.html
[LightSQL]: http://sourceforge.net/projects/lightsql/
[QtOrm]:https://github.com/steckdenis/qtorm

So, why another one ORM?
Almost all C++ ORM libraries require some explicit actions from programmers to make there objects synchronized with 
databases. Developers are suggested to write plenty of additional declarations, initialization code or even rely on
external tools for ORM code generation. And after all this work is done we still need to compile, recompile, link
to external libraries, watch our hands clean and head clear. Although most of ORM libraries have user-friendly API,
it can be hard to just start working on your actual project. That's why we all need as much simplicity as it is possible
to be more productive. And that's what QtMetaOrm is about.

### Features
 - Header-only library. No external dependencies, no sources to compile.
 - Qt-based and Qt-oriented. Underlying DB work is done with QtSql framework, therefore most of Qt data types are supported.
 - Mimimum declarations required to start working. No explicit ORM-related initialization in your constructors.
 - Django-style functionality for your objects:
    - Objects manager is accessible through static methods of target class.
    - QuerySet represents collection of objects of target class.
    - QuerySet replicates Django filtering and access functions.
    - Lazy execution of underlying SQL queries in QuerySets.
    - CRUD functionality is accessible through target class member methods.
 - Both intrusive and non-intrusive implementation is provided.
 - Intrusive implementation through inheritance of template class does not add any data members - only static and member methods
 - With non-intrusive implementation all functionality is available through static methods of template classes

### Disadvantages
 - Qt-only
 - Unable to customize DB schemas
 - One primary key only
 - No foreign keys and relations (maybe later)

### Under-the-hood
QtMetaOrm is based on c++ templates. For more API simplification, some Template meta-programming techniques were used, 
such as loop-enrolling, explicit full and partial template specializations etc. All required declarations are wrapped
with fancy macroses, so all you need is include one header file and write a pair of declarations.

### Usage (not ready for now)
Suppose we have some class we want to make persistable:

    //...before
    class SomeClass{
    public:
        SomeClass();
        qint32 id;
        qint32 someInt;
        QDateTime someTime;
        QString someString;
        QByteArray someRaw;
    };
    //...after
    
It's very simple, but its members are of the most popular data types used in databases. So we want to store our
class objects, but we don't want to mess up with SQL and any type casting to/from QVariant etc. All we need is to 
include our ORM header:

    #include "qtmetaorm.hpp"
    //...before
    //

inherit from QPO_Presistent template class, recursively passing SomeClass as template parameter:

    //...before
    class SomeClass : public QPO_Presistent<SomeClass> {
    //...
    
and declare data schema and fields after class declaration:

    //...after 
    QPO_DECLARE_TABLE( "sometable", 5 )   //table name | fields count 
    QPO_DECLARE_FIELD( SomeClass, qint32, id) //target class | field type | class data member
    QPO_DECLARE_FIELD( SomeClass, qint32, someInt )
    QPO_DECLARE_FIELD( SomeClass, QDateTime, someTime )
    QPO_DECLARE_FIELD( SomeClass, QString, someString )
    QPO_DECLARE_FIELD( SomeClass, QByteArray, someRaw )

and here we are! We just declare data table for our object with 5 fields, and then we declare data fields in the 
order they must appear in our database table. The first field declared is considered to be a primary key field (!).
In our case it corresponds to 'id' member of SomeClass.

> NOTE: Primary key is REQUIRED. By default QtMetaOrm uses the first declared field, thus primary key will always
have 0 index in the table. Though it is possible to alter that behavior by using QPO_DECLARE_TABLE_PK macro with 
last argument corresponding to PK field index.

Now our objects of SomeClass can be stored to table "sometable" in our database. Field names created in the table
will be that of data members, passed to QPO_DECLARE_FIELD macro. Here is the SQL code for created table in PostGre:

    CREATE TABLE sometable (
       id SERIAL PRIMARY KEY,
       someInt INTEGER,
       someTime INTEGER,
       someString TEXT,
       someRaw BYTEA
       )

> NOTE: QtMetaOrm uses some sort of unification on data types to avoid backend-specific stuff as much as possible

  


