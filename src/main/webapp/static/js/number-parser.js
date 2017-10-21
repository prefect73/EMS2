function parseNumber(strg) {

    var strg = strg || "";

    var decimal = '.';

    strg = strg.replace(/[^0-9$.,]/g, '');

    // console.log(strg);

    if (strg.indexOf(',') > strg.indexOf('.')) {
        decimal = ',';
    }

    // console.log("decimal", decimal);
    // console.log(strg);

    if ((strg.match(new RegExp("\\" + decimal, "g")) || []).length > 1) {
        decimal = "";
    }
    // console.log(strg.match(new
    // RegExp(decimal, "g")));

    // console.log("decimal", decimal);
    //
    // console.log(strg);

    if (decimal != "" && (strg.length - strg.indexOf(decimal) - 1 == 3)) {
        decimal = "";
    }

    // console.log("decimal", decimal);
    //
    // console.log(strg);

    strg = strg.replace(new RegExp("[^0-9$" + decimal + "]", "g"), "");

    // console.log("decimal", decimal);
    //
    // console.log(strg);

    strg = strg.replace(',', '.');

    // console.log("decimal", decimal);
    //
    // console.log(strg);

    return parseFloat(strg);

}



function parseToGermanNumber( numberString){
    var temp = parseNumber(numberString);
    if(isNaN(temp)){
        return "";
    }
    return temp.toLocaleString('de-DE', {minimumFractionDigits: 2})
};
