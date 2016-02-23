Return-Path: <rtc-linux+bncBAABB2VQWK3AKGQE4DVBSIA@googlegroups.com>
Received: from email.microchip.com (exsmtp03.microchip.com. [198.175.253.49])
        by gmr-mx.google.com with ESMTPS id 12si3949317pfb.1.2016.02.23.09.35.38
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Feb 2016 09:35:38 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH v2 2/2] rtc: rtc-pic32: Add PIC32 real time
 clock driver
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <1455905390-3491-2-git-send-email-joshua.henderson@microchip.com>
 <20160219181712.GD2222@piout.net>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Rob Herring
	<robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland
	<mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar
 Gala <galak@codeaurora.org>, Alessandro Zummo <a.zummo@towertech.it>,
	<rtc-linux@googlegroups.com>
From: Joshua Henderson <joshua.henderson@microchip.com>
Message-ID: <56CC9894.7000307@microchip.com>
Date: Tue, 23 Feb 2016 10:36:20 -0700
MIME-Version: 1.0
In-Reply-To: <20160219181712.GD2222@piout.net>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Alexandre,

On 02/19/2016 11:17 AM, Alexandre Belloni wrote:
> Hi,
> 
> On 19/02/2016 at 11:09:45 -0700, Joshua Henderson wrote :
>> This driver adds support for the PIC32 real time clock and calendar
>> peripheral:
>> 	- reading and setting time
>> 	- alarms when connected to an IRQ
> 
> Just for confirmation, your probe() fails hard when there are no IRQ
> specified or the IRQ request fails.
> 
> I'll review later but if that the only thing, I can fix it up when
> applying, no need to resend.
> 

probe() does indeed fail when no interrupt is specified:

  ...
  pic32-rtc 1f8c0000.rtc: no irq for alarm
  ...
  hctosys: unable to open rtc device (rtc0)
  ...

If I'm following, I think there right answer here is to just change the wording
in the commit message to be clear that the interrupt is not conditional.  It's
required via binding.  This peripheral has a dedicated interrupt and I can't
imagine a case where it makes sense not to specify it.

I'm fine with something like "- alarms provided by dedicated interrupt" as a
replacement.

Josh

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
