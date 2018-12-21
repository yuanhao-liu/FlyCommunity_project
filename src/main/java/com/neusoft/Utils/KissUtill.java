package com.neusoft.Utils;

public class KissUtill {
    public static int getKissNum(int qiandaoDay) {
        int qiandaoKiss = 5;
        if (qiandaoDay >= 5) {
            qiandaoKiss = 10;
            if (qiandaoDay >= 15) {
                qiandaoKiss = 15;
                if (qiandaoDay >= 30) {
                    qiandaoKiss = 20;
                    if (qiandaoDay >= 100) {
                        qiandaoKiss = 30;
                        if (qiandaoDay >= 365) {
                            qiandaoKiss = 50;
                        }
                    }
                }
            }
        }
        return qiandaoKiss;
    }
}
