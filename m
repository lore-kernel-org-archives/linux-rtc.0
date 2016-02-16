Return-Path: <rtc-linux+bncBCYKZMUQ7QBBBNWOR23AKGQEZ2U2LGQ@googlegroups.com>
Received: from mail-pf0-x231.google.com (mail-pf0-x231.google.com. [2607:f8b0:400e:c00::231])
        by gmr-mx.google.com with ESMTPS id u66si3931404pfa.2.2016.02.16.14.48.22
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2016 14:48:22 -0800 (PST)
Received: by mail-pf0-x231.google.com with SMTP id e127so112785643pfe.3
        for <rtc-linux@googlegroups.com>; Tue, 16 Feb 2016 14:48:22 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 "Akinobu Mita" <akinobu.mita@gmail.com>
From: Michael Turquette <mturquette@baylibre.com>
In-Reply-To: <20160216004221.GA3310@piout.net>
Cc: rtc-linux@googlegroups.com, linux-clk@vger.kernel.org,
 "Heiko Stuebner" <heiko@sntech.de>,
 "Alessandro Zummo" <a.zummo@towertech.it>,
 "Stephen Boyd" <sboyd@codeaurora.org>
References: <1454249410-21449-1-git-send-email-akinobu.mita@gmail.com>
 <20160216004221.GA3310@piout.net>
Message-ID: <20160216223526.2278.66771@quark.deferred.io>
Subject: [rtc-linux] Re: [PATCH] rtc: rtc-ds1307: add clock provider support
 for DS3231
Date: Tue, 16 Feb 2016 14:35:26 -0800
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Quoting Alexandre Belloni (2016-02-15 16:42:21)
> On 31/01/2016 at 23:10:10 +0900, Akinobu Mita wrote :
> > DS3231 has programmable square-wave output signal.
> > This enables to use this feature as a clock provider of
> > common clock framework.
> > 
> > Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> > Cc: Heiko Stuebner <heiko@sntech.de>
> > Cc: Alessandro Zummo <a.zummo@towertech.it>
> > Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Cc: Stephen Boyd <sboyd@codeaurora.org>
> > ---
> >  .../devicetree/bindings/rtc/maxim,ds3231.txt       |  37 +++
> >  drivers/rtc/rtc-ds1307.c                           | 296 ++++++++++++++++++++-
> >  2 files changed, 332 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/devicetree/bindings/rtc/maxim,ds3231.txt
> > 
> 
> Applied, thanks.

If it's not too late:

Reviewed-by: Michael Turquette <mturquette@baylibre.com>

> 
> -- 
> Alexandre Belloni, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com

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
