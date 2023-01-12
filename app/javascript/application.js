// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require dropzone
// // = require jquery.validate
// // = require jquery.validate.additional-methods
// // = require jquery.validate.localization/messages_uk

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

    // const observer = new MutationObserver((mutations, observer) => {
    //     console.log(mutations, observer);
    // });
    // observer.observe(document, {
    //     subtree: true,
    //     attributes: true
    // });


    // $('#modal').bind('DOMSubtreeModified', function () {
    //     console.log(123);
    //     // console.log(this);
    //     // $('#new-form').validate();
    // })

    $("#new-product").validate();

    // $("#new-product").validate({
    //     // Specify validation rules
    //     // rules: {
    //     //     // The key name on the left side is the name attribute
    //     //     // of an input field. Validation rules are defined
    //     //     // on the right side
    //     //     name: "required",
    //     //     description: "required",
    //     //     price: "required"
    //     // },
    //     // Make sure the form is submitted to the destination defined
    //     // in the "action" attribute of the form when valid
    //     submitHandler: function(form) {
    //         form.submit();
    //     }
    // });
});

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

    text.on('keyup', function(e){
        resize($(this));
    });

    function resize ($text, focus = false) {
        // $text.css('height', Math.max(...Object.values($text).map(el => el.scrollHeight).slice(0, $text.length)) + 'px');
        const elems = elements_to_resize($text);
        // elems.css('height', '0');
        console.log($text[0].scrollHeight);
        elems.css('height', `${$text[0].scrollHeight}px`);
    }

    function elements_to_resize($this) {
        return $this.parent().parent('.admin-table-texts').children().children('.autosize');
    }
}

function form_validate() {
    console.log(123);
    // console.log(this);
    // $('#new-form').validate();
}