Return-Path: <rtc-linux+bncBDKZNNNLXAHBB46YZSYQKGQEID7WHWY@googlegroups.com>
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com. [210.118.77.11])
        by gmr-mx.google.com with ESMTPS id pe1si608949pac.2.2015.10.30.01.38.11
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 30 Oct 2015 01:38:11 -0700 (PDT)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NX000GMXYNJPY20@mailout1.w1.samsung.com> for
 rtc-linux@googlegroups.com; Fri, 30 Oct 2015 08:38:07 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH v5 4/4] drivers/rtc/rtc-s5m.c: add support for
 S2MPS15 RTC
To: Alim Akhtar <alim.akhtar@samsung.com>, lee.jones@linaro.org,
 broonie@kernel.org
References: <1446186334-16510-1-git-send-email-alim.akhtar@samsung.com>
 <1446186334-16510-5-git-send-email-alim.akhtar@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, rtc-linux@googlegroups.com,
 linux-kernel@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56332C69.1050608@samsung.com>
Date: Fri, 30 Oct 2015 17:38:01 +0900
MIME-version: 1.0
In-reply-to: <1446186334-16510-5-git-send-email-alim.akhtar@samsung.com>
Content-type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 30.10.2015 15:25, Alim Akhtar wrote:
> RTC found in s2mps15 is almost same as one found on s2mps13
> with few differences in RTC_UPDATE register fields, like:
> 1> Bit[4] and Bit[1] are reversed
>    - On s2mps13
>           WUDR -> bit[4], AUDR -> bit[1]
>    - On s2mps15
> 	  WUDR -> bit[1], AUDR -> bit[4]
> 2> In case of s2mps13, for alarm register, need to set both
>    WDUR and ADUR high, whereas for s2mps15 only set AUDR to high.
> 3> On s2mps15, WUDR, RUDR and AUDR functions should never be used
>    at the same time.
> 
> This patch add required changes to enable s2mps15 rtc timer.
> 
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  drivers/rtc/rtc-s5m.c           |   37 +++++++++++++++++++++++++++++++++----
>  include/linux/mfd/samsung/rtc.h |    2 ++
>  2 files changed, 35 insertions(+), 4 deletions(-)
> 

The usage of rtc_udr_mask is now a little bit messy and not-consistent
but this can be fixed in separate patch.

Current approach is the simplest way to add S2MPS15 and looks correct:

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

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
