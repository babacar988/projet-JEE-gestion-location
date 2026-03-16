package com.gestionlocations.utils;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.concurrent.atomic.AtomicInteger;

public class ReferenceGenerator {
    private static final AtomicInteger counter = new AtomicInteger(1000);
    
    public static String generateContratRef() {
        String date = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMM"));
        return "CTR-" + date + "-" + counter.incrementAndGet();
    }
    
    public static String generatePaiementRef() {
        String date = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMM"));
        return "PAY-" + date + "-" + counter.incrementAndGet();
    }
}
