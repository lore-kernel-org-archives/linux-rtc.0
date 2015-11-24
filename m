Return-Path: <rtc-linux+bncBDJIP47K7MERB37R2OZAKGQEGDBHDLY@googlegroups.com>
Received: from mail-oi0-f42.google.com (mail-oi0-f42.google.com. [209.85.218.42])
        by gmr-mx.google.com with ESMTPS id u5si54546igh.1.2015.11.24.15.55.27
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2015 15:55:27 -0800 (PST)
Received: by oixx65 with SMTP id x65so20063170oix.0
        for <rtc-linux@googlegroups.com>; Tue, 24 Nov 2015 15:55:27 -0800 (PST)
Date: Tue, 24 Nov 2015 17:55:24 -0600
From: Rob Herring <robh@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
	rtc-linux@googlegroups.com, Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>, kernel@pengutronix.de,
	Kumar Gala <galak@codeaurora.org>
Subject: [rtc-linux] Re: [PATCH 1/2] Documentation: devicetree: add epson
 rx6110 binding
Message-ID: <20151124235524.GB18195@rob-hp-laptop>
References: <1448361533-10728-1-git-send-email-s.trumtrar@pengutronix.de>
 <1448363561.3346.57.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1448363561.3346.57.camel@pengutronix.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Tue, Nov 24, 2015 at 12:12:41PM +0100, Philipp Zabel wrote:
> Am Dienstag, den 24.11.2015, 11:38 +0100 schrieb Steffen Trumtrar:
> > Add the binding documentation for the Epson RX6110 RTC.
> > 
> > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

[...]

> > +Required properties:
> > +- compatible: should be: "epson,rtc-rx6110"
> 
> Should this just be "epson,rx6110" ?

Yes.

 

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
