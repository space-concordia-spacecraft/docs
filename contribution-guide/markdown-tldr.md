# Markdown TLDR

Docsify parses and loads Markdown files and displays them as a website.

The following is a cheatsheet for using Markdown. If you wish to look at a more in depth Markdown guide, use the following [guide](https://www.markdownguide.org/getting-started/).

## Headers

| Markdown | Rendered Output |
| ------- | ----------- |
| `# H1` | <h1>H1</h1> |
| `## H2` | <h2>H2</h2> |
| `### H3` | <h3>H3</h3> |
| `#### H4` | <h4>H4</h4> |
| `##### H5` | <h5>H5</h5> |
| `###### H6` | <h6>H6</h6> |

Alternatively, it is also possible to use

```
H1
======

H2
------
```

Alt-H1 {docsify-ignore}
======

Alt-H2 {docsify-ignore}
------

## Emphasis

| Markdown | Rendered Output |
| ------- | ----------- |
| `**Bold Text**` | <b>H1</b> |
| `*Italic Text*` | <i>H2</i> |

## Lists

It is possible to use either ordered lists or unordered lists.

```
1. First ordered list item
2. Another item
```

1. First ordered list item
2. Another item

```
- First unordered list item
* Another item
+ last item
```

- First unordered list item
* Another item
+ last item

## Links

```
[I'm a link to google](https://www.google.com)

[I'm a link to another file within the project](/contribution-guide/index)

[You can either use numbers for reference-style links][1]

Or use the [link text itself]

[1]: http://slashdot.org
[link text itself]: http://www.github.com
```

[I'm a link to google](https://www.google.com)

[I'm a link to another file within the project](/contribution-guide/index)

[You can either use numbers for reference-style links][1]

Or use the [link text itself]

[1]: http://www.github.com
[link text itself]: http://www.github.com

## Code and Syntax Highlighting

```
Inline code has `back-ticks` around it.
```
Inline code has `back-ticks` around it.

In order to write blocks of code, triple back-ticks should be used.

<pre><code>
```javascript
let x = 0;
```

```
No language indicated
```
</code></pre>

```javascript
let x = 0;
```

```
No language indicated
```

## Tables
```
| Tables        | Are           |
| ------------- |:-------------:|
| row 1 col 1      | row 1 col 2 |
| row 2 col 1      | row 2 col 2      | 
| row 3 col 1 | row 3 col 2      |
```

| Tables        | Are           | 
| ------------- |:-------------:| 
| row 1 col 1      | row 1 col 2 | 
| row 2 col 1      | row 2 col 2      |   
| row 3 col 1 | row 3 col 2      | 