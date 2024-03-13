package com.model2.mvc.common;

public enum TransactionStatus {
	SELLING("0", "판매중"),
    PURCHASED("1", "구매완료"),
    SHIPPING("2", "배송중"),
    DELIVERED("3", "배송완료");

    private final String code;
    private final String status;


    TransactionStatus(String code, String status) {
        this.code = code;
        this.status = status;
    }

    public String getCode() {
        return code;
    }
    
    public String getStatus() {
        return status;
    }

    public static String getStatusByCode(String code) {
        for (TransactionStatus status : TransactionStatus.values()) {
            if (status.getCode().equals(code)) {
                return status.getStatus();
            }
        }
        throw new IllegalArgumentException("잘못된 코드: " + code);
    }
}