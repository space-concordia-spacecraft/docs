# Using Raw Redirects

In `index.html`

```html
remoteMarkdown: {
  tag: 'CustomTag',
},
```

In `raw-redirect/custom`

```markdown
<!-- markdownlint-disable -->
[customTag](link)
```

Then link to the `raw-redirect/custom` page from a document