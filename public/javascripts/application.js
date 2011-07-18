// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
//function printPatientLabel(PatientName, healthNumber, expiry, dob, sex, address1, address2, homephone, mobile) {

$(document).ready(function () {
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

    printPatientLabel(patientName, healthNumber, expiry, dob, sex, address1, address2, homephone, mobile, physician, visiteddate);

  });
});
