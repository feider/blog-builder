# Small blog creation engine for my blog

It's just two short bash scripts that generate the blog and overview sites.

## Usage

To add an entry
```
./add_entry.sh
```
Use a syntax that pandoc can read.

To generate the html:
```
./generate [webroot]
```
The webroot is used to create the permalinks of the blog.

## Dependencies:

* pandoc
