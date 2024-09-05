// script.js

document.addEventListener('DOMContentLoaded', function () {
    const greenButton = document.querySelector('.green-button');
    const redButton = document.querySelector('.red-button');

    greenButton.addEventListener('click', function () {
        if (greenButton.style.backgroundColor === 'green') {
            greenButton.style.backgroundColor = 'black';
        } else {
            greenButton.style.backgroundColor = 'green';
        }
    });

    redButton.addEventListener('click', function () {
        if (redButton.style.backgroundColor === 'red') {
            redButton.style.backgroundColor = 'yellow';
        } else {
            redButton.style.backgroundColor = 'red';
        }
    });
});
