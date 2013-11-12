function redirectPage() {
    window.location = linkLocation;
}

/*
 Sticky-kit v1.0.1 | WTFPL | Leaf Corcoran 2013 | http://leafo.net
*/
(function(){var g,t;g=this.jQuery;t=g(window);g.fn.stick_in_parent=function(d){var u,k,e,r,B,h,C;null==d&&(d={});r=d.sticky_class;u=d.inner_scrolling;e=d.parent;k=d.offset_top;null==k&&(k=0);null==e&&(e=void 0);null==u&&(u=!0);null==r&&(r="is_stuck");B=function(a,d,h,v,y,l){var p,s,m,w,b,f,z,A,q,x;f=a.parent();null!=e&&(f=f.closest(e));if(!f.length)throw"failed to find stick parent";z=function(){var c,b;c=parseInt(f.css("border-top-width"),10);b=parseInt(f.css("padding-top"),10);d=parseInt(f.css("padding-bottom"),
10);h=f.offset().top+c+b;v=f.height();c=a.is(".is_stuck")?q:a;y=c.offset().top-parseInt(c.css("margin-top"),10)-k;return l=c.outerHeight(!0)};z();if(l!==v)return m=a.css("float"),q=g("<div />").css({width:a.outerWidth(!0),height:l,display:a.css("display"),"vertical-align":a.css("vertical-align"),float:m}),p=s=!1,w=void 0,b=k,A=!1,x=function(){var c,g,n,e;n=t.scrollTop();null!=w&&(g=n-w);w=n;s?(e=n+l+b>v+h,p&&!e&&(p=!1,a.css({position:"fixed",bottom:"",top:b}).trigger("sticky_kit:unbottom")),n<y&&
(s=!1,b=k,"left"!==m&&"right"!==m||a.insertAfter(q),q.detach(),c={position:""},A&&(c.width=""),a.css(c).removeClass(r).trigger("sticky_kit:unstick")),u&&(c=t.height(),l>c&&!p&&(b-=g,b=Math.max(c-l,b),b=Math.min(k,b),a.css({top:b+"px"})))):n>y&&(s=!0,c={position:"fixed",top:b},"none"===m&&"block"===a.css("display")&&(c.width=a.width()+"px",A=!0),a.css(c).addClass(r).after(q),"left"!==m&&"right"!==m||q.append(a),a.trigger("sticky_kit:stick"));if(s&&(null==e&&(e=n+l+b>v+h),!p&&e))return p=!0,"static"===
f.css("position")&&f.css({position:"relative"}),a.css({position:"absolute",bottom:d,top:""}).trigger("sticky_kit:bottom")},t.on("scroll",x),setTimeout(x,0),g(document.body).on("sticky_kit:recalc",function(){z();return x()})};h=0;for(C=this.length;h<C;h++)d=this[h],B(g(d));return this}}).call(this);



$(document).ready(function() {

  window.setTimeout(function(){
    $('body').addClass('loaded');
  }, 300);
  
  //$('header').stick_in_parent();
  
  $('#nav a').click(function(e){
    e.preventDefault();
    linkLocation = this.href;
    $('#content, body.home').animate({opacity: 0},300, redirectPage);
  });
  
  $(window).resize(function(){
    //$(document.body).trigger("sticky_kit:recalc");
  });
  
  $('a.fb').fancybox({
    padding: 6,
    maxWidth: 800
  });

  var map = L.mapbox.map('map', 'cabinroom.map-fvzt0qox', {
    zoomControl: true,
    scrollWheelZoom: false
  });
  map.setView([48.883624, -123.364000],13);

  var markerLayer = L.mapbox.markerLayer().addTo(map);
  markerLayer.loadURL('/map-points.geojson');

  $('a.remove').click(function(e){
    e.preventDefault();
    var removeID = $(this).attr('data-remove');
    $.ajax({
      type: 'GET',
      url: '/registry/claim/'+removeID,
      accepts: 'application/json',
      dataType: 'json',
      success: function(data){
        console.log(data);
        if(!data.success) {
          alert('that item has already been claimed. Whoops!')
        }
      }
    });
  })

});
