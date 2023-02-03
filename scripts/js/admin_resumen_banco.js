var fi, ff

$("#btnBuscarHistorialBanco").click(function(){
  if ($("#date_from").val() == "" || $("#date_to").val() == "") {
alert("coloque las fechas de consulta")
  }else{
    fi = $("#date_from").val()
    ff = $("#date_to").val()

    $('#tblResumenBanco').DataTable().destroy();
    $('#tblTransaccionesBanco').DataTable().destroy();
    $('#tblHistorialBanco').DataTable().destroy();
    $('#tblTipoTrans').DataTable().destroy();
    verclastrans()
    listarResumenBanco()
    listarTransaccioneslBanco()
    listarHistorialBanco()
  }
})

function listarResumenBanco(){
  
  $('#tblResumenBanco').dataTable({
        destroy: true,
        retrieve: true,
        responsive: true,
        pageLenght:10,
        lengthMenu: [[10, 20, 30, -1], [10, 20, 30, 'Todos']],
        ajax: 'scripts/asp/admin_resumen_banco.asp?com=listarResumenBanco&fi='+fi+'&ff='+ff,
        processing: true,
        type: 'POST',
          "oLanguage": {
      "sUrl": "../../libs/datatables/tableLanguaje.txt"
      },
        columns: [
          { data: "concepto"},
          { data: "total_entrada"},
          { data: "total_salida"},
          { data: "balance"}
        ],
         order:[[0,"desc"]],
    });
}

  // vemos tipo/clase de transcacciones 

  function verclastrans(){

    $('#tblTipoTrans').dataTable({
      destroy: true,
      retrieve: true,
      responsive: true,
      ajax: 'scripts/asp/admin_resumen_banco.asp?com=consultaClas&fi='+fi+'&ff='+ff,
      processing: true,
      type: 'POST',
        "oLanguage": {
    "sUrl": "../../libs/datatables/tableLanguaje.txt"
    },
      columns: [
        { data: "Concepto"},
        { data: "clip"},
        { data: "transferencia"},
        { data: "deposito"},
        { data: "comision"},
        { data: "total"}
         ]
    });
 
    

  }

function listarTransaccioneslBanco(){
  
  $('#tblTransaccionesBanco').dataTable({
      destroy: true,
      retrieve: true,
      responsive: true,
      pageLenght:10,
      lengthMenu: [[10, 20, 30, -1], [10, 20, 30, 'Todos']],
      ajax: 'scripts/asp/admin_resumen_banco.asp?com=listarTransaccionesBanco&fi='+fi+'&ff='+ff,
      processing: true,
      type: 'POST',
        "oLanguage": {
    "sUrl": "../../libs/datatables/tableLanguaje.txt"
    },
      columns: [
        { data: "concepto"},
        { data: "pago_servicios"},
        { data: "pago_parcial"},
        { data: "pago_adelantado"},
        { data: "ventas"},
        { data: "otros"},
        { data: "cclip"},
        { data: "cbanco"}
      ],
       order:[[0,"asc"]],
  });
}



function listarHistorialBanco(){
  
  $('#tblHistorialBanco').dataTable({
        destroy: true,
        retrieve: true,
        responsive: true,
        pageLenght:10,
        lengthMenu: [[10, 20, 30, -1], [10, 20, 30, 'Todos']],
        ajax: 'scripts/asp/admin_resumen_banco.asp?com=listarHistorialBanco&fi='+fi+'&ff='+ff,
        processing: true,
        type: 'POST',
          "oLanguage": {
      "sUrl": "css/tableLanguaje.txt"
      },
        columns: [
          { data: "id"},
          { data: "descripcion"},
          { data: "tipo"},
          { data: "clasificacion"},
          { data: "tipo_transaccion"},
          { data: "fecha"},
          { data: "responsable"},
          { data: "monto"},
          { data: "accion"}
        ],
         order:[[0,"desc"]],
    });
}

function eliminarTransaccion(idTra){
  if (confirm("Esta acción elimanará el registro, ¿Estas seguro?")) {
    $.ajax({
      url: "scripts/asp/admin_guardaTransBanco.asp",
      cache:false,
      dataType:"json",
      data: {comm:"eliminarTransaccion", idReg:idTra},
      method: "POST"
    }).done(function(rest){
      $.each(rest.data, function (i, item) {
       if (item.ok=="ok") {
        reiniciaConsulta()
        }
       })
       console.log(rest);
    }).fail(function(jqXHR,estado,error){
      console.log(estado);
      console.log(error);
    }) 
  }
  
}


function reiniciaConsulta(){
  $('#tblResumenBanco').DataTable().destroy();
  $('#tblTransaccionesBanco').DataTable().destroy();
  $('#tblHistorialBanco').DataTable().destroy();
  $('#tblTipoTrans').DataTable().destroy();
  verclastrans()
  listarResumenBanco()
  listarTransaccioneslBanco()
  listarHistorialBanco()

}