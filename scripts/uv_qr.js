
$(document).ready(function(){

$(document).on("click", ".btnQR", function(){
	
	var idusuario = $(this).parents("tr").children("td").eq(0).text(); 
	var name = $(this).parents("tr").children("td").eq(1).text();
	var position = $(this).parents("tr").children("td").eq(2).text();


	$("#idModalQR").modal("show");
	$("#eidPersona").val(idusuario);
	$("#modalName").text(name);
	$("#modalPosition").text(position);
	var d = new Date();
	var strdate = d.getFullYear() + "/" + (d.getMonth()+1) + "/" + d.getDate();
	//var QRencrip = $().crypt({method:"md5",source:(idusuario + strdate)});
	var QRencrip = calcMD5(idusuario + strdate);
	console.log(strdate);
	console.log(QRencrip);

	$("canvas").remove();
	$(".divQR").qrcode({
	render:'canvas',
	width: 150,
	heigth: 150,
	color: '#000',
	text: QRencrip
	});


	$.ajax({
			method: "POST",
			url: "asp/guardarQR.asp",
			data: {idUser:idusuario,qrcode:QRencrip,comm:"save"}

		}).done(function(resp){
			console.log(resp);
			
		}).fail(function(jqXHR,estado,error){
			console.log(estado);
			console.log(error);
		})

})

$(document).on("click", ".btnImprimirQR", function(){


		  // var printContent = document.querySelector("#divQR1");
		  // imprimirElemento(printContent);
		  //printDiv('divQR1')
		 $("#divQR1").printThis({
		 	debug: false,               // show the iframe for debugging
        	importCSS: false,            // import parent page css --- lo cambie a false
        	importStyle: false,         // import style tags
        	printContainer: true,       // print outer container/$.selector
        	loadCSS: "",                // path to additional css file - use an array [] for multiple
        	pageTitle: "",              // add title to print page
        	removeInline: false,        // remove inline styles from print elements
        	removeInlineSelector: "*",  // custom selectors to filter inline styles. removeInline must be true
        	printDelay: 333,            // variable print delay
        	header: null,               // prefix to html
        	footer: null,               // postfix to html
        	base: false,                // preserve the BASE tag or accept a string for the URL
        	formValues: true,           // preserve input/form values
        	canvas: true,              // copy canvas content
        	doctypeString: '<!DOCTYPE html>', // enter a different doctype for older markup
        	removeScripts: false,       // remove script tags from print content
        	copyTagClasses: false,      // copy classes from the html & body tag
        	beforePrintEvent: null,     // callback function for printEvent in iframe
        	beforePrint: null,          // function called before iframe is filled
        	afterPrint: null            // function called before iframe is removed
		 }); 
		// var WinPrint = window.open('','','width=900,heigth=650');
		// WinPrint.document.write(printContent);
		// WinPrint.document.close();
		// WinPrint.focus();
		// WinPrint.print();
		// WinPrint.close();
	
});

function imprimirElemento(elemento){
	var ventana = window.open('', 'PrintWindow', 'height=400,width=600');
 
  ventana.document.writeln(elemento.innerHTML);
 
  ventana.document.close();
  ventana.focus();
  ventana.print();
  ventana.close();
  return true;
}

function printDiv(nombreDiv) {
     var contenidoOriginal= document.body.innerHTML;
     var contenido= document.getElementById(nombreDiv).innerHTML;
     var canv = document.createElement("canvas");
     
     document.body.innerHTML = contenido;
     document.body.appendChild(canv);

     window.print();

     document.body.innerHTML = contenidoOriginal;
}


$(document).on("click", ".spanCC", function(){
	//if ($(".divQR2 input").length > 0){
		//si existe el elemento no mostramos nada
		$(".divQR2 h1").remove();
		$("#txtQR,#spanQR,.btnOK").show();
	//}
	//else{ //en caso contrario agregamos los elementos
	//	$(".divQR2 h1").remove();
		//$(".divQR2").append('<span class="input-group-addon" id="spanQR">QR:</span>')
		//$(".modal-footer").append('<button type="button" class="btn btn-primary btnOK">ok</button>')
		//$(".divQR2").append('<input type="Password" style="width:250px;" class="form-control" id="txtQR" name="QR" autofocus="true">')
	//	$("#txtQR,#spanQR,.btnOK").show();
		
	//}

	$("#modalCC").modal("show");
})

// $(document).on("click",".btnOK", function(){
// 	var paseListaQR = $("#txtQR").val();
// 	console.log(paseListaQR);
// 	if (paseListaQR==""){
// 		alert("faltan datos...")
		
// 	}
// 	else{

// 		$.ajax({
// 			method: "POST",
// 			url: "asp/guardarQR.asp",
// 			data: {qrcode:paseListaQR,comm:"paselista"}
			
// 		}).done(function(resp){
// 			console.log(resp);
// 			respuesta = resp

// 			if (respuesta == "ok"){
// 				$("#txtQR,#spanQR,.btnOK").hide();
// 				$(".divQR2 h1").remove();
// 				$(".divQR2").append('<h1 style="color:#31B404">AUTORIZADO!</h1>');
// 				$("#txtQR").val("");
// 				setTimeout("$('.close').click();", 3000);
// 			} 
// 			else{
// 				$("#txtQR,#spanQR,.btnOK").hide();
// 				$(".divQR2 h1").remove();
// 				$(".divQR2").append('<h1 style="color:#FF0000";>NO AUTORIZADO!</h1>');
// 				$("#txtQR").val("");
// 				setTimeout("$('.close').click();", 3000);
// 			}

			
			
// 		}).fail(function(jqXHR,estado,error){
// 			console.log(estado);
// 			console.log(error);
			

// 		})
// 	}

// })

$(document).on("click",".btnOK", function(){
	var paseListaQR = $("#txtQR").val();
	console.log(paseListaQR);
	if (paseListaQR==""){
		$(".divQR2 p").remove();
		$(".divQR2").append('<p style="color:#FF0000">Faltan datos...!</p>');
	}
	else{

		$.ajax({
			method: "POST",
			url: "asp/guardarQR.asp",
			data: {qrcode:paseListaQR,comm:"paselista"}
			
		}).done(function(resp){
			console.log(resp);
			respuesta = resp

			if (respuesta == "ok"){
				$(".buscaQR h3").remove();
				$(".buscaQR").append('<h3 style="color:#31B404">AUTORIZADO!</h3>');
				$("#txtQR").val("");
				$(".buscaQR h3").hide(3000);
				$("#txtQR").focus();
				
			} 
			else{
				
				$(".buscaQR h3").remove();
				$(".buscaQR").append('<h3 style="color:#FF0000";>NO AUTORIZADO!</h3>');
				$("#txtQR").val("");
				$(".buscaQR h3").hide(3000);
				$("#txtQR").focus();
				
			}

			
			
		}).fail(function(jqXHR,estado,error){
			console.log(estado);
			console.log(error);
			

		})
	}

})
$(document).keyup("#txtQR", function(e){
	
	if (e.keyCode == 13){

	var paseListaQR = $("#txtQR").val();
	console.log(paseListaQR);
	if (paseListaQR==""){
		$(".divQR2 p").remove();
		$(".divQR2").append('<p style="color:#FF0000">Faltan datos...!</p>');
		
	}
	else{

		$.ajax({
			method: "POST",
			url: "asp/guardarQR.asp",
			data: {qrcode:paseListaQR,comm:"paselista"}
			
		}).done(function(resp){
			console.log(resp);
			respuesta = resp
			return false;

			if (respuesta == "ok"){
				$(".buscaQR h3").remove();
				$(".buscaQR").append('<h3 style="color:#31B404">AUTORIZADO!</h3>');
				$("#txtQR").val("");
			} 
			else{
				$(".buscaQR h3").remove();
				$(".buscaQR").append('<h3 style="color:#FF0000";>NO AUTORIZADO!</h3>');
				$("#txtQR").val("");
			}

			
			
		})

		// .fail(function(jqXHR,estado,error){
		// 	console.log(estado);
		// 	console.log(error);
		// })
		
	}
}
		e.preventDefault();
		return false;
})



});