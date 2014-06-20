glg-awesome-auth
================


This element is used to handle the registering and authenticating of users in your application set up with [AwesomeAuth](https://github.com/glg/awesome-auth)

To use this element, pass the parameter `appName` the name of your mapping file.


```html
<glg-awesome-auth appName="awesome-auth-example" unresolved>
</glg-awesome-auth>
```
When the user has been authenticated the `glg-awesome-auth-login` event will fire, passing the user information laid out in your mapping file's [getUserInfo](https://github.com/glg/awesome-auth#customize-registration) function.

```coffeescript
awesomeAuth = document.querySelector("glg-awesome-auth")

awesomeAuth.addEventListener('glg-awesome-auth-login', (event) ->
    user = event.detail.user
  )
```

