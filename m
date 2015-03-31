Return-Path: <rtc-linux+bncBDV4TNWQ4ADBBEEJ5GUAKGQEZVCPZXI@googlegroups.com>
Received: from mailout2.samsung.com (mailout2.samsung.com. [203.254.224.25])
        by gmr-mx.google.com with ESMTPS id gu4si1398536pac.1.2015.03.30.23.54.07
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 30 Mar 2015 23:54:08 -0700 (PDT)
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NM200FZLDU5KBC0@mailout2.samsung.com> for
 rtc-linux@googlegroups.com; Tue, 31 Mar 2015 15:54:05 +0900 (KST)
From: Kukjin Kim <kgene@kernel.org>
Sender: rtc-linux@googlegroups.com
To: 'Javier Martinez Canillas' <javier@dowhile0.org>,
 'Chanwoo Choi' <cw00.choi@samsung.com>
Cc: 'Krzysztof Kozlowski' <k.kozlowski@samsung.com>,
 'Kukjin Kim' <kgene@kernel.org>, 'Alessandro Zummo' <a.zummo@towertech.it>,
 devicetree@vger.kernel.org, 'Linux Kernel' <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 rtc-linux@googlegroups.com,
 'Alexandre Belloni' <alexandre.belloni@free-electrons.com>,
 'Kyungmin Park' <kyungmin.park@samsung.com>
References: <1427728773-29065-1-git-send-email-k.kozlowski@samsung.com>
 <1427728773-29065-3-git-send-email-k.kozlowski@samsung.com>
 <5519DE76.4080803@samsung.com>
 <CABxcv=nDca+B1cpZ3d6PhLmpU-RuFgjGZiNCX5X2HivdAPnt-g@mail.gmail.com>
In-reply-to: <CABxcv=nDca+B1cpZ3d6PhLmpU-RuFgjGZiNCX5X2HivdAPnt-g@mail.gmail.com>
Subject: [rtc-linux] RE: [PATCH 2/2] ARM: dts: s3c-rtc: Use s3c6410-rtc
 instead of exynos3250-rtc
Date: Tue, 31 Mar 2015 15:54:05 +0900
Message-id: <063901d06b7f$7a72d8f0$6f588ad0$@kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Javier Martinez Canillas wrote:
> 
> On Tue, Mar 31, 2015 at 1:38 AM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> > On 03/31/2015 12:19 AM, Krzysztof Kozlowski wrote:
> >> Mark "samsung,exynos3250-rtc" compatible as deprecated because it
> >> duplicates the "samsung,s3c6410-rtc". Use "samsung,s3c6410-rtc" on
> >> Exynos3250 and Exynos4415 boards.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> >> ---
> >>  Documentation/devicetree/bindings/rtc/s3c-rtc.txt | 3 ++-
> >>  arch/arm/boot/dts/exynos3250.dtsi                 | 2 +-
> >>  arch/arm/boot/dts/exynos4415.dtsi                 | 2 +-
> >>  3 files changed, 4 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/rtc/s3c-rtc.txt
> b/Documentation/devicetree/bindings/rtc/s3c-rtc.txt
> >> index ab757b84daa7..ac2fcd6ff4b8 100644
> >> --- a/Documentation/devicetree/bindings/rtc/s3c-rtc.txt
> >> +++ b/Documentation/devicetree/bindings/rtc/s3c-rtc.txt
> >> @@ -6,7 +6,8 @@ Required properties:
> >>      * "samsung,s3c2416-rtc" - for controllers compatible with s3c2416 rtc.
> >>      * "samsung,s3c2443-rtc" - for controllers compatible with s3c2443 rtc.
> >>      * "samsung,s3c6410-rtc" - for controllers compatible with s3c6410 rtc.
> >> -    * "samsung,exynos3250-rtc" - for controllers compatible with exynos3250 rtc.
> >> +    * "samsung,exynos3250-rtc" - (deprecated) for controllers compatible with
> >> +                                 exynos3250 rtc (use "samsung,s3c6410-rtc").
> >>  - reg: physical base address of the controller and length of memory mapped
> >>    region.
> >>  - interrupts: Two interrupt numbers to the cpu should be specified. First
> >> diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
> >> index e3bfb11c6ef8..8d58b550e925 100644
> >> --- a/arch/arm/boot/dts/exynos3250.dtsi
> >> +++ b/arch/arm/boot/dts/exynos3250.dtsi
> >> @@ -189,7 +189,7 @@
> >>               };
> >>
> >>               rtc: rtc@10070000 {
> >> -                     compatible = "samsung,exynos3250-rtc";
> >> +                     compatible = "samsung,s3c6410-rtc";
> >>                       reg = <0x10070000 0x100>;
> >>                       interrupts = <0 73 0>, <0 74 0>;
> >>                       interrupt-parent = <&pmu_system_controller>;
> >> diff --git a/arch/arm/boot/dts/exynos4415.dtsi b/arch/arm/boot/dts/exynos4415.dtsi
> >> index 5caea996e090..186cb8465683 100644
> >> --- a/arch/arm/boot/dts/exynos4415.dtsi
> >> +++ b/arch/arm/boot/dts/exynos4415.dtsi
> >> @@ -177,7 +177,7 @@
> >>               };
> >>
> >>               rtc: rtc@10070000 {
> >> -                     compatible = "samsung,exynos3250-rtc";
> >> +                     compatible = "samsung,s3c6410-rtc";
> >>                       reg = <0x10070000 0x100>;
> >>                       interrupts = <0 73 0>, <0 74 0>;
> >>                       status = "disabled";
> >>
> >
> > Looks good to me.
> >
> > Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> >
> > Thanks,
> > Chanwoo Choi
> > --
> 
> Looks good to me also.
> 
> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> 
Thanks, applied.

- Kukjin

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
