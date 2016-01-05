Return-Path: <rtc-linux+bncBDIZTUWNWICRBMVHV22AKGQELZUKQYI@googlegroups.com>
Received: from userp1040.oracle.com (userp1040.oracle.com. [156.151.31.81])
        by gmr-mx.google.com with ESMTPS id ui7si4212474pab.0.2016.01.05.01.58.09
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2016 01:58:10 -0800 (PST)
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id u059w5wr006350
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <rtc-linux@googlegroups.com>; Tue, 5 Jan 2016 09:58:06 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userv0022.oracle.com (8.13.8/8.13.8) with ESMTP id u059w5BX002705
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <rtc-linux@googlegroups.com>; Tue, 5 Jan 2016 09:58:05 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by aserv0122.oracle.com (8.13.8/8.13.8) with ESMTP id u059w5MW002959
	for <rtc-linux@googlegroups.com>; Tue, 5 Jan 2016 09:58:05 GMT
Date: Tue, 5 Jan 2016 12:57:59 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: sasha.levin@oracle.com
Cc: rtc-linux@googlegroups.com
Subject: [rtc-linux] re: rtc: fix overflow and incorrect calculation in rtc_time64_to_tm
Message-ID: <20160105095758.GG23619@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hello Sasha Levin,

The patch cab572b82c4b: "rtc: fix overflow and incorrect calculation
in rtc_time64_to_tm" from Dec 3, 2015, leads to the following static
checker warning:

	drivers/rtc/rtc-lib.c:72 rtc_time64_to_tm()
	warn: unsigned 'days' is never less than zero.

drivers/rtc/rtc-lib.c
    49  /*
    50   * rtc_time_to_tm64 - Converts time64_t to rtc_time.
    51   * Convert seconds since 01-01-1970 00:00:00 to Gregorian date.
    52   */
    53  void rtc_time64_to_tm(time64_t time, struct rtc_time *tm)
    54  {
    55          unsigned int month, year;
    56          int secs;
    57          unsigned long days;
                ^^^^^^^^^^^^^^^^^^^
    58  
    59          /*
    60           * time must be positive
    61           * This will fail for 32bit platforms on January 21st 11761191
    62           */
    63          days = div_s64_rem(time, 86400, &secs);
    64  
    65          /* day of the week, 1970-01-01 was a Thursday */
    66          tm->tm_wday = (days + 4) % 7;
    67  
    68          year = 1970 + days / 365;
    69          days -= (year - 1970) * 365
    70                  + LEAPS_THRU_END_OF(year - 1)
    71                  - LEAPS_THRU_END_OF(1970 - 1);
    72          if (days < 0) {
                   ^^^^^^^^^
    73                  year -= 1;
    74                  days += 365 + is_leap_year(year);
    75          }

regards,
dan carpenter

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
