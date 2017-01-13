Return-Path: <rtc-linux+bncBC2IT2GSZUDRBF5F4LBQKGQEEUPTOIQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com. [91.207.212.93])
        by gmr-mx.google.com with ESMTPS id d207si82091wmd.1.2017.01.13.00.40.55
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jan 2017 00:40:55 -0800 (PST)
From: Amelie DELAUNAY <amelie.delaunay@st.com>
To: Julia Lawall <julia.lawall@lip6.fr>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        "rtc-linux@googlegroups.com"
	<rtc-linux@googlegroups.com>,
        "kbuild-all@01.org" <kbuild-all@01.org>
Subject: [rtc-linux] RE: [abelloni:rtc-next 12/12] drivers/rtc/rtc-stm32.c:514:27-33:
 WARNING: Unsigned expression compared with zero: pred_a >= 0
Date: Fri, 13 Jan 2017 08:40:50 +0000
Message-ID: <3086516659614a709535f4e8f0d090a9@SFHDAG3NODE2.st.com>
References: <alpine.DEB.2.20.1701130641180.2080@hadrien>
In-Reply-To: <alpine.DEB.2.20.1701130641180.2080@hadrien>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Julia,

Thanks for the review, I prepare a fix for this warning.

Amelie

> -----Original Message-----
> From: Julia Lawall [mailto:julia.lawall@lip6.fr]
> Sent: vendredi 13 janvier 2017 06:43
> To: Amelie DELAUNAY <amelie.delaunay@st.com>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>; Mathieu
> Poirier <mathieu.poirier@linaro.org>; rtc-linux@googlegroups.com; kbuild-
> all@01.org
> Subject: [abelloni:rtc-next 12/12] drivers/rtc/rtc-stm32.c:514:27-33: WARNING:
> Unsigned expression compared with zero: pred_a >= 0
> 
> pred_a is unsigned, and thus the test on line 514 that it is >= 0 will always be
> true.
> 
> julia
> 
> 
> 
> ---------- Forwarded message ----------
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
> head:   4e64350f42e2ce153bdffd9fe1741333f5a41e57
> commit: 4e64350f42e2ce153bdffd9fe1741333f5a41e57 [12/12] rtc: add STM32
> RTC driver
> :::::: branch date: 77 minutes ago
> :::::: commit date: 77 minutes ago
> 
> >> drivers/rtc/rtc-stm32.c:514:27-33: WARNING: Unsigned expression
> >> compared with zero: pred_a >= 0
> 
> git remote add abelloni
> https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git
> git remote update abelloni
> git checkout 4e64350f42e2ce153bdffd9fe1741333f5a41e57
> vim +514 drivers/rtc/rtc-stm32.c
> 
> 4e64350f Amelie Delaunay 2017-01-11  498  MODULE_DEVICE_TABLE(of,
> stm32_rtc_of_match); 4e64350f Amelie Delaunay 2017-01-11  499  #endif
> 4e64350f Amelie Delaunay 2017-01-11  500 4e64350f Amelie Delaunay 2017-
> 01-11  501  static int stm32_rtc_init(struct platform_device *pdev,
> 4e64350f Amelie Delaunay 2017-01-11  502  			  struct
> stm32_rtc *rtc)
> 4e64350f Amelie Delaunay 2017-01-11  503  {
> 4e64350f Amelie Delaunay 2017-01-11  504  	unsigned int prer, pred_a,
> pred_s, pred_a_max, pred_s_max, cr;
> 4e64350f Amelie Delaunay 2017-01-11  505  	unsigned int rate;
> 4e64350f Amelie Delaunay 2017-01-11  506  	int ret = 0;
> 4e64350f Amelie Delaunay 2017-01-11  507
> 4e64350f Amelie Delaunay 2017-01-11  508  	rate = clk_get_rate(rtc-
> >ck_rtc);
> 4e64350f Amelie Delaunay 2017-01-11  509
> 4e64350f Amelie Delaunay 2017-01-11  510  	/* Find prediv_a and prediv_s
> to obtain the 1Hz calendar clock */
> 4e64350f Amelie Delaunay 2017-01-11  511  	pred_a_max =
> STM32_RTC_PRER_PRED_A >> STM32_RTC_PRER_PRED_A_SHIFT;
> 4e64350f Amelie Delaunay 2017-01-11  512  	pred_s_max =
> STM32_RTC_PRER_PRED_S >> STM32_RTC_PRER_PRED_S_SHIFT;
> 4e64350f Amelie Delaunay 2017-01-11  513
> 4e64350f Amelie Delaunay 2017-01-11 @514  	for (pred_a = pred_a_max;
> pred_a >= 0; pred_a--) {
> 4e64350f Amelie Delaunay 2017-01-11  515  		pred_s = (rate /
> (pred_a + 1)) - 1;
> 4e64350f Amelie Delaunay 2017-01-11  516
> 4e64350f Amelie Delaunay 2017-01-11  517  		if (((pred_s + 1) *
> (pred_a + 1)) == rate)
> 4e64350f Amelie Delaunay 2017-01-11  518  			break;
> 4e64350f Amelie Delaunay 2017-01-11  519  	}
> 4e64350f Amelie Delaunay 2017-01-11  520
> 4e64350f Amelie Delaunay 2017-01-11  521  	/*
> 4e64350f Amelie Delaunay 2017-01-11  522  	 * Can't find a 1Hz, so give
> priority to RTC power consumption
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
