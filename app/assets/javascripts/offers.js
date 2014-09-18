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
    }
}


// display offer preview title
offerTitleInput.on('keyup', function(ev) {
    ev.preventDefault();
    var previewTitle = $('.offer-details').find('span#title-text'),
        placeholder  = $(this).val();

        defaultPlaceholder = "a shoutout...";
        offerForm.previewText(previewTitle, defaultPlaceholder, placeholder);
});

// display offer, account username
$('#new_offer').on('click', 'ul.dropdown-menu li a', function(ev) {
    ev.preventDefault();
    var previewUsername = $('.offer-details').find('.offer-author a');

        if( $(ev.target).closest('.col-sm-6').find('#socialconnection_id').length ) {
            placeholder        = '@' + $(this).text();
            defaultPlaceholder = "@username";
            offerForm.previewText(previewUsername, defaultPlaceholder, placeholder);
        }
});

// remove new line characters
$('.field-group textarea').on('keyup', function(ev){
    ev.preventDefault();
    if(ev.keyCode == 13 && !ev.shiftKey) {
        $(this).val($(this).val().replace(/\n+/g, ''));
    }
});

$(document).ready( offerForm.init() );

// activate placeholder slideshow
CrowdFlame.placeholderSlide('#offer_title', ["for a shoutout", "for fan poster", "for media feedbacks"]);