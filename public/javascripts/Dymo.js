function printPatientLabel(PatientName, healthNumber, expiry, dob, sex, address, city, province, postalcode, phone, mobile, physician, visiteddate) {
    try {
//        $.post("patients/patieninfo", function(data) {
            var data = '<?xml version="1.0" encoding="utf-8"?>' +
'<DieCutLabel Version="8.0" Units="twips">' +
'  <PaperOrientation>Landscape</PaperOrientation>' +
'  <Id>LargeAddress</Id>' +
'  <PaperName>30321 Large Address</PaperName>' +
'  <DrawCommands>' +
'    <RoundRectangle X="0" Y="0" Width="2025" Height="5020" Rx="270" Ry="270" />' +
'  </DrawCommands>' +
' <ObjectInfo>' +
'    <AddressObject>' +
'      <Name>Text</Name>' +
'      <ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
'      <BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
'      <LinkedObjectName></LinkedObjectName>' +
'      <Rotation>Rotation0</Rotation>' +
'      <IsMirrored>False</IsMirrored>' +
'     <IsVariable>True</IsVariable>' +
'      <HorizontalAlignment>Left</HorizontalAlignment>' +
'      <VerticalAlignment>Middle</VerticalAlignment>' +
'      <TextFitMode>None</TextFitMode>' +
'      <UseFullFontHeight>False</UseFullFontHeight>' +
'      <Verticalized>False</Verticalized>' +
'      <StyledText />' +
'      <ShowBarcodeFor9DigitZipOnly>True</ShowBarcodeFor9DigitZipOnly>' +
'      <BarcodePosition>Suppress</BarcodePosition>' +
'     <LineFonts>' +
'        <Font Family="Arial" Size="9" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
'        <Font Family="Arial" Size="9" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
'        <Font Family="Arial" Size="9" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
'        <Font Family="Arial" Size="9" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
'      </LineFonts>' +
'    </AddressObject>' +
'   <Bounds X="322" Y="58" Width="4613" Height="1882" />' +
'  </ObjectInfo>' +
'</DieCutLabel>';
            var labelXml = (new XMLSerializer()).serializeToString(data);
            // this is not working only for patient infor
            //var gender = sex == 'M' ? 'MALE' : sex == 'F' ? 'FEMALE' : '';
            //var text = healthNumber + ' ' + expiry + ' ' + gender + '\n' + PatientName + ' DOB:' + dob + '\n' + address1 + '\n' + address2 + '\n' + homephone;
            var label = dymo.label.framework.openLabelXml(data);
            var gender = sex == 'M' ? 'MALE' : sex == 'F' ? 'FEMALE' : '';
            // set label text
            var OtherAdd = dob + ' ' + gender + '\n' + address1 + '\n' + address2 + '\n' + homephone
            label.setObjectText("Text", '\n' + PatientName + '\n' + healthNumber + ' Exp:' + expiry + '\n' + OtherAdd);


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
            alert(num);
            if (null == num)
                num = 1;
            for (var i = 0; i < num; i++)
                alert(i);
            //label.print(printerName);
   //     });
    } catch (e) {
        alert(e.message || e);
    }
}

function printVisitLabel(visit, doctor) {
    try {
        $.post("/Patient/VisitLabel", function(data) {
            var labelXml = (new XMLSerializer()).serializeToString(data);
            var label = dymo.label.framework.openLabelXml(labelXml);
            // set label text

            var dobNsex = visit.DOB + ' ' + visit.SEX + '\n';
            var OtherAdd = visit.ADD1 + '\n' + visit.ADD2 + '\n' + visit.Phone;

            label.setObjectText("ADDRESS", visit.FullName + '\n' + dobNsex + '\n' + visit.OHIP + '\n' + OtherAdd + '\n' + doctor + '\n' + visit.ServiceDate);
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
                num = 1;
            for (var i = 0; i < num; i++)
                label.print(printerName);
        });
    } catch (e) { alert(e.message || e); }
}

function printHelpDeskToken(text) {
    alert(text);
    try {
        $.post("/HelpDesk/TokenLabel", function(data) {
            var labelXml = (new XMLSerializer()).serializeToString(data);
            printLabel(labelXml, text);

        });
    }
    catch (e) {
        alert(e.message || e);
    }
}
function printLabel(labelXml, text) {
    var label = dymo.label.framework.openLabelXml(labelXml);

    // set label text
    label.setObjectText("Text", text);

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
    label.print(printerName);
}


