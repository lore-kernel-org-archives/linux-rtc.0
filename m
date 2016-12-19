Return-Path: <rtc-linux+bncBCQJP74GSUDRBRVI33BAKGQEEGIQ4KQ@googlegroups.com>
Received: from mail-it0-x243.google.com (mail-it0-x243.google.com. [2607:f8b0:4001:c0b::243])
        by gmr-mx.google.com with ESMTPS id c68si1394621ith.1.2016.12.19.00.03.18
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Dec 2016 00:03:18 -0800 (PST)
Received: by mail-it0-x243.google.com with SMTP id c20so9507624itb.0
        for <rtc-linux@googlegroups.com>; Mon, 19 Dec 2016 00:03:18 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20161109003753.29759-2-alexandre.belloni@free-electrons.com>
References: <20161109003753.29759-1-alexandre.belloni@free-electrons.com> <20161109003753.29759-2-alexandre.belloni@free-electrons.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 19 Dec 2016 09:03:17 +0100
Message-ID: <CAMuHMdV5yOktsrBDVJy11PPX6ObuBKiyP6smqDTettoAg7WeiQ@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 2/2] rtc: jz4740: make the driver builtin only
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, Paul Cercueil <paul@crapouillou.net>,
	RTCLINUX <rtc-linux@googlegroups.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Alexandre,

On Wed, Nov 9, 2016 at 1:37 AM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> Since the driver is now calling machine_halt() that is not exported, it has
> to be built in the kernel. Building it as a module will fail at linking
> time.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/rtc/Kconfig      |  5 +----
>  drivers/rtc/rtc-jz4740.c | 10 +---------
>  2 files changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 4259ce61c31b..24b0778f6e28 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1550,15 +1550,12 @@ config RTC_DRV_MPC5121
>           will be called rtc-mpc5121.
>
>  config RTC_DRV_JZ4740
> -       tristate "Ingenic JZ4740 SoC"
> +       bool "Ingenic JZ4740 SoC"

Just noticed RTC_DRV_JZ4740 flipped from m to y.

This is bad for distribution kernels.
Can't the driver just call kernel_halt() instead of machine_halt()?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
