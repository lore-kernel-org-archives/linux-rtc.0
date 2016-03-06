Return-Path: <rtc-linux+bncBC6MFNV32EFRBB566C3AKGQEJ76J5AI@googlegroups.com>
Received: from mail-lb0-x230.google.com (mail-lb0-x230.google.com. [2a00:1450:4010:c04::230])
        by gmr-mx.google.com with ESMTPS id rx10si341720lbb.0.2016.03.06.04.13.58
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Mar 2016 04:13:58 -0800 (PST)
Received: by mail-lb0-x230.google.com with SMTP id x1so103761377lbj.3
        for <rtc-linux@googlegroups.com>; Sun, 06 Mar 2016 04:13:58 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH 2/5] Documentation: dt: Add binding info for
 jz4740-rtc driver
To: Paul Cercueil <paul@crapouillou.net>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <1457217531-26064-1-git-send-email-paul@crapouillou.net>
 <1457217531-26064-2-git-send-email-paul@crapouillou.net>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>, Ralf Baechle <ralf@linux-mips.org>,
 Alessandro Zummo <a.zummo@towertech.it>, Paul Burton
 <paul.burton@imgtec.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
 rtc-linux@googlegroups.com
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <56DC1F04.7050907@cogentembedded.com>
Date: Sun, 6 Mar 2016 15:13:56 +0300
MIME-Version: 1.0
In-Reply-To: <1457217531-26064-2-git-send-email-paul@crapouillou.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hello.

On 3/6/2016 1:38 AM, Paul Cercueil wrote:

> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>   .../devicetree/bindings/rtc/ingenic,jz4740-rtc.txt | 38 ++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
>
> diff --git a/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt b/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
> new file mode 100644
> index 0000000..71e4ad0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
> @@ -0,0 +1,38 @@
> +JZ4740 and similar SoCs real-time clock driver
> +
> +Required properties:
> +
> +- compatible: One of:
> +  - "ingenic,jz4740-rtc" - for use with the JZ4740 SoC
> +  - "ingenic,jz4780-rtc" - for use with the JZ4780 SoC
> +- reg: Address range of rtc register set
> +- interrupts: IRQ number for the alarm interrupt
> +- interrupt-parent: phandle of the interrupt controller

    This is never a required property, it can be inherited from the parent node.

[...]

MBR, Sergei

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
