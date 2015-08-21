Return-Path: <rtc-linux+bncBDS7HNEFSALRBFVL32XAKGQEVCF5KZA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id ek3si177773wid.1.2015.08.21.14.18.14
        for <rtc-linux@googlegroups.com>;
        Fri, 21 Aug 2015 14:18:14 -0700 (PDT)
Date: Fri, 21 Aug 2015 23:18:12 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Keerthy <j-keerthy@ti.com>, tony@atomide.com
Cc: bcousson@baylibre.com, johan@kernel.org, linux-omap@vger.kernel.org,
	rtc-linux@googlegroups.com, grygorii.strashko@ti.com
Subject: [rtc-linux] Re: [PATCH v5 0/3] ARM: AM437X: Add rtc clock handling
Message-ID: <20150821211812.GI3769@piout.net>
References: <1439890876-19024-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1439890876-19024-1-git-send-email-j-keerthy@ti.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Tony,

On 18/08/2015 at 15:11:13 +0530, Keerthy wrote :
> The series is applicable for all am437x series of processors.
> It adds clock handling support. Boot tested on am437x-gp-evm.
> 
> Keerthy (3):
>   ARM: dts: AM437x: Add the internal and external clock nodes for rtc
>   rtc: omap: Add internal clock enabling support
>   rtc: omap: Add external clock enabling support
> 

I'm wondering how you want to get those patches merged. I can let you
take 2 and 3 through arm-soc but you will miss 4.3. Or I can take 2 and
3 for 4.3 but the documentation will be missing.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
