package com.td.mace.controller;

import com.td.mace.model.Project;
import com.td.mace.model.WorkPackage;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;

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

    public static BigDecimal calculatePaymentPercentage(Project project){
        BigDecimal paymentPercentage = BigDecimal.ZERO;
        if(project.getWorkPackages() != null && project.getWorkPackages().size() > 0){

            List<WorkPackage> workPackageList = project.getWorkPackages();
            for (WorkPackage workPackage: workPackageList){
                BigDecimal wpPaymentPercentage = calculatePaymentPercentage(workPackage);
                paymentPercentage = paymentPercentage.add(wpPaymentPercentage);
            }

            return paymentPercentage.divide(new BigDecimal(workPackageList.size()), 2, RoundingMode.HALF_UP);

        }

        return paymentPercentage;
    }

}
