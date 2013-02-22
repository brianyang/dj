window.glob = {}
baseUrl = 'http://by.subsonic.org/rest/'
param = '.view?u=brian&p=home&v=1.8.0&c=digidj&f=jsonp&callback=?'
console.log 'get music folders'
glob.queryMethod = 'getIndexes'
glob.url = baseUrl + glob.queryMethod + param


glob.requestData = ->
    req = $.ajax
      url:glob.url
      dataType:'jsonp'

    req.done (d) ->
      console.log 'done'
      source   = $("#track-content").html()
      template = Handlebars.compile(source)

      $(d['subsonic-response']['indexes']['index']).each ->
        console.log @
        $(@artist).each ->
            #console.log @name
            context =
              title: @name
              artistid: @id

            html = template(context)
            $('.tracks ul').append html if @name != undefined


$('body').on 'click', 'button', ->
    console.log 'btn'
    glob.requestData()


$('body').on 'click', '.list-item', ->
    # console.log $(@).data('artistid')
    winLoc = window.location.hash
    console.log winLoc



