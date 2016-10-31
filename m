Return-Path: <rtc-linux+bncBC6MFNV32EFRB35H3TAAKGQEU5U23GA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-lf0-x22e.google.com (mail-lf0-x22e.google.com. [2a00:1450:4010:c07::22e])
        by gmr-mx.google.com with ESMTPS id 18si1160665wmr.1.2016.10.31.02.50.39
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Oct 2016 02:50:39 -0700 (PDT)
Received: by mail-lf0-x22e.google.com with SMTP id t196so12557468lff.3
        for <rtc-linux@googlegroups.com>; Mon, 31 Oct 2016 02:50:39 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH v2 5/7] MIPS: jz4740: DTS: Probe the
 jz4740-rtc driver from devicetree
To: Paul Cercueil <paul@crapouillou.net>, rtc-linux@googlegroups.com,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Ralf Baechle <ralf@linux-mips.org>,
 Maarten ter Huurne <maarten@treewalker.org>,
 Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
References: <20161030230247.20538-1-paul@crapouillou.net>
 <20161030230247.20538-6-paul@crapouillou.net>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <0c9af39c-85e4-5372-2285-620b2c2863ad@cogentembedded.com>
Date: Mon, 31 Oct 2016 12:50:35 +0300
MIME-Version: 1.0
In-Reply-To: <20161030230247.20538-6-paul@crapouillou.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hello.

On 10/31/2016 2:02 AM, Paul Cercueil wrote:

> Now that the jz4740-rtc driver supports devicetree, we can add a
> devicetree node for it.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Acked-by: Maarten ter Huurne <maarten@treewalker.org>
> ---
>  arch/mips/boot/dts/ingenic/jz4740.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> v2: Previous patch 5/5 was garbage. This is a new patch.
>
> diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi b/arch/mips/boot/dts/ingenic/jz4740.dtsi
> index f6ae6ed..c6acd6a 100644
> --- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
> +++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
> @@ -44,6 +44,17 @@
>  		#clock-cells = <1>;
>  	};
>
> +	rtc_dev: jz4740-rtc@10003000 {

    Just "rtc@10003000" to comply with the DT spec.

[...]

MBR, Sergei

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
