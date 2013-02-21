// this global variable is where all the script goes so that
// it doesn't polute the global namespace
var MYAPP = MYAPP || {};

MYAPP.subsonic = (function(){
var baseUrl, param;

window.glob = {};

baseUrl = 'http://by.subsonic.org/rest/';

param = '.view?u=brian&p=home&v=1.8.0&c=digidj&f=jsonp&callback=?';

console.log('get music folders');

glob.queryMethod = 'getIndexes';

glob.url = baseUrl + glob.queryMethod + param;

console.log(glob.url);

glob.requestData = function() {
  var req;
  req = $.ajax({
    url: glob.url,
    dataType: 'jsonp'
  });
  return req.done(function(d) {
    var source, template;
    console.log('done');
    source = $("#track-content").html();
    template = Handlebars.compile(source);
    return $(d['subsonic-response']['indexes']['index']).each(function() {
      console.log(this);
      return $(this.artist).each(function() {
        var context, html;
        console.log(this.name);
        context = {
          title: this.name,
          artistid: this.id
        };
        html = template(context);
        if (this.name !== void 0) return $('.tracks ul').append(html);
      });
    });
  });
};

glob.requestData();

$('body').on('click', '#organize', function() {
  $('.tracks ul').empty();
  return glob.requestData();
});
})

MYAPP.events = (function(){

  console.log('bind events')
})


MYAPP.run = (function() {
	// create the Kendo UI Mobile application
    MYAPP.app = new kendo.mobile.Application(document.body, { transition: "slide" });
    console.log('run')
    //MYAPP.subsonic()
});

// this is called when the intial view shows. it prevents the flash
// of unstyled content (FOUC)
MYAPP.show = (function() {
	$(document.body).show();
});

// this function runs at startup and attaches to the 'deviceready' event
// which is fired by PhoneGap when the hardware is ready for native API
// calls. It is self invoking and will run immediately when this script file is
// loaded.
(function() {
    if (navigator.userAgent.indexOf('Browzr') > -1) {
        // blackberry
        setTimeout(MYAPP.run, 250)
    } else {
        // attach to deviceready event, which is fired when phonegap is all good to go.
        document.addEventListener('deviceready', MYAPP.run, false);
    }
})();
