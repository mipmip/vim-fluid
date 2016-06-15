# vim-fluid

Vim plugin for the [Fluid Template Engine](https://en.wikipedia.org/wiki/TYPO3_Flow#Fluid_template_engine) offering indention and syntax highlighting for fluid code together with plain HTML and JavaScript and CSS code.

Fluid is the core template engine of [TYPO3](http://typo3.org).

## Usage

vim-fluid autodetects .fluid files but in most cases your files will end
with ```.html```, so you should set a modeline on top of your file. E.g.:

```
<!-- vim: set ft=fluid :-->
```

## Example

```:ggVG``` produces this indenting

```html
<!-- fluid indenting test file -->
 <html>
   <script>
     if (x=1){
       var x=e;
     }
   </script>

   <style>
      .class-x {
        color:white;
      }
   </style>

   <div>
     <f:for each="{filters}" as="filter">
       <f:if condition="{filter.type} == 'checkbox'">
         <f:then>
           <f:render partial="checkbox" arguments="{filter : filter}" />
         </f:then>
         <f:else>
           <f:render partial="selectbox" arguments="{filter : filter}" />
         </f:else>
       </f:if>
     </f:for>
   </div>
</html>
```

## Contributing
1. Fork it ( https://github.com/mipmip/vim-fluid/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Credits
- Fluid-vim uses an awful lot of code from https://github.com/othree/html5.vim
- Fluid-vim is sponsored by [Lingewoud](http://lingewoud.com)

![image](http://picdrop.t3lab.com/yCWqnH5FWq.png)
