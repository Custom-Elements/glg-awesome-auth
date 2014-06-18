#glg-awesome-auth
This element can be used to verify users are authenticated to your system using [AwesomeAuth](https://github.com/glg/awesome-auth)

    require 'awesome-auth-client'

    Polymer 'glg-awesome-auth',

##Events
###glg-awesome-auth-login
Fired when a user has successfully been authenticated. This will return the information designated in your mapping file on the awesome-auth server on the `event.detail.user` property of the parameter

##Attributes and Change Handlers

##Methods

      submitOnEnter: (e) ->
        if e.keyIdentifier == "Enter"
          @login(e)

      validateEmail: () ->
        emailPattern = /(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))/g
        if @email.match emailPattern
          true
        else
          false

##Event Handlers

      login: (e) ->
        e.preventDefault()

        return @errorMessage = "Please provide a valid email address" unless @validateEmail()

        console.log "Registering..."
        @icon = 'fa-spinner'
        @iconAnimation = 'fa-spin'
        @awesomeAuth.register @email, (err, result) =>
          @icon = 'fa-envelope-o'
          @iconAnimation = ''
          if err
            console.log("Registration Error", err)
            if err == 'user-not-found'
              @errorMessage = "That email address is not valid for this application"
            else
              @errorMessage = err
          else if result
            console.log("Register Callback:", result)
            @status = 'authenticating'
            @errorMessage = null

      logout: ->
        console.log "logging out..."
        @awesomeAuth.logOut()
        @status = 'unauthenticated'
        @email = ""
        @currentUser = null


      authenticationCallback: (result) ->
        if result.status == 'confirmed' && result.user
          @currentUser = result.user
          @status = 'authenticated'
          @fire 'glg-awesome-auth-login', { user:@currentUser }

          # user-not-found is returned when the user's email is not valid/authorized
        else if result.status == 'user-not-found'
          console.log "User Not Found"
          @status = 'unauthenticated'

        else if result.status == 'user-not-registered'
          console.log "User Not Registered"
          @status = 'unauthenticated'

        else if result.status == 'unconfirmed'
          console.log "Awaiting confirmation"
          @status = 'authenticating'

        else
          console.log "Unexpected status", result.status
          @status = 'unauthenticated'

##Polymer Lifecycle

      created: ->
        @status = "unknown"
        @awesomeAuth = null
        @icon = 'fa-envelope-o'
        @iconAnimation = ''

      ready: ->
        loginPage = this
        opts =
          appName: @appName
          onAuthStatusChange: (result) ->
            loginPage.authenticationCallback result
        @awesomeAuth = new AwesomeAuth opts

      attached: ->

      domReady: ->

      detached: ->
