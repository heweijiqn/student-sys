package com.yizhi.common.domain;

public  final class  Const {
    /**
     * <B>构造方法</B><BR>
     */
    private Const() {
    }


    /** 通用字符集编码 */
    public static final String CHARSET_UTF8 = "UTF-8";

    /** 中文字符集编码 */
    public static final String CHARSET_CHINESE = "GBK";


    /** 日期格式 */
    public static final String FORMAT_DATE = "yyyy-MM-dd";

    /** 日期时间格式 */
    public static final String FORMAT_DATETIME = "yyyy-MM-dd HH:mm:ss";

    /** 时间戳格式 */
    public static final String FORMAT_TIMESTAMP = "yyyy-MM-dd HH:mm:ss.SSS";

    /** JSON成功标记 */
    public static final String JSON_SUCCESS = "success";

    /** JSON数据 */
    public static final String JSON_DATA = "data";

    /** JSON数据列表 */
    public static final String JSON_ROWS = "rows";

    /** JSON总数 */
    public static final String JSON_TOTAL = "total";

    /** JSON消息文本 */
    public static final String JSON_MESSAGE = "message";


    public static final String ERROR_RESPONSE = "error_response";
    public static final String PARKING_BASIC_DATA_SYNC_RESPONSE = "parking_basic_data_sync_response";
    /** 未付款 */
    public static final Integer NON_PAYMENT = 1;
    /** 已付款 */
    public static final Integer PAYMENT = 2;
    /** 未发货*/
    public static final Integer NON_SHIPMENTS = 3;
    /** 已发货 */
    public static final Integer SHIPMENTS = 4;
    /** 交易成功 */
    public static final Integer SUCCESSFUL = 5;
    /** 交易关闭 */
    public static final Integer CLOSE = 6;

    /**未评价*/
    public static final Integer EVALUATE_NO = 7;
    /**已评价*/
    public static final Integer EVALUATE_YES = 8;
    /**用户登录token*/
    public static final String TOKEN_LOGIN = "_lmt";
    /**cookie 购物车 key*/
    public static final String CART_KEY = "_xca";
    public static final String SESSION_USER_INFO = "userInfo";

}
