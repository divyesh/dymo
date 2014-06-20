//= require jquery
//= require jquery_ujs
//= require DYMO.Label.Framework.1.0.beta
//= require Dymo

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
    var address = address1 + address2;
    var city = $(this).attr("city");
    var province = $(this).attr("province");
    var postalcode = $(this).attr("postal_code");

    printPatientLabel(patientName, healthNumber, expiry, dob, sex, address, city, province, postalcode, homephone, mobile, physician, visiteddate);

  });
});
