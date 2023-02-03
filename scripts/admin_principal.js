let date = new Date();
console.log('imprimir fechas actual'+date.toLocaleDateString());
document.getElementById('fecha-actual').innerHTML = date

obtenerAgendas()
function obtenerAgendas(){
  let DiaActual= new Date();
  DiaActual.toLocaleDateString();
  console.log('imprimir fecha en la funcion'+DiaActual.toLocaleDateString());
  //  document.getElementById('agendaDia').innerHTML = DiaActual
 $.ajax({
    url:"scripts/asp/admin_datosPrincipal.asp",
    cache: false,
    data: {comm:"agendaPordia", fecha_actual:DiaActual},
    dataType: "json",
    method: "POST"
  }).done(function(rest){
      $.each(rest.data,  function(i,item) {
        $("#agendaDia").val(item.fecha_renta)
        console.log('imprimir'+ item.fecha_renta);
      });
    })
}
