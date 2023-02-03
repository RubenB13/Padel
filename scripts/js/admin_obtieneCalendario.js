

  
  
  obtieneCalendario()
 
  var datos = "";
  var datosCancha1 =""
  var datosCancha2 =""
  var datosCancha3 =""
  var datosCancha4 =""
  var datos2 =""
  var hoy
  var mes

  function obtieneCalendario(){

      $.ajax({
         url:"scripts/asp/admin_obtieneCalendario.asp",
         method: "POST",
         cache: false,
         data: {idReg:1,comm:'getCalendario'},
         dataType: "json"
      }).done(function(rest){
        
        $.each(rest.data, function (i, item) {
          datos = datos + '{"title":"'+item.title+'","start":"'+item.start+'","end":"'+item.end+'","backgroundColor":"'+item.backgroundColor+'"},' 
        })

        $.each(rest.data2, function (i, item) {
          datosCancha2 = datosCancha2 + '{"title":"'+item.title+'","start":"'+item.start+'","end":"'+item.end+'", "backgroundColor":"'+item.backgroundColor+'"},' 
        })

        $.each(rest.data3, function (i, item) {
          datosCancha3 = datosCancha3 + '{"title":"'+item.title+'","start":"'+item.start+'","end":"'+item.end+'", "backgroundColor":"'+item.backgroundColor+'"},' 
        })

        $.each(rest.data4, function (i, item) {
          datosCancha4 = datosCancha4 + '{"title":"'+item.title+'","start":"'+item.start+'","end":"'+item.end+'", "backgroundColor":"'+item.backgroundColor+'"},' 
        })

        // console.log(datosCancha2)
        // console.log(datosCancha3)
        // console.log(datosCancha4)


        //***** llenamos el calendario de la cancha 1 *******
        datosCancha1 = datos.substring(0, datos.length -1)
        datosCancha1 = "["+datosCancha1+"]"
        datosCancha1 = JSON.parse(datosCancha1)
        hoy = new Date();

        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
          headerToolbar: {
            left: 'prevYear,prev,next,nextYear today',
            center: 'title',
            right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
          },
          initialDate: hoy,
          editable: false,
          selectable: true,
          businessHours: true,
          dayMaxEvents: true, // allow "more" link when too many events
          events: datosCancha1
        });
        calendar.render();
        //************ fin cancha 1 **************

        //***** llenamos el calendario de la cancha 2 *******
        datosCancha2 = datosCancha2.substring(0, datosCancha2.length -1)
        datosCancha2 = "["+datosCancha2+"]"
        datosCancha2 = JSON.parse(datosCancha2)
        hoy = new Date();
        // console.log(datosCancha2)

        var calendarC2 = document.getElementById('calendarCancha2');
        var calendarCancha2 = new FullCalendar.Calendar(calendarC2, {
          headerToolbar: {
            left: 'prevYear,prev,next,nextYear today',
            center: 'title',
            right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
          },
          initialDate: hoy,
          editable: false,
          selectable: true,
          businessHours: true,
          dayMaxEvents: true, // allow "more" link when too many events
          events: datosCancha2
        });
        calendarCancha2.render();
        //************ fin cancha 2 **************


        //***** llenamos el calendario de la cancha 3 *******
        datosCancha3 = datosCancha3.substring(0, datosCancha3.length -1)
        datosCancha3 = "["+datosCancha3+"]"
        datosCancha3 = JSON.parse(datosCancha3)
        hoy = new Date();

        var calendarC3 = document.getElementById('calendarCancha3');
        var calendarCancha3 = new FullCalendar.Calendar(calendarC3, {
          headerToolbar: {
            left: 'prevYear,prev,next,nextYear today',
            center: 'title',
            right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
          },
          initialDate: hoy,
          editable: false,
          selectable: true,
          businessHours: true,
          dayMaxEvents: true, // allow "more" link when too many events
          events: datosCancha3
        });
        calendarCancha3.render();
        //************ fin cancha 3 **************


        //***** llenamos el calendario de la cancha 4 *******
        datosCancha4 = datosCancha4.substring(0, datosCancha4.length -1)
        datosCancha4 = "["+datosCancha4+"]"
        datosCancha4 = JSON.parse(datosCancha4)
        hoy = new Date();

        var calendarC4 = document.getElementById('calendarCancha4');
        var calendarCancha4 = new FullCalendar.Calendar(calendarC4, {
          headerToolbar: {
            left: 'prevYear,prev,next,nextYear today',
            center: 'title',
            right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
          },
          initialDate: hoy,
          editable: false,
          selectable: true,
          businessHours: true,
          dayMaxEvents: true, // allow "more" link when too many events
          events: datosCancha4
        });
        calendarCancha4.render();
        //************ fin cancha 4 **************

        $("#calendar").show()
        $("#calendarCancha2").hide()
        $("#calendarCancha3").hide()
        $("#calendarCancha4").hide()
        $("#btnCancha11").removeClass("white").addClass("warning")

      })


      $("#btnCancha1").click(function(){
        $("#btnCancha11").removeClass("white").addClass("warning")
        $("#btnCancha22, #btnCancha33, #btnCancha44").removeClass("warning").addClass("white")

        $("#calendar").show()
        $("#calendarCancha2").hide()
        $("#calendarCancha3").hide()
        $("#calendarCancha4").hide()

      })

      $("#btnCancha2").click(function(){
        $("#btnCancha22").removeClass("white").addClass("warning")
        $("#btnCancha11, #btnCancha33, #btnCancha44").removeClass("warning").addClass("white")

        $("#calendar").hide()
        $("#calendarCancha2").show()
        $("#calendarCancha3").hide()
        $("#calendarCancha4").hide()
      })

      $("#btnCancha3").click(function(){
        $("#btnCancha33").removeClass("white").addClass("warning")
        $("#btnCancha22, #btnCancha11, #btnCancha44").removeClass("warning").addClass("white")

        $("#calendar").hide()
        $("#calendarCancha2").hide()
        $("#calendarCancha3").show()
        $("#calendarCancha4").hide()
      })

      $("#btnCancha4").click(function(){
        $("#btnCancha44").removeClass("white").addClass("warning")
        $("#btnCancha22, #btnCancha33, #btnCancha11").removeClass("warning").addClass("white")

        $("#calendar").hide()
        $("#calendarCancha2").hide()
        $("#calendarCancha3").hide()
        $("#calendarCancha4").show()
      })


  }

 
  


  

  


  






