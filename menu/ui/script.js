$(document).ready(function() {
    // Mouse Controls
    var documentWidth = document.documentElement.clientWidth;
    var documentHeight = document.documentElement.clientHeight;
    var cursor = $('#cursorPointer');
    var cursorX = documentWidth / 2;
    var cursorY = documentHeight / 2;
    var idEnt = 0;

    function UpdateCursorPos() {
        $('#cursorPointer').css('left', cursorX);
        $('#cursorPointer').css('top', cursorY);
    }

    function triggerClick(x, y) {
        var element = $(document.elementFromPoint(x, y));
        element.focus().click();
        return true;
    }

    // Listen for NUI Events
    window.addEventListener('message', function(event) {
        // Crosshair
        if (event.data.crosshair == true) {
            $(".crosshair").addClass('fadeIn');
            // $("#cursorPointer").css("display","block");
        }
        if (event.data.crosshair == false) {
            $(".crosshair").removeClass('fadeIn');
            // $("#cursorPointer").css("display","none");
        }

        // Menu
        if (event.data.menu == 'vehicle') {
            $(".crosshair").addClass('active');
            $(".menu-car").addClass('fadeIn');
            idEnt = event.data.idEntity;
            // $("#cursorPointer").css("display","none");
        }
        if (event.data.menu == 'user') {
            $(".crosshair").addClass('active');
            $(".menu-user").addClass('fadeIn');
            idEnt = event.data.idEntity;
            // $("#cursorPointer").css("display","none");
        }
        if ((event.data.menu == false)) {
            $(".crosshair").removeClass('active');
            $(".menu").removeClass('fadeIn');
            idEnt = 0;
        }

        // Click
        if (event.data.type == "click") {
            triggerClick(cursorX - 1, cursorY - 1);
        }
    });

    // Mousemove
    $(document).mousemove(function(event) {
        cursorX = event.pageX;
        cursorY = event.pageY;
        UpdateCursorPos();
    });

    // Click Menu

    // Functions
    // Vehicle
    $('.openCoffre').on('click', function(e) {
        e.preventDefault();
        $.post('http://menu/togglecoffre', JSON.stringify({
            id: idEnt
        }));
        $(this).find('.text').text($(this).find('.text').text() == 'Ouvrir le coffre' ? 'Fermer le coffre' : 'Ouvrir le coffre');
    });

    $('.openCapot').on('click', function(e) {
        e.preventDefault();
        $.post('http://menu/togglecapot', JSON.stringify({
            id: idEnt
        }));
        $(this).find('.text').text($(this).find('.text').text() == 'Ouvrir le capot' ? 'Fermer le capot' : 'Ouvrir le capot');
    });

    $('.lock').on('click', function(e) {
        e.preventDefault();
        $.post('http://menu/togglelock', JSON.stringify({
            id: idEnt
        }));
        $(this).find('.text').text($(this).find('.text').text() == 'Verrouiller' ? 'Déverouiller' : 'Verrouiller');
    });

    // Functions
    // User
    $('.cheer').on('click', function(e) {
        e.preventDefault();
        $.post('http://menu/cheer', JSON.stringify({
            id: idEnt
        }));
    });


    // Click Crosshair
    $('.crosshair').on('click', function(e) {
        e.preventDefault();
        $(".crosshair").removeClass('fadeIn').removeClass('active');
        $(".menu").removeClass('fadeIn');
        $.post('http://menu/disablenuifocus', JSON.stringify({
            nuifocus: false
        }));
    });
    $(document).keypress(function(e) {
        if (e.which == 101) { // if "E" is pressed
            $(".crosshair").removeClass('fadeIn').removeClass('active');
            $(".menu").removeClass('fadeIn');
            $.post('http://menu/disablenuifocus', JSON.stringify({
                nuifocus: false
            }));
        }
    });

});