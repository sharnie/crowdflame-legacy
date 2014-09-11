$(document).ready(function(){
    var offerPriceInput = $( ".offer-form #price" ),
        offerTitleInput = $( ".offer-form #offer_title" ),
        offerAccount    = $( "#socialconnection_id" );

    var offerForm = {
        init: function() {
            offerPriceInput.trigger("keyup");
            offerTitleInput.trigger("keyup");
        },
        previewText: function(attribute, defaultPlaceholder, placeholder) {
            if(!placeholder.length) {
                placeholder = defaultPlaceholder;
                attribute.html(placeholder);
            } else {
                attribute.html(placeholder);
            }
        },
        connectionSelect: function() {
            $.each($('#socialconnection_id option'), function(index, element) {
                $('<li/>').append(
                    $('<a/>', {
                        href: '#',
                        html: $(this).text(),
                        'data-socialconnection-id': $(this).val()
                    })
                ).appendTo('#socialconnections ul.dropdown-menu');
            });

            $('#socialconnections ul.dropdown-menu').on('click', 'li a', function(){
                $('#socialconnection_id').val( $(this).data('socialconnection-id') );

                // display account selected
                accountButton = $(this).closest('#socialconnections').find('#account #account-selected');
                accountButton.text( $(this).text() );

                // trigger change event for offer preview
                offerAccount.trigger('change');
            });
        }
    }
    offerForm.connectionSelect();

    // display offer preview price
    offerPriceInput.on('keyup', function(ev) {
        ev.preventDefault();
        var previewPrice = $('.offer-details').find('span.offer-price span'),
            placeholder  = $(this).val();

            defaultPlaceholder = "5";
            offerForm.previewText(previewPrice, defaultPlaceholder, placeholder);
    });

    // display offer preview title
    offerTitleInput.on('keyup', function(ev) {
        ev.preventDefault();
        var previewTitle = $('.offer-details').find('span#title-text'),
            placeholder  = $(this).val();

            defaultPlaceholder = "a shoutout...";
            offerForm.previewText(previewTitle, defaultPlaceholder, placeholder);
    });

    // display offer, account username
    offerAccount.on("change", function(ev) {
        ev.preventDefault();
        var previewUsername = $('.offer-details').find('.offer-author a');

            if( $(this).find('option:selected').val().length ) {
                placeholder = '@' + $(this).find('option:selected').text();
            } else {
                placeholder = $(this).find('option:selected').val();
            }

            defaultPlaceholder = "@username";
            offerForm.previewText(previewUsername, defaultPlaceholder, placeholder);
    });

    // remove new line characters
    $('.field-group textarea').on('keyup', function(ev){
        ev.preventDefault();
        if(ev.keyCode == 13 && !ev.shiftKey) {
            $(this).val($(this).val().replace(/\n+/g, ''));
        }
    });

    // Automatically adjust textarea height
    offerTitleInput.autosize({ append:false });

    // initialize offerForm
    offerForm.init();
});