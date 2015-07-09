Return-Path: <rtc-linux+bncBAABB3HH7CWAKGQEQJES7TI@googlegroups.com>
Received: from mail1.bemta14.messagelabs.com (mail1.bemta14.messagelabs.com. [193.109.254.116])
        by gmr-mx.google.com with ESMTPS id ec7si257815wib.3.2015.07.09.01.42.20
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2015 01:42:20 -0700 (PDT)
From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni
	<alexandre.belloni@free-electrons.com>, DEVICETREE
	<devicetree@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, LINUXINPUT <linux-input@vger.kernel.org>,
	LINUXKERNEL <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>,
	RTCLINUX <rtc-linux@googlegroups.com>, Rob Herring <robh+dt@kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>, David Dajun Chen
	<david.chen@diasemi.com>, Support Opensource <Support.Opensource@diasemi.com>
Subject: [rtc-linux] RE: [PATCH RFC V1 0/3] da9062: Add DA9062 RTC support
 using the existing DA9063 RTC driver
Date: Thu, 9 Jul 2015 08:42:16 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B23FDDA@SW-EX-MBX02.diasemi.com>
References: <cover.1436427954.git.stwiss.opensource@diasemi.com>
 <CAMuHMdU_AUZ9nxo25NeaFq1MeeSDZErqkNnDtXsdr7=jLm1kTw@mail.gmail.com>
In-Reply-To: <CAMuHMdU_AUZ9nxo25NeaFq1MeeSDZErqkNnDtXsdr7=jLm1kTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 09 July 2015 09:02, Geert Uytterhoeven wrote:

> Subject: Re: [PATCH RFC V1 0/3] da9062: Add DA9062 RTC support using the
> existing DA9063 RTC driver
> 
> Hi Steve,
> 
> On Thu, Jul 9, 2015 at 9:45 AM, S Twiss <stwiss.opensource@diasemi.com>
> wrote:
> > From: S Twiss <stwiss.opensource@diasemi.com>
> >
> > This patch set adds RTC support for the Dialog DA9062 Power Management IC.
> > Changes are made to the existing DA9063 RTC component so that functionality
> > in this device driver can be re-used to support the DA9062 RTC.
> 
> [...]
> 
> > S Twiss (3):
> >   mfd: da9062: Support for the DA9063 RTC in the DA9062 core
> 
> "DA9062 RTC"?
> 

Hi Geert,

It's the support for the "DA9063 RTC *driver* in the DA9062 MFD driver core".

I'm re-working the DA9063 RTC driver to support DA9062 RTC hardware. This will make
the name "DA9063 RTC driver" interchangeable with "DA9062 RTC driver", because if this
patch goes through they will both be using the original "DA9063 RTC driver".

Confused?  :-/

I suppose I could also have called this patch "support for the DA9062 RTC H/W in the
DA9062 MFD driver core".

This comes from a previous thread here:
https://lkml.org/lkml/2015/5/13/406
https://lkml.org/lkml/2015/5/13/528

Regards,
Steve

[...]

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
