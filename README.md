# MLA14.org

This is the Mobile Program for the 2014 MLA Convention in Chicago. A hosted
version can be found at [mla14.org][mla14].

## Program data

Structured data in XML format can be found in the `xml` folder. JSON data can
be found in the `app/data` folder.

## Build

This project uses [Bower][bower] and [Grunt][grunt]:

```bash
npm install
cd app && bower install
grunt components
grunt
```

[mla14]: http://mla14.org
[bower]: http://bower.io
[grunt]: http://gruntjs.org
