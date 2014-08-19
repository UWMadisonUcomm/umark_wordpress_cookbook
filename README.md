# uw-wordpress-cookbook

A Chef cookbook for configuring environments for our Wordpress projects.

## Supported Platforms

Centos

## Depends on

* [grunt_cookbook](https://github.com/MattSurabian/grunt_cookbook)

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['uw-wordpress']['project_root']</tt></td>
    <td>String</td>
    <td>Project root</td>
    <td>/var/www/</td>
  </tr>
</table>

## Usage

### uw-wordpress::default

Include `uw-wordpress` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[uw-wordpress::default]"
  ]
}
```

## Resources

### `bower`

Run `bower install` in your project root directory.

```ruby

```

## License and Authors

Author:: Nick Weaver (jnweaver@wisc.edu)
