Return-Path: <rtc-linux+bncBCO3XAUMTIFRBYVYYS4AKGQEU7HWQ6Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from comal.ext.ti.com (comal.ext.ti.com. [198.47.26.152])
        by gmr-mx.google.com with ESMTPS id bc4si2157164igb.3.2016.04.15.09.52.50
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 15 Apr 2016 09:52:50 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH] rtc: omap: Support ext_wakeup configuration
To: Grygorii Strashko <grygorii.strashko@ti.com>,
        Marcin Niestroj
	<m.niestroj@grinn-global.com>,
        Tony Lindgren <tony@atomide.com>
References: <1459785403-1725-1-git-send-email-m.niestroj@grinn-global.com>
 <20160404224046.GA17042@atomide.com> <57078A89.3080809@ti.com>
 <20160408151408.GS16484@atomide.com> <5707E764.7050204@ti.com>
 <570D2F79.9040202@grinn-global.com> <57111AF4.6070505@ti.com>
CC: <rtc-linux@googlegroups.com>, <devicetree@vger.kernel.org>,
        Rob Herring
	<robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Alessandro Zummo
	<a.zummo@towertech.it>,
        Alexandre Belloni
	<alexandre.belloni@free-electrons.com>,
        Keerthy <j-keerthy@ti.com>, <linux-omap@vger.kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>
From: Nishanth Menon <nm@ti.com>
Message-ID: <57111C5A.7070606@ti.com>
Date: Fri, 15 Apr 2016 11:52:42 -0500
MIME-Version: 1.0
In-Reply-To: <57111AF4.6070505@ti.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 04/15/2016 11:46 AM, Grygorii Strashko wrote:
[...]
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 13ac882..9580c82 100644
> --- a/arch/arm/boot/dts/dra7.dtsi

I see this is an example of what could be done on am335x - but lets
not do this on dra7/am57xx please?


-- 
Regards,
Nishanth Menon

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
