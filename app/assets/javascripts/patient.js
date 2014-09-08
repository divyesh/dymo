$(document).ready(function () {
  $("#visit_physician_ids, #filter_physician_id, #test_test_group_id").selectize();
  $("#visit_test_ids1").selectize({
    onItemAdd: function(value, $item) {
      var $label = $("#tests_check_boxes label[data-value=\"" + value  + "\"]");
      $label.show('bounce');
      $label.find('input[type="checkbox"]').prop('checked', true);
      this.clear();
    }
  });

  $("#all_patients_cb_cont :checkbox").on("click", function () {
    if ($(this).is(":checked")) {
      $('.datefilter').css('visibility', 'hidden');
    } else {
      $('.datefilter').css('visibility', 'visible');
    }
  });

  // var ajaxInterval;
//   if($('#tokens-table-body').length > 0) {
//     var ajaxCall = function() {
//       $('#filter_token').submit();
//     }
//     ajaxInterval = setInterval(function() { ajaxCall(); }, (1000 * 60));
//   } else {
//     if(ajaxInterval) {
//       clearInterval(ajaxInterval);
//     }
//   }

  $(".print-label-link").click(function(){
    var patientName = $(this).attr("patientName");
    var healthNumber = $(this).attr("healthNumber");
    var expiry = $(this).attr("expiry");
    var dob = $(this).attr("birthdate");
    var sex = $(this).attr("sex");
    var address1 = $(this).attr("address1");
    var address2 = $(this).attr("address2");
    var homephone = $(this).attr("homephone");
    var mobile = $(this).attr("mobile");
    var physician = $(this).attr("physician");
    var visiteddate = $(this).attr("visiteddate");
    var address = address1 + address2;
    var city = $(this).attr("city");
    var province = $(this).attr("province");
    var postalcode = $(this).attr("postalcode");

    printPatientLabel(patientName, healthNumber, expiry, dob, sex,  address, city, province, postalcode, homephone, mobile, physician, visiteddate);
  });

  $(".print-physician-label-link").click(function(){

      var PhysicianNumber= $(this).attr("PhysicianNumber");
      var FirstName= $(this).attr("FirstName");
      var LastName= $(this).attr("LastName");
      var address1= $(this).attr("address1");
      var address2= $(this).attr("address2");
      var city= $(this).attr("city");
      var province= $(this).attr("province");
      var postalcode= $(this).attr("postalcode");
                var CPSO= $(this).attr("cpso");
      var phone= $(this).attr("phone");

      var Fax= $(this).attr("FAX");

      physicianLabel(PhysicianNumber,CPSO,FirstName+' '+LastName,address1,address2,city,province,postalcode,phone,Fax);

    });

  initdatepickers();
  initpatientform();


});

function disData(){

  $('#p_name').html($('#patient_lastname').val() + ' ' + $('#patient_firstname').val() + ' ' + $('#patient_middlename').val());
  $('#p_ohip').html($('#patient_healthnumber').val());
  $('#p_vc').html($('#patient_version_code').val());

  if($('#hedpicker').val() != '')
    $('#p_hed').html($.datepicker.formatDate('yy-mm-dd', new Date($('#hedpicker').val())));
  else
    $('#p_hed').html('--');

    $('#p_payment_program').html($('#payment_program').val());

  $('#p_bdate').html($.datepicker.formatDate('yy-mm-dd', new Date($('#birthdaypicker').val())));

  $('#p_address').html(
  $('#patient_address1').val() + '<br />' +
  $('#patient_address2').val() + '<br />' +
  $('#patient_city').val() + '<br />' +
  $('#patient_province').val() + '<br />' +
  $('#patient_postal_code').val() + '<br />'
  );
  $('#p_contact').html( 'Home (ph): ' + $('#patient_home_phone').val() + '<br />' + 'Mobile (ph): ' + $('#patient_mobile').val());

  $('#p_gender').html($('input[name=patient[gender]]:checked', $(this)[0]).val() == "M" ? "Male" : "Female");
  $('#p_physician').html($("#physician_id_text1").val());
  $('#p_visitdate').html($.datepicker.formatDate('yy-mm-dd', new Date($('#visitdate').val())));
  $("#test_groups").find('input[type="checkbox"]').each(function(){
    if ($(this).prop('checked')==true){
      $('#selected_tests').append('<tr><td>' + $(this).data('name') + '-' + $(this).data('code') + '<br />' + '</td></tr>');
    }
  });
}

function initdatepickers(){
  options = {
    dateFormat: 'yy/mm/dd',
    showOn: "button",
    buttonImageOnly: true
  };
  $('.datepicker-swrapper > input').datepicker(options).inputmask("y/m/d");
  $('.time > input').timepicker({
    showPeriod: true,
    showLeadingZero: true
  });

  $('#visitdate').val($.datepicker.formatDate('yy/mm/dd', new Date()));
  //
  //dirty patch to deal with focus issue with masked date input...
  //
  setTimeout(function(){
	  $('#patient_healthnumber').focus();
	},50);
}

function initpatientform(){
  $( "#menu" ).menu();
  $('#add_tests').on('click', function() {
    $("#test_dialog").dialog({
      resizable: true,
      width: 800,
      modal: true,
      close: function(event,ui){
        $('#patient_healthnumber').focus();
      },
      buttons: {
        "Save": function() {
          $(this).dialog("close");
          $("form.new_patient, form.edit_patient").submit();
        },
        "Cancel": function() {
          $(this).dialog("close");
        }
      }
    });
  });


  $("form.new_patient1, form.edit_patient1").validate({
     submitHandler: function(form) {

       // if birthdate is less than or equal today display error
       if(new Date() <= new Date($('#birthdaypicker').val())){
          alert("Birthdate can't be future date.");
          $("#birthdaypicker").focus();
          return false;
       }

       //Physician is required
       if($("#physician_id1").val() == ''){
         alert("Error! Physician not found. To remove error please add new physician from manage physicians page (Link provided in header).");
         $("#physician_id1").focus();
         return false;
       }

       // if visitdate is required
       if($('#visitdate').val() == ''){
         alert("Please enter visit date");
         $('#visitdate').focus();
         return false;
       }else if(new Date() < new Date($('#visitdate').val())){
           alert("Visit date can't be future date.");
           $("#visitdate").focus();
           return false;
        }

       disData();

       $("#dialog-confirm").dialog({
         resizable: true,
         width: 800,
         modal: true,
         close: function(event,ui){
           $('#patient_healthnumber').focus();
         },
         buttons: {
           "Yes, Save it!": function() {
             $(this).dialog("close");
             form.submit();
           },
           "No": function() {
             $(this).dialog("close");
           }
         }
       });
     }
  });


  $('#edit-patient-link').on('click', function() {
    $("#dialog-patient-edit").dialog({
      resizable: true,
      width: 800,
      modal: true,
      close: function(event,ui){

      }
    });
  });

  $('#add-patient-link').on('click', function() {
    $("#dialog-patient-add").dialog({
      resizable: true,
      width: 800,
      modal: true,
      close: function(event,ui){

      }
    });
  });
}
