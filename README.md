# rely.js

I started looking at dependency management libraries out there, 
but I had the feeling that they were all very setup 
intensive (there are a number of files you have to create and a relatively
high amount of code you need to write to get up and running). So I decided
to spend a couple of hours spiking a solution that might solve the problem 
I was having in the project I was working in (which it finally did).

And that's how rely.js was born.


## Usage

The fist thing you have to do to use rely.js is to include the jquery.js
library before you require rely.js as rely.js depends on it. After that you
will include the rely.js library.

```html
<script src='/js/jquery.js'/>
<script src='/js/rely.js' data-app='testapp' />
```

The **data-app** attribute tells rely.js the name of the application 
and javascript file to load (for the time being the name of the file will
have to correspond with the name of the class we want to instantiate).

The app we are instantiating is the high level application that will kick off
your application (e.g. Backbone.Router).

Optionally you have a **data-options** attribute which defines *parameters*
that you might want to pass into the class rely.js will be loading when the
page is loaded.

**Example:**

```html
<script src='/js/rely.js' data-app='testapp' data-options='{greeting: 'OHAI rely.js!'}'/>
```

[Enrique Comba Riepenhausen](http://ecomba.org)

TBC

**MISSING:**
* finish the documentation
* Example app and usages
