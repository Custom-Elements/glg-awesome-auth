glg-awesome-auth
================


This element is used to handle the registering and authenticating of users in your application set up with [AwesomeAuth](https://github.com/glg/awesome-auth)

To use this element, pass the parameter `appName` the name of your mapping file.


```html
<glg-awesome-auth appName="awesome-auth-example">
</glg-awesome-auth>
```

If you do not require a custom mapping file and are using the [default mapping file](https://github.com/glg/awesome-auth/blob/master/mappings/glg-internal-app.coffee) for an internal application, there are additional parameters that can be supplied to customize the login experience.

`emailFrom` is the sender of the registration email
`emailSubject` is the subject of the registration email
`friendlyAppName` is the name of your application
`confirmationRedirect` is where the user is brought after registering

```html
<glg-awesome-auth appName="glg-internal-app" 
                  emailFrom="khughes@glgroup.com" 
                  emailSubject="Welcome to the GLG Mobile app!" 
                  friendlyAppName="GLG Mobile"
                  confirmationRedirect="http://localhost:10000/demo.html">
          <content></content>
</glg-awesome-auth>

```

When the user has been authenticated the `glg-awesome-auth-login` event will fire, passing the user information laid out in your mapping file's [getUserInfo](https://github.com/glg/awesome-auth#customize-registration) function.

```coffeescript
awesomeAuth = document.querySelector("glg-awesome-auth")

awesomeAuth.addEventListener('glg-awesome-auth-login', (event) ->
    user = event.detail.user
  )
```

