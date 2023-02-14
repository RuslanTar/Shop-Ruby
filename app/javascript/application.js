// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require dropzone
// require jquery.validate
// require jquery.validate.additional-methods
// require jquery.validate.localization/messages_uk

import "@hotwired/turbo-rails"
import "controllers"
import 'bootstrap'
import "jquery"
import "jquery_ujs"
import "@popperjs/core"
import "jquery-validation"

// //= require rails-ujs
// //= require jquery
// //= require_tree .

// //= require fontawesome/all
// FontAwesome.config.mutateApproach = 'sync'

document.addEventListener("turbo:load", () => {
    switcherState();
    switchMode(document.getElementById("darkmode-toggle"));

    document.querySelectorAll('.color_mode_button').forEach((button) => {
        button.addEventListener('click', (event) => {
            const targetElement = /** @type {HTMLElement} */ (event.currentTarget);
            switchMode(targetElement);
        });
    });

    autosize();
    price_range();
    validations();
});

function validations() {
    $('.user-form').each(function () {
        console.log($(this))
        $(this).validate({
            messages: {
                'user[name]': {
                    required: "Please enter user name"
                },
                'user[email]': {
                    required: "Please enter email address",
                    email: 'Please enter a valid email address'
                },
                'user[password]': {
                    required: "Please enter password",
                    minlength: "Please enter password with at least 6 symbols length"
                },
                'user[password_confirmation]': {
                    equalTo: "Enter the same value as above"
                }
            },
            rules: {
                'user[name]': {
                    required: true
                },
                'user[email]': {
                    required: true,
                    email: true
                },
                'user[password]': {
                    required: true,
                    minlength: 6
                },
                'user[password_confirmation]': {
                    equalTo: "#password"
                }
            },
            // Make sure the form is submitted to the destination defined
            // in the "action" attribute of the form when valid
            submitHandler: function(form) {
                if (form.id === 'new-user') {
                    $('#new_user_modal_close').trigger('click');
                    form.submit();
                    form.reset();
                } else {
                    form.submit();
                }
            }
        });
    });

    $('.product-form').each(function () {
        $(this).validate({
            messages: {
                'product[name]': {
                    required: "Please enter product name"
                },
                'product[description]': {
                    required: "Please enter description"
                },
                'product[price]': {
                    required: "Price required",
                    number: "Enter a number please",
                    min: "Price must be greater than 0"
                }
            },
            rules: {
                'product[name]': {
                    required: true
                },
                'product[description]': {
                    required: true
                },
                'product[price]': {
                    required: true,
                    number: true,
                    min: 0
                }
            },
            // Make sure the form is submitted to the destination defined
            // in the "action" attribute of the form when valid
            submitHandler: function(form) {
                if (form.id === 'new-product') {
                    $('#new_product_modal_close').trigger('click');
                    form.submit();
                    form.reset();
                } else {
                    form.submit();
                }
            }
        });
    });
}

function switcherState() {
    // Assuming the default color mode is 'light' in Step 1.
    const matcher = window.matchMedia('(prefers-color-scheme: dark)');
    if (localStorage.getItem('data-color-mode') === 'dark' ||
        (matcher.matches && !localStorage.getItem('data-color-mode'))) {
        document.documentElement.setAttribute('data-color-mode', 'dark');
        document.getElementsByClassName('color_mode_button')[0].setAttribute('checked', '')
    }
}

function switchLight(style) {
    style.setProperty('--switcher-background', 'var(--bs-light)');
    style.setProperty('--switcher-moon', '#7e7e7e');
    style.setProperty('--switcher-sun', 'var(--bs-white)');
    style.setProperty('--switcher-left', '2px');
    style.setProperty('--switcher-transform', 'translateX(0)');
    style.setProperty('--switcher-gradient', 'linear-gradient(180deg,#ffcc89,#d8860b)');
}

function switchDark(style) {
    style.setProperty('--switcher-background', 'var(--bs-dark)');
    style.setProperty('--switcher-moon', 'var(--bs-white)');
    style.setProperty('--switcher-sun', '#7e7e7e');
    style.setProperty('--switcher-left', '58px');
    style.setProperty('--switcher-transform', 'translateX(-100%)');
    style.setProperty('--switcher-gradient', 'linear-gradient(180deg,#777,#3a3a3a)');
}

function switchMode(targetElement) {
    const checked = targetElement.checked;
    let root_style = document.querySelector(':root').style;
    if (!checked) {
        document.documentElement.setAttribute('data-color-mode', 'light');
        localStorage.setItem('data-color-mode', 'light');
        switchLight(root_style);
    } else if (checked) {
        document.documentElement.setAttribute('data-color-mode', 'dark');
        localStorage.setItem('data-color-mode', 'dark');
        switchDark(root_style);
    } else {
        throw new Error(`unrecognized color mode button id ${targetElement}.`)
    }
}

function autosize(){
    let text = $('.autosize');

    text.on('focus', function(){
        // $(this).css('height', 'calc(3rem + ' + $(this)[0].scrollHeight + 'px)');

        resize($(this), true);
    });

    text.on('focusout', function(){
        const elems = elements_to_resize($(this));
        elems.css('height', '50px');
    });

    text.on('keyup', function(){
        resize($(this));
    });

    function resize ($text) {
        // $text.css('height', Math.max(...Object.values($text).map(el => el.scrollHeight).slice(0, $text.length)) + 'px');
        const elems = elements_to_resize($text);
        // elems.css('height', '0');
        elems.css('height', `${$text[0].scrollHeight}px`);
    }

    function elements_to_resize($this) {
        return $this.parent().parent().parent('.admin-table-texts').children().children().children('.autosize');
    }
}

function price_range() {
    const rangeInput = document.querySelectorAll(".range-input input"),
        priceInput = document.querySelectorAll(".price-input input"),
        range = document.querySelector(".slider .progress");
    let priceGap = 1;

    if (range != undefined) {
        range.style.left = ((priceInput[0].value / rangeInput[0].max) * 100) + "%";
        range.style.right = 100 - (priceInput[1].value / rangeInput[1].max) * 100 + "%";
    }

    priceInput.forEach(input =>{
        input.addEventListener("input", e =>{
            let minPrice = parseInt(priceInput[0].value),
                maxPrice = parseInt(priceInput[1].value);

            if((maxPrice - minPrice >= priceGap) && (minPrice >= rangeInput[0].min) && (maxPrice <= rangeInput[1].max)){
                if(e.target.className === "input-min"){
                    rangeInput[0].value = minPrice;
                    range.style.left = ((minPrice / rangeInput[0].max) * 100) + "%";
                }else{
                    rangeInput[1].value = maxPrice;
                    range.style.right = 100 - (maxPrice / rangeInput[1].max) * 100 + "%";
                }
            }
        });
    });

    rangeInput.forEach(input =>{
        input.addEventListener("input", e =>{
            let minVal = parseInt(rangeInput[0].value),
                maxVal = parseInt(rangeInput[1].value);
            if((maxVal - minVal) < priceGap){
                if(e.target.className === "range-min"){
                    rangeInput[0].value = maxVal - priceGap
                }else{
                    rangeInput[1].value = minVal + priceGap;
                }
                priceInput[0].value = rangeInput[0].value;
                priceInput[1].value = rangeInput[1].value;
                range.style.left = ((priceInput[0].value / rangeInput[0].max) * 100) + "%";
                range.style.right = 100 - (priceInput[1].value / rangeInput[1].max) * 100 + "%";
            }else{
                priceInput[0].value = minVal;
                priceInput[1].value = maxVal;

                range.style.left = ((minVal / rangeInput[0].max) * 100) + "%";
                range.style.right = 100 - (maxVal / rangeInput[1].max) * 100 + "%";
            }
            // range.style.left = ((minVal / rangeInput[0].max) * 100) + "%";
            // range.style.right = 100 - (maxVal / rangeInput[1].max) * 100 + "%";
        });
    });
}
