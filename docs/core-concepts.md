-----
title: Core Concepts
-----

# Documents

The only invariant of documents is that they have a slot named id which is the
SHA1 of its slots.

## Document types

In order to extend the types of documents and customize their behavior
(e.j. how they are rendered) one has to subclass from the document type. MudKip
comes with a post doc-type.

## Collections

For document's that are a collection of other documents, for example an archive
of blog posts or an index, the idea is represent them with a query expression
to the document database to be executed at build time.

# Document Database

All loaded documents are stored in a hash-table, that maps the SHA1 of the
document's serialized slots to the document object. Currently this is of
virtually no use, except theoretically it would prevent document duplication.

# Content Loader

Normally the documents to be loaded correspond to a static file, but what if
you want to take a snapshot of a dynamic document/resource at build time, say
someone's twitter timeline. That is where Content Loaders come into play. They
allow you to customize the process populating the document database.

# Router

The router maps a URL to a document. The current implementation maps a URL
template (a regexp) to query-constructor, when a URL matches the URL template
it constructs a query and executes it against the current document database to
retrieve a document.
