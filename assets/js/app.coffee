# this global variable is where all the script goes so that
# it doesn't polute the global namespace
MYAPP = MYAPP or {}
MYAPP.run = (->

  # create the Kendo UI Mobile application
  MYAPP.app = new kendo.mobile.Application(document.body,
    transition: "slide"
  )
)

# this is called when the intial view shows. it prevents the flash
# of unstyled content (FOUC)
MYAPP.show = (->
  $(document.body).show()
)

# this function runs at startup and attaches to the 'deviceready' event
# which is fired by PhoneGap when the hardware is ready for native API
# calls. It is self invoking and will run immediately when this script file is
# loaded.
(->
  if navigator.userAgent.indexOf("Browzr") > -1

    # blackberry
    setTimeout MYAPP.run, 250
  else

    # attach to deviceready event, which is fired when phonegap is all good to go.
    document.addEventListener "deviceready", MYAPP.run, false
)()
MYAPP.subsonic = (->
  window.glob = []
  console.log "subsonic"
  $(document).delegate "body", "pageinit", ->
    baseUrl = undefined
    param = undefined
    req = undefined
    baseUrl = "http://by.subsonic.org/rest/"
    param = ".view?u=brian&p=home&v=1.8.0&c=digidj&f=jsonp&callback=?"
    console.log "get music folders"
    glob.queryMethod = "getIndexes"
    glob.url = baseUrl + glob.queryMethod + param
    req = $.ajax(
      url: glob.url
      dataType: "jsonp"
    )
    req.done (d) ->
      console.log "page init"
      console.log d["subsonic-response"]["indexes"]["index"]
      $(d["subsonic-response"]["indexes"]["index"]).each ->
        console.log this
        $(this["artist"]).each ->
          $("#tracks").addClass("ui-body-a").listview "refresh"


      $("ul.ui-body-a").append("<li><a class=sec href=#25102 >Genre</a></li>").listview "refresh"


)
