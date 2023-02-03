var fi ,ff


listarResumenBanco2()
listarResumenCaja2()
listarResumenCajaBanco2()


$("#btnBuscarResumenGeneral").click(function(){

  $('#tblResumenBanco').DataTable().destroy()
  if ($("#date_from").val() == "" || $("#date_to").val() == "") {

  }else{
    fi = $("#date_from").val()
    ff = $("#date_to").val()
    $('#tblResumenBanco').DataTable().destroy()
      $('#tblResumenCaja').DataTable().destroy()
        $('#tblResumenCajaBanco').DataTable().destroy()
    listarResumenBanco()
    listarResumenCaja()
    listarResumenCajaBanco()
  }
})

function listarResumenBanco(){
  
  $('#tblResumenBanco').dataTable({
        destroy: true,
        retrieve: true,
        responsive: true,
        pageLenght:10,
        lengthMenu: [[10, 20, 30, -1], [10, 20, 30, 'Todos']],
        ajax: 'scripts/asp/admin_Caja_Banco.asp?com=listarResumenBanco&fi='+fi+'&ff='+ff,
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

function listarResumenCaja(){
  
  $('#tblResumenCaja').dataTable({
        destroy: true,
        retrieve: true,
        responsive: true,
        pageLenght:10,
        lengthMenu: [[10, 20, 30, -1], [10, 20, 30, 'Todos']],
        ajax: 'scripts/asp/admin_Caja_Banco.asp?com=listarResumenCaja&fi='+fi+'&ff='+ff,
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

function listarResumenCajaBanco(){
  
  $('#tblResumenCajaBanco').dataTable({
        destroy: true,
        retrieve: true,
        responsive: true,
        pageLenght:10,
        lengthMenu: [[10, 20, 30, -1], [10, 20, 30, 'Todos']],
        ajax: 'scripts/asp/admin_Caja_Banco.asp?com=listarResumenCajaBanco&fi='+fi+'&ff='+ff,
        processing: true,
        type: 'POST',
          "oLanguage": {
      "sUrl": "../../libs/datatables/tableLanguaje.txt"
      },
        columns: [
          { data: "movimientos_entrada"},
          { data: "total_entrada"},
          { data: "movimientos_salida"},
          { data: "total_salida"},
          { data: "balance"}
        ],
         order:[[0,"desc"]],
    });
}






function listarResumenBanco2(){
  
  $('#tblResumenBanco').dataTable({

    });
}

function listarResumenCaja2(){
  
  $('#tblResumenCaja').dataTable({

    });
}

function listarResumenCajaBanco2(){
  
  $('#tblResumenCajaBanco').dataTable({

    });
}






