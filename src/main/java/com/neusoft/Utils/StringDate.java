package com.neusoft.Utils;

import java.util.Date;
/**
 * Created by ttc on 17-11-23.
 */
public class StringDate {
    //参数date，传入帖子的创建时间
    //返回值 （一分钟前，二分钟前，一小时前，一天前，20170506）
    public static String getStringDate(Date date)
    {
        String strTemp = "";
        long timestampThat = date.getTime();//时间戳--- timestamp  当前时间变量距离1970年1月1日0时0分0秒经过的毫秒数
        //当前系统时间
        Date now = new Date();
        long timestampNow = now.getTime();
        long diffSec = (timestampNow - timestampThat)/1000;//相差的秒数
        if(diffSec < 60)
        {
            strTemp = "刚刚";
        }
        else
        {
            long diffMin = diffSec / 60;
            if(diffMin < 60)
            {
                strTemp = diffMin + "分钟前";
            }
            else //大于60分钟（1小时）
            {
                long diffHour = diffMin / 60;
                if(diffHour < 24)
                {
                    strTemp = diffHour + "小时前";
                }
                else//大于1天
                {
                    long diffDay = diffHour / 24;
                    if(diffDay < 7)
                    {
                        strTemp = diffDay + "天前";
                    }
                    else
                    {
                        String dateTmp = date.toLocaleString();
                        String[] array = dateTmp.split(" ");
                        strTemp = array[0];
                    }
                }
            }
        }
        return strTemp;
    }
}
