Return-Path: <rtc-linux+bncBCQPVKWLVAIRBOPBU6XAKGQEPDUNCXA@googlegroups.com>
Received: from muru.com (muru.com. [72.249.23.125])
        by gmr-mx.google.com with ESMTP id rs3si1091280igb.2.2015.08.11.05.55.20
        for <rtc-linux@googlegroups.com>;
        Tue, 11 Aug 2015 05:55:20 -0700 (PDT)
Date: Tue, 11 Aug 2015 05:55:15 -0700
From: Tony Lindgren <tony@atomide.com>
To: Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org, pawel.moll@arm.com, galak@codeaurora.org,
	paul@pwsan.com, alexandre.belloni@free-electrons.com,
	akpm@linux-foundation.org, johan@kernel.org,
	grygorii.strashko@ti.com, rtc-linux@googlegroups.com,
	bcousson@baylibre.com, nm@ti.com, devicetree@vger.kernel.org,
	t-kristo@ti.com
Subject: [rtc-linux] Re: [PATCH v2 3/6] ARM: AM43xx: Introduce a separate
 soc_is function for am438x series of SoCs
Message-ID: <20150811125515.GN4215@atomide.com>
References: <1439198906-31189-1-git-send-email-j-keerthy@ti.com>
 <1439198906-31189-4-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1439198906-31189-4-git-send-email-j-keerthy@ti.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

* Keerthy <j-keerthy@ti.com> [150810 02:31]:
> @@ -371,8 +372,10 @@ IS_OMAP_TYPE(3430, 0x3430)
>  #ifdef	CONFIG_SOC_AM43XX
>  # undef soc_is_am43xx
>  # undef soc_is_am437x
> -# define soc_is_am43xx()		is_am43xx()
> -# define soc_is_am437x()		is_am437x()
> +# undef soc_is_am438x
> +# define soc_is_am43xx()		of_machine_is_compatible("ti,am43")
> +# define soc_is_am437x()		of_machine_is_compatible("ti,am4372")
> +# define soc_is_am438x()		of_machine_is_compatible("ti,am438x")
>  #endif

Hmm didn't I already comment on this change? I don't want to do it
for one SoC. Please add the SoC detection the old way for am43xx,
then do another series that changes all the DT only SoCs to use
of_machine_is_compatible() after it's been properly tested so now
regressions are caused for the early init code.

Regards,

Tony

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
