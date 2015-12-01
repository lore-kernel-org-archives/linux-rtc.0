Return-Path: <rtc-linux+bncBCNNJWF7RUMRBT6K66ZAKGQEJ4BPARA@googlegroups.com>
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com. [2607:f8b0:400e:c03::22d])
        by gmr-mx.google.com with ESMTPS id pe1si6254041pac.2.2015.12.01.10.22.07
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Dec 2015 10:22:07 -0800 (PST)
Received: by mail-pa0-x22d.google.com with SMTP id fh17so13085822pab.0
        for <rtc-linux@googlegroups.com>; Tue, 01 Dec 2015 10:22:07 -0800 (PST)
Date: Tue, 1 Dec 2015 10:22:03 -0800
From: Joshua Clayton <stillcompiling@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
 linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 5/9] rtc-pcf2123: put the chip reset into a function
Message-ID: <20151201102203.64119ba9@jclayton-pc>
In-Reply-To: <20151124231736.GF3950@piout.net>
References: <cover.1446587705.git.stillcompiling@gmail.com>
	<dd040a11817f2caac1db13ec49c64f603013b982.1446587705.git.stillcompiling@gmail.com>
	<20151124231736.GF3950@piout.net>
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

On Wed, 25 Nov 2015 00:17:36 +0100
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> On 04/11/2015 at 07:36:36 -0800, Joshua Clayton wrote :
> 
> A commit message, even when simple is mandatory.
> 
Sorry about that. I know better. will fix for v2
 
> > +	/* See if the counter was actually stopped */
> > +	dev_dbg(dev, "checking for presence of RTC\n");
> > +	ret = pcf2123_read(dev, PCF2123_REG_CTRL1, rxbuf,
> > sizeof(rxbuf));
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	dev_dbg(dev, "received data from RTC (0x%02X 0x%02X)\n",
> > +			rxbuf[0], rxbuf[1]);
> 
> This is not properly aligned (use checkpatch --strict)
> 
> 
Will fix.

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
