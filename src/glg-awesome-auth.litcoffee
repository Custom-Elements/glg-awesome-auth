#glg-awesome-auth
*TODO* tell me all about your element.

    require 'awesome-auth-client'

    Polymer 'glg-awesome-auth',

##Events
*TODO* describe the custom event `name` and `detail` that are fired.

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
          console.log "Authenticated user:", result.user
          @currentUser = result.user
          @status = 'authenticated'
          @fire 'polymer-signal', { name:'glg-auth-login',  data:{currentUser:@currentUser} }

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
        console.log("Created!")
        @status = "unknown"
        @awesomeAuth = null
        @icon = 'fa-envelope-o'
        @iconAnimation = ''

      ready: ->
        loginPage = this
        console.log("Ready!")
        opts =
          appName: @appName
          onAuthStatusChange: (result) ->
            loginPage.authenticationCallback result
        @awesomeAuth = new AwesomeAuth opts

      attached: ->

      domReady: ->

      detached: ->
