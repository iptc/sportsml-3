# SportsML 3 XSL Conversion Tools

These are XSLT stylesheets to convert a) SportsML 2 to SportsML 3 and b) between generic and specific renderings of SportsML 3.

Please note that this is a starter kit. The stylesheets may not cover all markup possibilities but they provide a template which users may edit to their needs. Improvements to the git repository are welcome!


## 2.2-to-3.0

There are four possible flavours (or renderings) of SportsML. This directory contains XSLT stylesheets to convert to your preferred SportsML rendering. For guidance on the different renderings please refer to the examples directory. The different renderings are:

* Classic generic
* Classic specific
* G2 generic
* G2 specific

You should start with an already-valid v2.2 document.


### generic-specific

SportsML 3 can render player and team statistics in sport-specific elements with attributes, or it can render them in generic, typed <stat> elements. This directory contains two stylesheets to convert either way. Converting from specific to generic is rather straightforward. Converting generic to specific stats requires a lookup file (generic-to-specific-lookup.xml) which is provided as is and is not yet complete. User contributions welcome!