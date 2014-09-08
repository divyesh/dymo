function printPatientLabel(PatientName, healthNumber, expiry, dob, sex, address, city, province, postalcode, homephone, mobile, physician, visiteddate) {
    try {



        var labelXml =  PatientLabel();
	//debugger;
        var label = dymo.label.framework.openLabelXml(labelXml);


            var ph;
	    if (homephone=='undefined' || mobile == 'undefined')
                 ph = '';
	    else if (homephone=='undefined' && mobile != 'undefined')
                ph = 'M: ' + mobile;

            else if (homephone != 'undefined' || mobile != 'undefined')
                ph = 'H: ' + homephone + '; ' + mobile+'';
            else if (homephone != 'undefined' || mobile == 'undefined')
                ph = 'H: ' + homephone;

            // set label text
	    var now = new Date();


            label.setObjectText("PATIENT_NAME", PatientName);
    	    label.setObjectText("HEALTH_NUMBER",healthNumber);
            label.setObjectText("EXPIRY_DATE",'Ex:'+ expiry);
            label.setObjectText("BIRTH_DATE_SEX",dob + '(' + sex+')');
            label.setObjectText("ADDRESS_PHONE", address +',\n'+ city +', '+ province+', ' + postalcode+'\n'+ph);
            label.setObjectText("DOCTOR",physician);
            label.setObjectText("COLLECTION_DATE_TIME",'['+visiteddate+' '+now.getHours() +':'+now.getMinutes()+':'+now.getSeconds()+']');


            // select printer to print on
            // for simplicity sake just use the first LabelWriter printer
            var printers = dymo.label.framework.getPrinters();
            if (printers.length == 0)
                throw "No DYMO printers are installed. Install DYMO printers.";

            var printerName = "";
            for (var i = 0; i < printers.length; ++i) {
                var printer = printers[i];
                if (printer.printerType == "LabelWriterPrinter") {
                    printerName = printer.name;
                    break;
                }
            }

            if (printerName == "")
                throw "No LabelWriter printers found. Install LabelWriter printer";

            // finally print the label
            var num = window.prompt('How many Labels you wants to print?', '1');
            if (null == num)
                num = 0;
	    if(num!=0 ){
		num=num>=20?20:num;
            for (var i = 0; i < num; i++)
	    {
            	label.print(printerName);
            }
			}
	    num=0;

    } catch (e) {
        alert(e.message || e);
    }
}
function PatientLabel() {
var xml='<?xml version="1.0" encoding="utf-8"?>'+
'<DieCutLabel Version="8.0" Units="twips">'+
'<PaperOrientation>Landscape</PaperOrientation>'+
'<Id>Address</Id>'+
'<PaperName>30252 Address</PaperName>'+
'<DrawCommands>	<RoundRectangle X="0" Y="0" Width="1581" Height="5040" Rx="270" Ry="270" /></DrawCommands>'+
'<ObjectInfo><AddressObject>'+
'<Name>PATIENT_NAME</Name><ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />'+
'<LinkedObjectName></LinkedObjectName><Rotation>Rotation0</Rotation>'+
'<IsMirrored>False</IsMirrored><IsVariable>True</IsVariable>'+
'<HorizontalAlignment>Left</HorizontalAlignment>'+
'<VerticalAlignment>Middle</VerticalAlignment><TextFitMode>ShrinkToFit</TextFitMode>'+
'<UseFullFontHeight>True</UseFullFontHeight><Verticalized>False</Verticalized>'+
'<StyledText><Element><String></String>'+
'<Attributes><Font Family="Arial" Size="10" Bold="True" Italic="False" Underline="False" Strikeout="False" />'+
'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" /></Attributes></Element></StyledText>'+
'<ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly><BarcodePosition>Suppress</BarcodePosition>'+
'<LineFonts><Font Family="Arial" Size="10" Bold="True" Italic="False" Underline="False" Strikeout="False" />'+
'</LineFonts></AddressObject><Bounds X="331" Y="74.9999999999998" Width="4456" Height="270" />'+
'</ObjectInfo><ObjectInfo><TextObject><Name>HEALTH_NUMBER</Name>'+
'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />'+
'<LinkedObjectName></LinkedObjectName>'+
'<Rotation>Rotation0</Rotation><IsMirrored>False</IsMirrored>'+
'<IsVariable>False</IsVariable><HorizontalAlignment>Left</HorizontalAlignment>'+
'<VerticalAlignment>Top</VerticalAlignment><TextFitMode>ShrinkToFit</TextFitMode>'+
'<UseFullFontHeight>True</UseFullFontHeight>'+
'<Verticalized>False</Verticalized><StyledText>'+
'<Element><String></String>'+
'<Attributes><Font Family="Arial" Size="10" Bold="True" Italic="False" Underline="False" Strikeout="False" />'+
'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" /></Attributes></Element></StyledText></TextObject>'+
'<Bounds X="331" Y="300" Width="1650" Height="255" /></ObjectInfo>'+
'<ObjectInfo><TextObject><Name>EXPIRY_DATE</Name>'+
'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />'+
'<LinkedObjectName></LinkedObjectName>'+
'<Rotation>Rotation0</Rotation><IsMirrored>False</IsMirrored>'+
'<IsVariable>False</IsVariable><HorizontalAlignment>Left</HorizontalAlignment>'+
'<VerticalAlignment>Top</VerticalAlignment><TextFitMode>ShrinkToFit</TextFitMode>'+
'<UseFullFontHeight>True</UseFullFontHeight><Verticalized>False</Verticalized>'+
'<StyledText><Element><String></String>'+
'<Attributes><Font Family="Arial" Size="8" Bold="False" Italic="False" Underline="False" Strikeout="False" />'+
'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" /></Attributes></Element></StyledText></TextObject>'+
'<Bounds X="1863" Y="315" Width="2880" Height="240" /></ObjectInfo>'+
'<ObjectInfo><TextObject><Name>BIRTH_DATE_SEX</Name>'+
'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" /><BackColor Alpha="0" Red="255" Green="255" Blue="255" />'+
'<LinkedObjectName></LinkedObjectName><Rotation>Rotation0</Rotation>'+
'<IsMirrored>False</IsMirrored><IsVariable>False</IsVariable><HorizontalAlignment>Left</HorizontalAlignment>'+
'<VerticalAlignment>Top</VerticalAlignment><TextFitMode>ShrinkToFit</TextFitMode>'+
'<UseFullFontHeight>True</UseFullFontHeight><Verticalized>False</Verticalized>'+
'<StyledText><Element><String></String>'+
'<Attributes><Font Family="Arial" Size="10" Bold="True" Italic="False" Underline="False" Strikeout="False" />'+
'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" /></Attributes>'+
'</Element></StyledText></TextObject><Bounds X="331" Y="495" Width="1485" Height="240" />'+
'</ObjectInfo><ObjectInfo><TextObject><Name>ADDRESS_PHONE</Name><ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
'<BackColor Alpha="0" Red="255" Green="255" Blue="255" /><LinkedObjectName></LinkedObjectName>'+
'<Rotation>Rotation0</Rotation><IsMirrored>False</IsMirrored>'+
'<IsVariable>False</IsVariable><HorizontalAlignment>Left</HorizontalAlignment>'+
'<VerticalAlignment>Top</VerticalAlignment><TextFitMode>ShrinkToFit</TextFitMode>'+
'<UseFullFontHeight>True</UseFullFontHeight><Verticalized>False</Verticalized>'+
'<StyledText><Element><String></String>'+
'<Attributes><Font Family="Arial" Size="12" Bold="False" Italic="False" Underline="False" Strikeout="False" />'+
'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" /></Attributes></Element></StyledText></TextObject>'+
'<Bounds X="331" Y="690" Width="4622" Height="630" /></ObjectInfo>'+
'<ObjectInfo><TextObject><Name>DOCTOR</Name><ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
'<BackColor Alpha="0" Red="255" Green="255" Blue="255" /><LinkedObjectName></LinkedObjectName>'+
'<Rotation>Rotation0</Rotation><IsMirrored>False</IsMirrored><IsVariable>False</IsVariable>'+
'<HorizontalAlignment>Left</HorizontalAlignment><VerticalAlignment>Top</VerticalAlignment>'+
'<TextFitMode>ShrinkToFit</TextFitMode><UseFullFontHeight>True</UseFullFontHeight>'+
'<Verticalized>False</Verticalized><StyledText><Element><String></String>'+
'<Attributes><Font Family="Arial" Size="11" Bold="True" Italic="False" Underline="False" Strikeout="False" />'+
'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" /></Attributes></Element></StyledText></TextObject>'+
'<Bounds X="345" Y="1290" Width="3375" Height="203" /></ObjectInfo>'+
'<ObjectInfo><TextObject><Name>COLLECTION_DATE_TIME</Name><ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
'<BackColor Alpha="0" Red="255" Green="255" Blue="255" /><LinkedObjectName></LinkedObjectName>'+
'<Rotation>Rotation0</Rotation><IsMirrored>False</IsMirrored><IsVariable>False</IsVariable>'+
'<HorizontalAlignment>Left</HorizontalAlignment><VerticalAlignment>Top</VerticalAlignment>'+
'<TextFitMode>ShrinkToFit</TextFitMode><UseFullFontHeight>True</UseFullFontHeight>'+
'<Verticalized>False</Verticalized><StyledText><Element><String></String>'+
'<Attributes><Font Family="Arial" Size="9" Bold="False" Italic="False" Underline="False" Strikeout="False" />'+
'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" /></Attributes></Element></StyledText></TextObject>'+
'<Bounds X="1848" Y="495" Width="3105" Height="255" /></ObjectInfo></DieCutLabel>';
return xml;
}
function physicianLabel(PhysicianNumber,CPSO,name,address1,address2,city,province,postalcode,phone,FAX)
{
try {


        var labelXml = New_PhysicianLable()
        debugger;
        var label = dymo.label.framework.openLabelXml(labelXml);

		var address;
	    if(address=='undefined')
		address=address1+' '+address2;
            else
		address=address1;
            // set label text

            label.setObjectText("PHYSICIAN_NAME",  name+' '+PhysicianNumber  );
            label.setObjectText("ADDRESS", address + ',\n' + city + ', ' + province + ', ' + postalcode);
            label.setObjectText("PHONE",'PH: '+phone+' FAX: '+FAX);

            // select printer to print on
            // for simplicity sake just use the first LabelWriter printer
            var printers = dymo.label.framework.getPrinters();
            if (printers.length == 0)
                throw "No DYMO printers are installed. Install DYMO printers.";

            var printerName = "";
            for (var i = 0; i < printers.length; ++i) {
                var printer = printers[i];
                if (printer.printerType == "LabelWriterPrinter") {
                    printerName = printer.name;
                    break;
                }
            }

            if (printerName == "")
                throw "No LabelWriter printers found. Install LabelWriter printer";



            var num = window.prompt('How many Labels you wants to print?', '1');
            if (null == num)
                num = 0;
	    if(num!=0)
            for (var i = 0; i < num; i++)
	    {
            	label.print(printerName);
            }
	    num=0;

    } catch (e) {
        alert(e.message || e);
    }
}
function physicianLabel_OLD(PhysicianNumber,CPSO,name,address1,address2,city,province,postalcode,phone,FAX)
{
try {


        var labelXml = LoadPhysicianXML()

        var label = dymo.label.framework.openLabelXml(labelXml);

		var address;
	    if(address=='undefined')
		address=address1+' '+address2;
            else
		address=address1;
            // set label text

            label.setObjectText("Address",  name+' '+PhysicianNumber  );
            label.setObjectText("TEXT", address + ',\n' + city + ', ' + province + ', ' + postalcode);
            label.setObjectText("TEXT_1",'PH: '+phone+' FAX: '+FAX);

            // select printer to print on
            // for simplicity sake just use the first LabelWriter printer
            var printers = dymo.label.framework.getPrinters();
            if (printers.length == 0)
                throw "No DYMO printers are installed. Install DYMO printers.";

            var printerName = "";
            for (var i = 0; i < printers.length; ++i) {
                var printer = printers[i];
                if (printer.printerType == "LabelWriterPrinter") {
                    printerName = printer.name;
                    break;
                }
            }

            if (printerName == "")
                throw "No LabelWriter printers found. Install LabelWriter printer";



            var num = window.prompt('How many Labels you wants to print?', '1');
            if (null == num)
                num = 0;
	    if(num!=0)
            for (var i = 0; i < num; i++)
	    {
            	label.print(printerName);
            }
	    num=0;

    } catch (e) {
        alert(e.message || e);
    }
}

function LoadPhysicianXML() {
    var phxml = '<?xml version="1.0" encoding="utf-8"?><DieCutLabel Version="8.0" Units="twips"><PaperOrientation>Landscape</PaperOrientation>' +
	'<Id>Address</Id><PaperName>30252 Address</PaperName>' +
	'<DrawCommands><RoundRectangle X="0" Y="0" Width="1581" Height="5040" Rx="270" Ry="270" /></DrawCommands>' +
	'<ObjectInfo><AddressObject><Name>Address</Name><ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
    '<BackColor Alpha="0" Red="255" Green="255" Blue="255" /><LinkedObjectName></LinkedObjectName>' +
     '<Rotation>Rotation0</Rotation><IsMirrored>False</IsMirrored><IsVariable>True</IsVariable>' +
    '<HorizontalAlignment>Left</HorizontalAlignment><VerticalAlignment>Middle</VerticalAlignment>' +
    '<TextFitMode>ShrinkToFit</TextFitMode><UseFullFontHeight>True</UseFullFontHeight>' +
	'<Verticalized>False</Verticalized><StyledText>' +
    '<Element><String>277673 DR. A. MURLEETHARAN</String>' +
    '<Attributes><Font Family="Arial" Size="12" Bold="True" Italic="False" Underline="False" Strikeout="False" />' +
    '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" /></Attributes></Element></StyledText>' +
	'<ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
    '<BarcodePosition>Suppress</BarcodePosition><LineFonts>' +
    '<Font Family="Arial" Size="12" Bold="True" Italic="False" Underline="False" Strikeout="False" />' +
    '</LineFonts></AddressObject><Bounds X="332" Y="150" Width="4455" Height="270" />' +
	'</ObjectInfo><ObjectInfo>' +
    '<TextObject><Name>TEXT</Name>' +
	'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
	'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
    '<LinkedObjectName></LinkedObjectName>' +
	'<Rotation>Rotation0</Rotation><IsMirrored>False</IsMirrored><IsVariable>False</IsVariable>' +
    '<HorizontalAlignment>Left</HorizontalAlignment><VerticalAlignment>Top</VerticalAlignment>' +
    '<TextFitMode>ShrinkToFit</TextFitMode><UseFullFontHeight>True</UseFullFontHeight>' +
	'<Verticalized>False</Verticalized><StyledText><Element>' +
    '<String>2100 FINCH AVE WEST,#5,TORONTO, ON, M3N2Z9</String>' +
    '<Attributes><Font Family="Arial" Size="12" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
    '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
    '</Attributes></Element></StyledText></TextObject>' +
	'<Bounds X="375" Y="492.9" Width="4578" Height="585" />' +
	'</ObjectInfo><ObjectInfo><TextObject>' +
	'<Name>TEXT_1</Name><ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
	'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
    '<LinkedObjectName></LinkedObjectName>' +
	'<Rotation>Rotation0</Rotation><IsMirrored>False</IsMirrored><IsVariable>False</IsVariable>' +
	'<HorizontalAlignment>Left</HorizontalAlignment><VerticalAlignment>Top</VerticalAlignment>' +
	'<TextFitMode>ShrinkToFit</TextFitMode><UseFullFontHeight>True</UseFullFontHeight>' +
    '<Verticalized>False</Verticalized><StyledText><Element>' +
    '<String>PH:416-939-2964 FAX: 416-939-2964</String>' +
    '<Attributes><Font Family="Arial" Size="12" Bold="True" Italic="False" Underline="False" Strikeout="False" />' +
    '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
	'</Attributes></Element></StyledText></TextObject>' +
	'<Bounds X="331" Y="1133" Width="4622" Height="360" />' +
	'</ObjectInfo></DieCutLabel>';
return phxml;
}

function New_PhysicianLable()
{
  return '<?xml version="1.0" encoding="utf-8"?>' +
    '<DieCutLabel Version="8.0" Units="twips">' +
      '<PaperOrientation>Landscape</PaperOrientation>' +
      '<Id>Address</Id>' +
      '<PaperName>30252 Address</PaperName>' +
      '<DrawCommands>' +
        '<RoundRectangle X="0" Y="0" Width="1581" Height="5040" Rx="270" Ry="270" />' +
      '</DrawCommands>' +
      '<ObjectInfo>' +
        '<TextObject>' +
          '<Name>PHYSICIAN_NAME</Name>' +
          '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
          '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
          '<LinkedObjectName></LinkedObjectName>' +
          '<Rotation>Rotation0</Rotation>' +
          '<IsMirrored>False</IsMirrored>' +
          '<IsVariable>False</IsVariable>' +
          '<HorizontalAlignment>Left</HorizontalAlignment>' +
          '<VerticalAlignment>Top</VerticalAlignment>' +
          '<TextFitMode>ShrinkToFit</TextFitMode>' +
          '<UseFullFontHeight>True</UseFullFontHeight>' +
          '<Verticalized>False</Verticalized>' +
          '<StyledText>' +
            '<Element>' +
              '<String>PHYSICIAN NAME</String>' +
              '<Attributes>' +
                '<Font Family="Arial" Size="12" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
                '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
              '</Attributes>' +
            '</Element>' +
          '</StyledText>' +
        '</TextObject>' +
        '<Bounds X="331" Y="150" Width="4019" Height="300" />' +
      '</ObjectInfo>' +
      '<ObjectInfo>' +
        '<TextObject>' +
          '<Name>ADDRESS</Name>' +
          '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
          '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
          '<LinkedObjectName></LinkedObjectName>' +
          '<Rotation>Rotation0</Rotation>' +
          '<IsMirrored>False</IsMirrored>' +
          '<IsVariable>False</IsVariable>' +
          '<HorizontalAlignment>Left</HorizontalAlignment>' +
          '<VerticalAlignment>Top</VerticalAlignment>' +
          '<TextFitMode>ShrinkToFit</TextFitMode>' +
          '<UseFullFontHeight>True</UseFullFontHeight>' +
          '<Verticalized>False</Verticalized>' +
          '<StyledText>' +
            '<Element>' +
              '<String>ADDRESS</String>' +
              '<Attributes>' +
                '<Font Family="Arial" Size="12" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
                '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
              '</Attributes>' +
            '</Element>' +
          '</StyledText>' +
        '</TextObject>' +
        '<Bounds X="345" Y="567.900024414063" Width="4095" Height="495" />' +
      '</ObjectInfo>' +
      '<ObjectInfo>' +
        '<TextObject>' +
          '<Name>PHONE</Name>' +
          '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
          '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
          '<LinkedObjectName></LinkedObjectName>' +
          '<Rotation>Rotation0</Rotation>' +
          '<IsMirrored>False</IsMirrored>' +
          '<IsVariable>False</IsVariable>' +
          '<HorizontalAlignment>Left</HorizontalAlignment>' +
          '<VerticalAlignment>Top</VerticalAlignment>' +
          '<TextFitMode>ShrinkToFit</TextFitMode>' +
          '<UseFullFontHeight>True</UseFullFontHeight>' +
          '<Verticalized>False</Verticalized>' +
          '<StyledText>' +
            '<Element>' +
              '<String>PHONE</String>' +
              '<Attributes>' +
                '<Font Family="Arial" Size="12" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
                '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
              '</Attributes>' +
            '</Element>' +
          '</StyledText>' +
        '</TextObject>' +
        '<Bounds X="331" Y="1253" Width="4067" Height="240" />' +
      '</ObjectInfo>' +
    '</DieCutLabel>';

}
