$(document).ready(function(){

    var SocialConnection = {
        authWindow: function(url) {
            // logout current instagram user
            var script = document.createElement('script');
            script.src = 'https://instagram.com/accounts/logout/'
            document.getElementsByTagName('head')[0].appendChild(script);

            // wait 1 second then open auth window
            setTimeout(function(){
                window.open( url, "authWindow", "width=600, height=400" );
            }, 1000);
        },
    }

    // Open auth window for Social Connection
    $('.connect-account').on('click', '.btn-auth', function(ev) {
        ev.preventDefault();
        SocialConnection.authWindow( $(this).attr('href') );
    });

    // Initialze tags input with validations
    $( '.bootstrap-tagsinput' ).tagsinput({
        maxTags: 3,
        maxChars: 8,
    });

    // disable input after three tags
    $( '.bootstrap-tagsinput input' ).on('keyup', function(ev){
        var connectionTags = $( '#socialconnection_tags' ),
        connectionTagsArr  = connectionTags.val().split("\,");

        if( connectionTagsArr.length >= 3 ) {
            $( '.bootstrap-tagsinput input' ).prop( "disabled", true );
        }
    });

    // Enable first collapse
    var firstCollapse = $('[data-toggle="collapse"]').first().attr('href');
    $(firstCollapse).collapse({
        toggle: true
    });

});