package com.td.mace.controller;

import java.beans.PropertyEditorSupport;
import java.math.BigDecimal;
import java.text.NumberFormat;
import java.text.ParseException;
import java.util.Locale;

public class BigDecimalEditor extends PropertyEditorSupport {

    public void setAsText(String text) {
        if("".equals(text)){
            return;
        }

        NumberFormat formatter;
        if(text.contains(",") && text.contains(".") || text.contains(",")){
            formatter = NumberFormat.getNumberInstance(Locale.GERMAN);
        }else if(text.contains(".")) {
            formatter = NumberFormat.getNumberInstance(Locale.ENGLISH);
        }else{
            formatter = NumberFormat.getNumberInstance(Locale.ENGLISH);
        }

        try {
            Number number = formatter.parse(text);
            BigDecimal bigDecimal = BigDecimal.valueOf(number.doubleValue());
            setValue(bigDecimal);
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }
}