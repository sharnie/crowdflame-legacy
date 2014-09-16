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

// display offer username
offerAccount.on('change', function(ev) {
    console.log(this.value)
    // $('.offer-author a')
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
CrowdFlame.placeholderSlide('#offer_title', ["for a shoutout", "for likes on every picture", ""]);