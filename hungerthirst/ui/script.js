$(document).ready(function() {

    window.addEventListener("message", function(event) {
        if (event.data.update == true) {
            setProgress(event.data.hunger, '.progress-hunger');
            setProgress(event.data.thirst, '.progress-thirst');
            setProgress(event.data.inventory, '.progress-inventory');
        }
    });

    // Functions
    // Update health/thirst bars
    function setProgress(percent, element) {
        $(element).width(percent);
    }

    // Clock based on user's local hour
    function updateClock() {
        var now = new Date(),
            time = (now.getHours() < 10 ? '0' : '') + now.getHours() + ':' + (now.getMinutes() < 10 ? '0' : '') + now.getMinutes();

        document.getElementById('hour').innerHTML = [time];
        setTimeout(updateClock, 1000);
    }
    updateClock();

});