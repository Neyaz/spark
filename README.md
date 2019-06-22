I think the fastest way to import is using raw sql and insert all items by
one query.
However, it takes a lot of time to propely implement.
So, I'm using `activerecord-import` gem which is doing the same thing, but
it requires PostgreSQL. Therefore you have to configure PostgreSQL for specs.