Return-Path: <rtc-linux+bncBC6MFNV32EFRB5VG3TAAKGQEUCYBSPA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-lf0-x22f.google.com (mail-lf0-x22f.google.com. [2a00:1450:4010:c07::22f])
        by gmr-mx.google.com with ESMTPS id w64si2059724wmf.1.2016.10.31.02.48.38
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Oct 2016 02:48:38 -0700 (PDT)
Received: by mail-lf0-x22f.google.com with SMTP id b81so98668403lfe.1
        for <rtc-linux@googlegroups.com>; Mon, 31 Oct 2016 02:48:38 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH v2 2/7] Documentation: dt: Add binding info
 for jz4740-rtc driver
To: Paul Cercueil <paul@crapouillou.net>, rtc-linux@googlegroups.com,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Ralf Baechle <ralf@linux-mips.org>,
 Maarten ter Huurne <maarten@treewalker.org>,
 Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
References: <20161030230247.20538-1-paul@crapouillou.net>
 <20161030230247.20538-3-paul@crapouillou.net>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <27537b7b-2485-d51c-b2e1-cfd6ba29e5bf@cogentembedded.com>
Date: Mon, 31 Oct 2016 12:48:36 +0300
MIME-Version: 1.0
In-Reply-To: <20161030230247.20538-3-paul@crapouillou.net>
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

> This commit adds documentation for the device-tree bindings of the
> jz4740-rtc driver, which supports the RTC unit present in the JZ4740 and
> JZ4780 SoCs from Ingenic.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Acked-by: Maarten ter Huurne <maarten@treewalker.org>
> ---
>  .../devicetree/bindings/rtc/ingenic,jz4740-rtc.txt | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
>
> v2:
> - Remove 'interrupt-parent' of the list of required properties
> - Add the -msec suffix for the DT entries that represent time
>
> diff --git a/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt b/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
> new file mode 100644
> index 0000000..df97594
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
> @@ -0,0 +1,37 @@
[...]
> +Example:
> +
> +rtc@10003000 {
> +	compatible = "ingenic,jz4740-rtc";
> +	reg = <0x10003000 0x3F>;

    Are you sure it's not 0x40? It's a size, not a limit...

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
