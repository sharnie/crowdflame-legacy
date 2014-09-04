$(document).ready(function() {

    $('#fullpage').fullpage();
    
    // Sign Up Form Validations
    $('.sign-up-form').bootstrapValidator({
        message: 'This value is not valid',
        fields: {
            first_name: {
                message: 'Last name is not valid',
                validators: {
                    notEmpty: {
                        message: 'First name is required'
                    },
                    stringLength: {
                        min: 2,
                        max: 35,
                        message: 'Must be between 2 - 35 characters'
                    },
                    regexp: {
                        regexp: /^[a-zA-Z_-\s]+$/,
                        message: 'Name should only include letters'
                    }
                }
            },
            last_name: {
                message: 'Last name is not valid',
                validators: {
                    notEmpty: {
                        message: 'Last name is required'
                    },
                    stringLength: {
                        min: 2,
                        max: 35,
                        message: 'Must be between 2 - 35 characters'
                    },
                    regexp: {
                        regexp: /^[a-zA-Z_-\s]+$/,
                        message: 'Name should only include letters'
                    }
                }
            },
            email: {
                validators: {
                    notEmpty: {
                        message: 'Email is required'
                    }
                }
            },
            post_code: {
                validators: {
                      notEmpty: {
                          message: 'Post code is required'
                      },
                      stringLength: {
                        min: 2,
                        max: 10,
                        message: 'Must be between 2 - 10 characters'  
                      }
                }
            }
        }
    });

});