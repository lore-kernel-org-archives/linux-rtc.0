Return-Path: <rtc-linux+bncBDIZTUWNWICRBU7V6LBQKGQE7U5UWVI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from userp1040.oracle.com (userp1040.oracle.com. [156.151.31.81])
        by gmr-mx.google.com with ESMTPS id 23si3089002pfw.4.2017.01.16.04.21.39
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jan 2017 04:21:39 -0800 (PST)
Date: Mon, 16 Jan 2017 15:21:28 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: amelie.delaunay@st.com
Cc: rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [bug report] rtc: add STM32 RTC driver
Message-ID: <20170116122128.GC4104@mwanda>
References: <20170116121346.GA28569@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170116121346.GA28569@mwanda>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Oh.  That still won't fix this:

drivers/rtc/rtc-stm32.c
   519          /*
   520           * Can't find a 1Hz, so give priority to RTC power consumption
   521           * by choosing the higher possible value for prediv_a
   522           */
   523          if ((pred_s > pred_s_max) || (pred_a > pred_a_max)) {
   524                  pred_a = pred_a_max;
   525                  pred_s = (rate / (pred_a + 1)) - 1;
   526  
   527                  dev_warn(&pdev->dev, "ck_rtc is %s\n",
   528                           (rate - ((pred_a + 1) * (pred_s + 1)) < 0) ?

This is type promoted to unsigned int < 0.

   529                           "fast" : "slow");
   530          }

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
