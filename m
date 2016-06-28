Return-Path: <rtc-linux+bncBDJIP47K7MERBJ6JZO5QKGQEGTMDDFA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-qk0-f195.google.com (mail-qk0-f195.google.com. [209.85.220.195])
        by gmr-mx.google.com with ESMTPS id x204si21913ywb.1.2016.06.28.13.57.11
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jun 2016 13:57:11 -0700 (PDT)
Received: by mail-qk0-f195.google.com with SMTP id n132so5912400qka.0
        for <rtc-linux@googlegroups.com>; Tue, 28 Jun 2016 13:57:11 -0700 (PDT)
Date: Tue, 28 Jun 2016 15:57:04 -0500
From: Rob Herring <robh@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: rtc-linux@googlegroups.com, devicetree@vger.kernel.org,
	Sergey Yanovich <ynvich@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] Re: [PATCH v2 2/2] rtc: ds1302: support control with
 using GPIO lines
Message-ID: <20160628205704.GT3737@rob-hp-laptop>
References: <1467026362-29446-1-git-send-email-akinobu.mita@gmail.com>
 <1467026362-29446-3-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1467026362-29446-3-git-send-email-akinobu.mita@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Mon, Jun 27, 2016 at 08:19:22PM +0900, Akinobu Mita wrote:
> This adds support control with GPIO lines connected to the DS1302
> which can communicate with three wires.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Sergey Yanovich <ynvich@gmail.com>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  .../devicetree/bindings/rtc/maxim-ds1302.txt       |  13 +
>  drivers/rtc/Kconfig                                |  17 +-
>  drivers/rtc/rtc-ds1302.c                           | 320 ++++++++++++++++++++-
>  3 files changed, 331 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/maxim-ds1302.txt b/Documentation/devicetree/bindings/rtc/maxim-ds1302.txt
> index ba470c5..d489753 100644
> --- a/Documentation/devicetree/bindings/rtc/maxim-ds1302.txt
> +++ b/Documentation/devicetree/bindings/rtc/maxim-ds1302.txt
> @@ -27,6 +27,12 @@ Required SPI properties:
>  - spi-cs-high: DS-1302 has active high chip select line. This is
>    required unless inverted in hardware.
>  
> +Required properties when using GPIO lines:
> +
> +- gpio-ce: GPIO connected to CE pin
> +- gpio-io: GPIO connected to I/O pin
> +- gpio-reset: GPIO connected to SCLK pin
> +

IIRC, we got rid of the direct gpio bit-banging in this driver (or a 
similar one) and replaced it with SPI GPIO driver. We should do that 
here.

Rob

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
