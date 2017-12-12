package com.td.mace.controller;

import com.td.mace.model.WorkPackage;

import java.math.BigDecimal;
import java.math.RoundingMode;

public class PaymentUtils {
    public static BigDecimal calculatePaymentPercentage(WorkPackage workPackage) {
        // if offeredCost/calculatedCost is equal to null or zero -> return 0
        if ((workPackage.getOfferedCost() == null || workPackage.getOfferedCost().compareTo(BigDecimal.ZERO) == 0) ||
                (workPackage.getCalculatedCost() == null || workPackage.getCalculatedCost().compareTo(BigDecimal.ZERO) == 0)) {
            System.err.println(String.format("Cannot calculate the payment percentage for %s", workPackage.getWorkPackageName()));
            return BigDecimal.ZERO;
        }

        return workPackage.getCalculatedCost().multiply(new BigDecimal(100)).divide(workPackage.getOfferedCost(), 2, RoundingMode.HALF_UP);

    }
}
