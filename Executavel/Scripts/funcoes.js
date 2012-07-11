function vercpf(cpf) {
    //var c = cpf.replace(/\W/g, "");
    var c = cpf;
    if (c.length != 11 || c == "00000000000" || c == "11111111111" || c == "22222222222" || c == "33333333333" || c == "44444444444" || c == "55555555555" || c == "66666666666" || c == "77777777777" || c == "88888888888" || c == "99999999999")
        return false;
    add = 0;
    for (i = 0; i < 9; i++)
        add += parseInt(c.charAt(i)) * (10 - i);
    rev = 11 - (add % 11);
    if (rev == 10 || rev == 11)
        rev = 0;
    if (rev != parseInt(c.charAt(9)))
        return false;
    add = 0;
    for (i = 0; i < 10; i++)
        add += parseInt(c.charAt(i)) * (11 - i);
    rev = 11 - (add % 11);
    if (rev == 10 || rev == 11)
        rev = 0;
    if (rev != parseInt(c.charAt(10)))
        return false;
    return true;
}

/*
* Ext.form.Field field
* Ext.EventObject event
* Numeric key
* String mask
* 
* valid masks can be:
* phone ->  "(##) ####-####"
* cep    ->  "##.###-###"
* cpf     ->  "###.###.###-##"
* car     ->  "AAA-####"
* others -> "####-####"
* 
* 
* Exemplo de como utilizar esta função:
* {
*    xtype: "datefield",
*    enableKeyEvents: true,
*    listeners: {
*       keypress: function(field, evt){
*          return mask(field.el.dom, evt, evt.getKey(), "##/##/####");
*       }
*    }
* }
*/
var mascara = function (field, evt) {
    return mask(field.el.dom, evt, evt.getKey(), field.mask);
}


function mask(field, evt, key, mask) {
    var LetrasU = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    var LetrasL = 'abcdefghijklmnopqrstuvwxyz';
    var Letras = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
    var Numeros = '0123456789';
    var Fixos = '().-:/ ';
    var Charset = " !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_/`abcdefghijklmnopqrstuvwxyz{|}~";
    var value = field.value;
    if (evt) {
        var tecla = Charset.substr(key - 32, 1);
        if (key < 32 || evt.isNavKeyPress() || evt.isSpecialKey() || key == evt.BACKSPACE || key == evt.DELETE) {
            return true;
        }
        var tamanho = value.length;
        if (tamanho >= mask.length) {
            field.value = value;
            evt.stopEvent();
            return false;
        }
        var pos = mask.substr(tamanho, 1);
        while (Fixos.indexOf(pos) != -1) {
            value += pos;
            tamanho = value.length;
            if (tamanho >= mask.length) {
                evt.stopEvent();
                return false;
            }
            pos = mask.substr(tamanho, 1);
        }
        switch (pos) {
            case '#': if (Numeros.indexOf(tecla) == -1) { evt.stopEvent(); return false; } break;
            case 'A': if (LetrasU.indexOf(tecla) == -1) { evt.stopEvent(); return false; } break;
            case 'a': if (LetrasL.indexOf(tecla) == -1) { evt.stopEvent(); return false; } break;
            case 'Z': if (Letras.indexOf(tecla) == -1) { evt.stopEvent(); return false; } break;
            case '*': /*return true;*/field.value = value + tecla; break;
            default: /*return false;*/field.value = value; break;
        }
    }
    field.value = value + tecla;
    evt.stopEvent();
    return false;
}
