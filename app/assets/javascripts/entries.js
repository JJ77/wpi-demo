$ ( document ).ready(function() {
    var plant = $('#entry_plant_id');
    var previous = '';
    var pots = $( "#entry_pots" );

    var readyFunc = function() {
        if (plant.val() !== "") {
            $("." + plant.val()).show('fast');
            previous = plant.val();
            projectedFunc();
        };
    };

    var projectedFunc = function() {
        var entry = $("."+ plant.val());
      entry.val(Math.floor(pots.val() * .25));
    };

    readyFunc();

    plant.change(function () {
        var selection = $(this).val();

        if (previous != "") {
            $("." + previous).hide('fast');
        }

        if (selection != previous || selection != "") {
            $('.' + selection).show('fast');
            if (selection != "") {
            previous = selection;
            }
        }


    });

    pots.change(function() {
      var entry = $("."+ plant.val());
      entry.val(Math.floor(this.value * .25));
    });

});

