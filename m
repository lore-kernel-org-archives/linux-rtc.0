Return-Path: <rtc-linux+bncBCNNJWF7RUMRBXED7CZAKGQEFLITO6A@googlegroups.com>
Received: from mail-pa0-x22e.google.com (mail-pa0-x22e.google.com. [2607:f8b0:400e:c03::22e])
        by gmr-mx.google.com with ESMTPS id 1si5647727pfc.0.2015.12.01.12.23.55
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Dec 2015 12:23:55 -0800 (PST)
Received: by mail-pa0-x22e.google.com with SMTP id hx2so15637507pad.1
        for <rtc-linux@googlegroups.com>; Tue, 01 Dec 2015 12:23:55 -0800 (PST)
Date: Tue, 1 Dec 2015 12:23:51 -0800
From: Joshua Clayton <stillcompiling@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
 linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 6/9] rtc-pcf2123: avoid resetting the clock if possible
Message-ID: <20151201122351.27e3f542@jclayton-pc>
In-Reply-To: <20151124232512.GG3950@piout.net>
References: <cover.1446587705.git.stillcompiling@gmail.com>
	<f801d4f26d4c4944b1a5353d5b5fde4e507b45b2.1446587705.git.stillcompiling@gmail.com>
	<20151124232512.GG3950@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Wed, 25 Nov 2015 00:25:12 +0100
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> On 04/11/2015 at 07:36:37 -0800, Joshua Clayton wrote :
> > +	ret = pcf2123_rtc_read_time(dev, &tm);
> > +	if (ret < 0)
> > +		return false;
> > +
> > +	if (rtc_valid_tm(&tm) < 0) {
> > +		dev_err(dev, "retrieved date/time is not
> > valid.\n");
> > +		return false;
> > +	}
> > +
> 
> I would remove that test as basically, the date/time will only be
> valid when OSC_HAS_STOPPED is not set.
> 
OSC_HAS_STOPPED really only protects us in case everything else
looks good, but we've lost power.
There are other reasons to check for a valid time.
Specifically, if there is no communication with the device, the spi
operation will succeed and return all zeros or all ones.
Since either of these results in an invalid time, it is a nice way
to probe whether we really have a pcf2123 compatible device.

I don't think I should remove this test, but I can add a comment

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
