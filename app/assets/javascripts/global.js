var CrowdFlame = {
    init: function() {
      // init select with class name
      CrowdFlame.select('.cf-select');
    },
    select: function(selector) {
        var selectElements = $(selector);

        // Element Attr
        // title             = select display text (Working)
        // data-button-class = css class for button (Working)
        // data-button-id    = css id for button

        $.each(selectElements, function(index, selectElement){
            $(selectElement).hide();

            // select class
            buttonClass = $(selectElement).data('button-class') || 'btn btn-primary';

            // create select model
            var selectModel =
            $('<div/>', {
                class : 'btn-group',
                'id'  : 'cf-select' + index
            }).append(
                $('<button/>', {
                    'class'       : buttonClass + ' dropdown-toggle',
                    'data-toggle' : 'dropdown',
                })
            ).append( $('<ul/>',  { 'class' : 'dropdown-menu', 'role' : 'menu' }) ); // create ul

            selectCaret = '<span class="caret"></span><span class="sr-only">Toggle Dropdown</span>';

            // use value from title attribute or grab first option from select
            selectDisplayText = $(selectElement).find('option:selected').text() ||
                                $(selectElement).attr('title') ||
                                $(selectElement).find('option:first').text(); 

            selectButton      = selectModel.find('button').html( selectDisplayText + " " + selectCaret );
            selectList        = selectModel.find('ul.dropdown-menu');

            // iterate through each select option then add it to select modal
            $.each( $(selectElement).find('option'), function(index, option) {
                $('<li/>').append(
                    $('<a/>', {
                        href         : '#',
                        text         : $(option).text(),
                        'data-value' : $(option).val() || "",
                    })
                ).appendTo(selectList);
            });

            // insert below original select
            selectModel.insertAfter( $(selectElement) );

            // assign new value on click
            $(selectModel).on('click', 'ul.dropdown-menu li a', function(ev) {
                ev.preventDefault();

                $( selectElement ).val( $(this).data('value') ); // change value of original select

                // change display text for ul
                button = $(this).closest('.btn-group').find('button');
                button.text( $(this).text() || $(this).data('value') );
                button.append( " " + selectCaret );

                // selectedOption = $( selectElement ).find('select > option[value='+ $(this).data('value') +']')
                // console.log( selectedOption.prop('selected', true) );
            });

        });
    },
    placeholderSlide: function(selector, placeholderTextArray) {
        loop = 0; // start loop at 0 index
        setInterval(function(){
            $( selector ).attr('placeholder', placeholderTextArray[loop]);
            loop++; // increment loop count
            if(loop >= placeholderTextArray.length) { // start over when finish
                loop = 0;
            }
        }, 1500); // do this every 1.5 seconds
    }
}

$(document).ready( CrowdFlame.init() );