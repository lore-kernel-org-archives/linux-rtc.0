Return-Path: <rtc-linux+bncBC4L3MVYV4CBBF65T66AKGQEIEEMY2A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from smtp.natisbad.org (36.223.133.77.rev.sfr.net. [77.133.223.36])
        by gmr-mx.google.com with ESMTP id o10si400890wme.0.2016.07.14.12.57.11
        for <rtc-linux@googlegroups.com>;
        Thu, 14 Jul 2016 12:57:11 -0700 (PDT)
From: arno@natisbad.org (Arnaud Ebalard)
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,  rtc-linux@googlegroups.com,  linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 2/3] rtc: ds1307: add Intersil ISL12057 support
References: <1468371571-22641-1-git-send-email-alexandre.belloni@free-electrons.com>
	<1468371571-22641-3-git-send-email-alexandre.belloni@free-electrons.com>
Date: Thu, 14 Jul 2016 21:57:07 +0200
In-Reply-To: <1468371571-22641-3-git-send-email-alexandre.belloni@free-electrons.com>
	(Alexandre Belloni's message of "Wed, 13 Jul 2016 02:59:30 +0200")
Message-ID: <877fcohu24.fsf@natisbad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


Alexandre Belloni <alexandre.belloni@free-electrons.com> writes:

> Intersil ISL12057 is a drop-in replacement for DS1337. It can be supported
> by the ds1307 driver.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/rtc/Kconfig      | 8 ++++----
>  drivers/rtc/rtc-ds1307.c | 6 ++++++
>  2 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index f47c2f5ff70d..ba0b3e7ce4c5 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -198,14 +198,14 @@ config RTC_DRV_AS3722
>  	  will be called rtc-as3722.
>  
>  config RTC_DRV_DS1307
> -	tristate "Dallas/Maxim DS1307/37/38/39/40, ST M41T00, EPSON RX-8025"
> +	tristate "Dallas/Maxim DS1307/37/38/39/40, ST M41T00, EPSON RX-8025, ISL12057"
>  	help
>  	  If you say yes here you get support for various compatible RTC
>  	  chips (often with battery backup) connected with I2C. This driver
>  	  should handle DS1307, DS1337, DS1338, DS1339, DS1340, ST M41T00,
> -	  EPSON RX-8025 and probably other chips. In some cases the RTC
> -	  must already have been initialized (by manufacturing or a
> -	  bootloader).
> +	  EPSON RX-8025, Intersil ISL12057 and probably other chips. In some
> +	  cases the RTC must already have been initialized (by manufacturing or
> +	  a bootloader).
>  
>  	  The first seven registers on these chips hold an RTC, and other
>  	  registers may add features such as NVRAM, a trickle charger for
> diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
> index 4c5890864d9c..52be48f2e3c0 100644
> --- a/drivers/rtc/rtc-ds1307.c
> +++ b/drivers/rtc/rtc-ds1307.c
> @@ -186,6 +186,7 @@ static const struct i2c_device_id ds1307_id[] = {
>  	{ "mcp7941x", mcp794xx },
>  	{ "pt7c4338", ds_1307 },
>  	{ "rx8025", rx_8025 },
> +	{ "isl1207", ds_1337 },

          "isl12057"

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
