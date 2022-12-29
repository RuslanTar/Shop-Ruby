// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import 'bootstrap'

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