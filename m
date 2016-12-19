Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBOOZ33BAKGQE6BIBQEY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id e134si1087292wmd.3.2016.12.19.01.47.37
        for <rtc-linux@googlegroups.com>;
        Mon, 19 Dec 2016 01:47:37 -0800 (PST)
Date: Mon, 19 Dec 2016 10:47:36 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Paul Cercueil <paul@crapouillou.net>,
	RTCLINUX <rtc-linux@googlegroups.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [rtc-linux] Re: [PATCH 2/2] rtc: jz4740: make the driver builtin only
Message-ID: <20161219094736.pa2o3xfxos66j7b4@piout.net>
References: <20161109003753.29759-1-alexandre.belloni@free-electrons.com>
 <20161109003753.29759-2-alexandre.belloni@free-electrons.com>
 <CAMuHMdV5yOktsrBDVJy11PPX6ObuBKiyP6smqDTettoAg7WeiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAMuHMdV5yOktsrBDVJy11PPX6ObuBKiyP6smqDTettoAg7WeiQ@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 19/12/2016 at 09:03:17 +0100, Geert Uytterhoeven wrote :
> On Wed, Nov 9, 2016 at 1:37 AM, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
> > Since the driver is now calling machine_halt() that is not exported, it has
> > to be built in the kernel. Building it as a module will fail at linking
> > time.
> >
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > ---
> >  drivers/rtc/Kconfig      |  5 +----
> >  drivers/rtc/rtc-jz4740.c | 10 +---------
> >  2 files changed, 2 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> > index 4259ce61c31b..24b0778f6e28 100644
> > --- a/drivers/rtc/Kconfig
> > +++ b/drivers/rtc/Kconfig
> > @@ -1550,15 +1550,12 @@ config RTC_DRV_MPC5121
> >           will be called rtc-mpc5121.
> >
> >  config RTC_DRV_JZ4740
> > -       tristate "Ingenic JZ4740 SoC"
> > +       bool "Ingenic JZ4740 SoC"
> 
> Just noticed RTC_DRV_JZ4740 flipped from m to y.
> 
> This is bad for distribution kernels.
> Can't the driver just call kernel_halt() instead of machine_halt()?
> 

I'm not sure and I can't test. Paul, can you test?

Maybe the other concern is that users that are not loading the rtc
module will probably complain their machine is not powering off.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
