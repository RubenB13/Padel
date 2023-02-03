
verHorario()

function verHorario() {


  var today = new Date();
  var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
  var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
  var dateTime = date+' '+time;

  console.log(time)

hora = today.getHours()

if(hora <= 10)
{
  console.log("Se recomienda horario renta muerta: 360 pesos")
}

else if (hora >=11)

console.log("Se recomienda horario concurrida : 500 pesos")
}





