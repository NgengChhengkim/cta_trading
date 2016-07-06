ready = function() {
  loadFacebookSDK();
  if (!fb_events_bound) {
    return bindFacebookEvents();
  }
};

$(document).ready(ready);
$(document).on('page:load', ready);

var fb_root = null;
var fb_events_bound = false;

bindFacebookEvents = function() {
  $(document).on('page:fetch', saveFacebookRoot).on('page:change', restoreFacebookRoot).on('page:load', function() {
    return typeof FB !== "undefined" && FB !== null ? FB.XFBML.parse() : void 0;
  });
  return fb_events_bound = true;
};

saveFacebookRoot = function() {
  return fb_root = $('#fb-root').detach();
};

restoreFacebookRoot = function() {
  if ($('#fb-root').length > 0) {
    return $('#fb-root').replaceWith(fb_root);
  } else {
    return $('body').append(fb_root);
  }
};

loadFacebookSDK = function() {
  window.fbAsyncInit = initializeFacebookSDK;
  return $.getScript("//connect.facebook.net/en_US/all.js#xfbml=1");
};

initializeFacebookSDK = function() {
  return FB.init({
    appId: 1482445602072960,
    status: true,
    cookie: true,
    xfbml: true
  });
};
