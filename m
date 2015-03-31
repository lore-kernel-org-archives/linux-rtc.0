Return-Path: <rtc-linux+bncBDS7HNEFSALRBR6V46UAKGQEJZC4T5I@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id c8si905822wiw.1.2015.03.30.17.31.02
        for <rtc-linux@googlegroups.com>;
        Mon, 30 Mar 2015 17:31:02 -0700 (PDT)
Date: Tue, 31 Mar 2015 02:31:01 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Kukjin Kim <kgene@kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, rtc-linux@googlegroups.com,
	Kyungmin Park <kyungmin.park@samsung.com>
Subject: [rtc-linux] Re: [PATCH 2/2] ARM: dts: s3c-rtc: Use s3c6410-rtc
 instead of exynos3250-rtc
Message-ID: <20150331003101.GG3849@piout.net>
References: <1427728773-29065-1-git-send-email-k.kozlowski@samsung.com>
 <1427728773-29065-3-git-send-email-k.kozlowski@samsung.com>
 <5519DE76.4080803@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <5519DE76.4080803@samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 31/03/2015 at 08:38:30 +0900, Chanwoo Choi wrote :
> > diff --git a/Documentation/devicetree/bindings/rtc/s3c-rtc.txt b/Documentation/devicetree/bindings/rtc/s3c-rtc.txt
> > index ab757b84daa7..ac2fcd6ff4b8 100644
> > --- a/Documentation/devicetree/bindings/rtc/s3c-rtc.txt
> > +++ b/Documentation/devicetree/bindings/rtc/s3c-rtc.txt
> > @@ -6,7 +6,8 @@ Required properties:
> >      * "samsung,s3c2416-rtc" - for controllers compatible with s3c2416 rtc.
> >      * "samsung,s3c2443-rtc" - for controllers compatible with s3c2443 rtc.
> >      * "samsung,s3c6410-rtc" - for controllers compatible with s3c6410 rtc.
> > -    * "samsung,exynos3250-rtc" - for controllers compatible with exynos3250 rtc.
> > +    * "samsung,exynos3250-rtc" - (deprecated) for controllers compatible with
> > +                                 exynos3250 rtc (use "samsung,s3c6410-rtc").
> >  - reg: physical base address of the controller and length of memory mapped
> >    region.
> >  - interrupts: Two interrupt numbers to the cpu should be specified. First
> > diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
> > index e3bfb11c6ef8..8d58b550e925 100644
> > --- a/arch/arm/boot/dts/exynos3250.dtsi
> > +++ b/arch/arm/boot/dts/exynos3250.dtsi
> > @@ -189,7 +189,7 @@
> >  		};
> >  
> >  		rtc: rtc@10070000 {
> > -			compatible = "samsung,exynos3250-rtc";
> > +			compatible = "samsung,s3c6410-rtc";
> >  			reg = <0x10070000 0x100>;
> >  			interrupts = <0 73 0>, <0 74 0>;
> >  			interrupt-parent = <&pmu_system_controller>;
> > diff --git a/arch/arm/boot/dts/exynos4415.dtsi b/arch/arm/boot/dts/exynos4415.dtsi
> > index 5caea996e090..186cb8465683 100644
> > --- a/arch/arm/boot/dts/exynos4415.dtsi
> > +++ b/arch/arm/boot/dts/exynos4415.dtsi
> > @@ -177,7 +177,7 @@
> >  		};
> >  
> >  		rtc: rtc@10070000 {
> > -			compatible = "samsung,exynos3250-rtc";
> > +			compatible = "samsung,s3c6410-rtc";
> >  			reg = <0x10070000 0x100>;
> >  			interrupts = <0 73 0>, <0 74 0>;
> >  			status = "disabled";
> > 
> 
> Looks good to me.
> 
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> 

Are you absolutely sure that the exynos3250 IP is the same as the
s3c6410 (I don't know much about the exynos family). The concern being
that if at one point you have an errata on one or ther other, you will
have to break the DT ABI by undoing this change.

Note that I'm fine with it, I'm just asking.

Regards,

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
