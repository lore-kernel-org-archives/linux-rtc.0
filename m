Return-Path: <rtc-linux+bncBDIZTUWNWICRBA7S6LBQKGQEULLXLZI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from userp1040.oracle.com (userp1040.oracle.com. [156.151.31.81])
        by gmr-mx.google.com with ESMTPS id h130si58334pfe.1.2017.01.16.04.13.54
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jan 2017 04:13:55 -0800 (PST)
Date: Mon, 16 Jan 2017 15:13:47 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: amelie.delaunay@st.com
Cc: rtc-linux@googlegroups.com
Subject: [rtc-linux] [bug report] rtc: add STM32 RTC driver
Message-ID: <20170116121346.GA28569@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hello Amelie Delaunay,

The patch 4e64350f42e2: "rtc: add STM32 RTC driver" from Jan 11,
2017, leads to the following static checker warning:

	drivers/rtc/rtc-stm32.c:514 stm32_rtc_init()
	warn: always true condition '(pred_a >= 0) => (0-u32max >= 0)'

drivers/rtc/rtc-stm32.c
   499  static int stm32_rtc_init(struct platform_device *pdev,
   500                            struct stm32_rtc *rtc)
   501  {
   502          unsigned int prer, pred_a, pred_s, pred_a_max, pred_s_max, cr;
   503          unsigned int rate;
   504          int ret = 0;
   505  
   506          rate = clk_get_rate(rtc->ck_rtc);
   507  
   508          /* Find prediv_a and prediv_s to obtain the 1Hz calendar clock */
   509          pred_a_max = STM32_RTC_PRER_PRED_A >> STM32_RTC_PRER_PRED_A_SHIFT;
   510          pred_s_max = STM32_RTC_PRER_PRED_S >> STM32_RTC_PRER_PRED_S_SHIFT;
   511  
   512          for (pred_a = pred_a_max; pred_a >= 0; pred_a--) {
                                          ^^^^^^^^^^^
We should probably make pred_a, pred_s, pred_a_max and pred_s_max
signed.

   513                  pred_s = (rate / (pred_a + 1)) - 1;
   514  
   515                  if (((pred_s + 1) * (pred_a + 1)) == rate)
   516                          break;
   517          }
   518  

regards,
dan carpenter

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
