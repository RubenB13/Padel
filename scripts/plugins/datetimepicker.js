(function ($) {
	"use strict";

  var init = function(){

    $('#datetimepicker1').datetimepicker();
    $('#datetimepicker2').datetimepicker();
    $('#datetimepicker3').datetimepicker({locale: 'ru'});
    $('#datetimepicker4').datetimepicker({format: 'L'});
    $('#datetimepicker5').datetimepicker({format: 'LT'});
    $('#datetimepicker6').datetimepicker({
      disabledDates: [
          moment().add(1,'d'), moment().add(-1,'d')
      ]
    });
    $('#datetimepicker7').datetimepicker({
      daysOfWeekDisabled: [0, 6]
    });
    $('#datetimepicker8').datetimepicker({
      viewMode: 'years'
    });

    $('#datetimepicker9').datetimepicker();
    $('#datetimepicker10').datetimepicker({
        useCurrent: false
    });
    $("#datetimepicker9").on("change.datetimepicker", function (e) {
        $('#datetimepicker10').datetimepicker('minDate', e.date);
    });
    $("#datetimepicker10").on("change.datetimepicker", function (e) {
        $('#datetimepicker9').datetimepicker('maxDate', e.date);
    });

    $('#datetimepicker11').datetimepicker({
      format: 'DD/MM/YYYY',
      inline: true,
      sideBySide: true
    });

    $('#txthorarioInicioC1').datetimepicker({format: 'HH:mm'});
    $('#txthorarioFinC1').datetimepicker({
        useCurrent: false, format: 'HH:mm'
    });

    $("#txthorarioInicioC1").on("change.datetimepicker", function (e) {
        $('#txthorarioFinC1').datetimepicker('minDate', e.date );
    });
    $("#txthorarioFinC1").on("change.datetimepicker", function (e) {
        $('#txthorarioInicioC1').datetimepicker('maxDate', e.date);
    });

     $('#txtfechaInscrpcion').datetimepicker({format: 'L'});
     $('#txtUltimaFechadePago').datetimepicker({format: 'L'});

     // horarios tipo Academia
    $('#txtFechaReservaC1').datetimepicker({format: 'L'});
    $('#txtFechaReservaC2').datetimepicker({format: 'L'});
    $('#txtFechaReservaC3').datetimepicker({format: 'L'});
    $('#txtFechaReservaC4').datetimepicker({format: 'L'});
    $('#txtFechaReservaC5').datetimepicker({format: 'L'});
    $('#txtFechaReservaC6').datetimepicker({format: 'L'});
    $('#txtFechaReservaC7').datetimepicker({format: 'L'});
    $('#txtFechaReservaC8').datetimepicker({format: 'L'});

		//Horarios ingresos y Egresos
		$('#txtFechaRealizada').datetimepicker({format: 'L'});
		$('#txtEgFecha').datetimepicker({format: 'L'});


    $('#txthorarioInicioC2').datetimepicker({format: 'HH:mm'});
    $('#txthorarioFinC2').datetimepicker({
        useCurrent: false, format: 'HH:mm'
    });

    $("#txthorarioInicioC2").on("change.datetimepicker", function (e) {
        $('#txthorarioFinC2').datetimepicker('minDate', e.date );
    });
    $("#txthorarioFinC2").on("change.datetimepicker", function (e) {
        $('#txthorarioInicioC2').datetimepicker('maxDate', e.date);
    });

    $('#txthorarioInicioC3').datetimepicker({format: 'HH:mm'});
    $('#txthorarioFinC3').datetimepicker({
        useCurrent: false, format: 'HH:mm'
    });

    $("#txthorarioInicioC3").on("change.datetimepicker", function (e) {
        $('#txthorarioFinC3').datetimepicker('minDate', e.date );
    });
    $("#txthorarioFinC3").on("change.datetimepicker", function (e) {
        $('#txthorarioInicioC3').datetimepicker('maxDate', e.date);
    });

    $('#txthorarioInicioC4').datetimepicker({format: 'HH:mm'});
    $('#txthorarioFinC4').datetimepicker({
        useCurrent: false, format: 'HH:mm'
    });

    $("#txthorarioInicioC4").on("change.datetimepicker", function (e) {
        $('#txthorarioFinC4').datetimepicker('minDate', e.date );
    });
    $("#txthorarioFinC4").on("change.datetimepicker", function (e) {
        $('#txthorarioInicioC4').datetimepicker('maxDate', e.date);
    });

    $('#txthorarioInicioC5').datetimepicker({format: 'HH:mm'});
    $('#txthorarioFinC5').datetimepicker({
        useCurrent: false, format: 'HH:mm'
    });

    $("#txthorarioInicioC5").on("change.datetimepicker", function (e) {
        $('#txthorarioFinC5').datetimepicker('minDate', e.date );
    });
    $("#txthorarioFinC5").on("change.datetimepicker", function (e) {
        $('#txthorarioInicioC5').datetimepicker('maxDate', e.date);
    });

    $('#txthorarioInicioC6').datetimepicker({format: 'HH:mm'});
    $('#txthorarioFinC6').datetimepicker({
        useCurrent: false, format: 'HH:mm'
    });

    $("#txthorarioInicioC6").on("change.datetimepicker", function (e) {
        $('#txthorarioFinC6').datetimepicker('minDate', e.date );
    });
    $("#txthorarioFinC6").on("change.datetimepicker", function (e) {
        $('#txthorarioInicioC6').datetimepicker('maxDate', e.date);
    });

    $('#txthorarioInicioC7').datetimepicker({format: 'HH:mm'});
    $('#txthorarioFinC7').datetimepicker({
        useCurrent: false, format: 'HH:mm'
    });

    $("#txthorarioInicioC7").on("change.datetimepicker", function (e) {
        $('#txthorarioFinC7').datetimepicker('minDate', e.date );
    });
    $("#txthorarioFinC7").on("change.datetimepicker", function (e) {
        $('#txthorarioInicioC7').datetimepicker('maxDate', e.date);
    });

    $('#txthorarioInicioC8').datetimepicker({format: 'HH:mm'});
    $('#txthorarioFinC8').datetimepicker({
        useCurrent: false, format: 'HH:mm'
    });

    $("#txthorarioInicioC8").on("change.datetimepicker", function (e) {
        $('#txthorarioFinC8').datetimepicker('minDate', e.date );
    });
    $("#txthorarioFinC8").on("change.datetimepicker", function (e) {
        $('#txthorarioInicioC8').datetimepicker('maxDate', e.date);
    });

    // fecha busqueda reservaciones por periodo
    // $('#date_from').datetimepicker({format: 'L'});
    // $('#date_to').datetimepicker({
    //     format: 'L',
    //     useCurrent: false
    // });
    // $("#date_from").on("change.datetimepicker", function (e) {
    //     $('#date_to').datetimepicker('minDate', e.date);
    // });
    // $("#date_to").on("change.datetimepicker", function (e) {
    //     $('#date_from').datetimepicker('maxDate', e.date);
    // });

    $('#date_from').datetimepicker({format: 'L'});
    $('#date_to').datetimepicker({format: 'L'});

    $('#fecha_inicial').datetimepicker({format: 'L'});
    $('#fecha_final').datetimepicker({format: 'L'});
  }

  // for ajax to init again
  $.fn.datetimepicker.init = init;

})(jQuery);
