Return-Path: <rtc-linux+bncBCQJP74GSUDRBXGU7CWAKGQEMJU4I6Q@googlegroups.com>
Received: from mail-ob0-x22e.google.com (mail-ob0-x22e.google.com. [2607:f8b0:4003:c01::22e])
        by gmr-mx.google.com with ESMTPS id b7si484011igv.3.2015.07.09.01.01.31
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2015 01:01:31 -0700 (PDT)
Received: by mail-ob0-x22e.google.com with SMTP id bs4so167114539obd.3
        for <rtc-linux@googlegroups.com>; Thu, 09 Jul 2015 01:01:31 -0700 (PDT)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <cover.1436427954.git.stwiss.opensource@diasemi.com>
References: <cover.1436427954.git.stwiss.opensource@diasemi.com>
Date: Thu, 9 Jul 2015 10:01:31 +0200
Message-ID: <CAMuHMdU_AUZ9nxo25NeaFq1MeeSDZErqkNnDtXsdr7=jLm1kTw@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH RFC V1 0/3] da9062: Add DA9062 RTC support
 using the existing DA9063 RTC driver
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: S Twiss <stwiss.opensource@diasemi.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	DEVICETREE <devicetree@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, LINUXINPUT <linux-input@vger.kernel.org>,
	LINUXKERNEL <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>,
	RTCLINUX <rtc-linux@googlegroups.com>, Rob Herring <robh+dt@kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>, David Dajun Chen <david.chen@diasemi.com>,
	Support Opensource <support.opensource@diasemi.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi Steve,

On Thu, Jul 9, 2015 at 9:45 AM, S Twiss <stwiss.opensource@diasemi.com> wrote:
> From: S Twiss <stwiss.opensource@diasemi.com>
>
> This patch set adds RTC support for the Dialog DA9062 Power Management IC.
> Changes are made to the existing DA9063 RTC component so that functionality
> in this device driver can be re-used to support the DA9062 RTC.

[...]

> S Twiss (3):
>   mfd: da9062: Support for the DA9063 RTC in the DA9062 core

"DA9062 RTC"?

>   rtc: da9063: Add DA9062 RTC capability to DA9063 RTC driver
>   devicetree: da9062: Add device tree bindings for DA9062 RTC

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

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
