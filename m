Return-Path: <rtc-linux+bncBCNNJWF7RUMRBPGJ66ZAKGQEBPIB5KQ@googlegroups.com>
Received: from mail-pa0-x22a.google.com (mail-pa0-x22a.google.com. [2607:f8b0:400e:c03::22a])
        by gmr-mx.google.com with ESMTPS id pe1si6250974pac.2.2015.12.01.10.19.40
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Dec 2015 10:19:40 -0800 (PST)
Received: by mail-pa0-x22a.google.com with SMTP id hx2so12560112pad.1
        for <rtc-linux@googlegroups.com>; Tue, 01 Dec 2015 10:19:40 -0800 (PST)
Date: Tue, 1 Dec 2015 10:19:36 -0800
From: Joshua Clayton <stillcompiling@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
 linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 3/9] rtc-pcf2123: clean up writes to the rtc chip
Message-ID: <20151201101936.596e0186@jclayton-pc>
In-Reply-To: <20151124221626.GE3950@piout.net>
References: <cover.1446587705.git.stillcompiling@gmail.com>
	<813a6fe306c384c59418495605236927b9d00940.1446587705.git.stillcompiling@gmail.com>
	<20151124221626.GE3950@piout.net>
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

On Tue, 24 Nov 2015 23:16:26 +0100
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> On 04/11/2015 at 07:36:34 -0800, Joshua Clayton wrote :
> > +static int pcf2123_write(struct device *dev, u8 *txbuf, size_t
> > size) +{
> > +	struct spi_device *spi = to_spi_device(dev);
> > +	int ret;
> > +
> > +	if (txbuf[0] > PCF2123_REG_MAX)
> > +		return -EFAULT;
> > +
> 
> Is that test really necessary? From what I understand the driver
> always controls which register is written.
> 

In the larger context of the driver, you are correct, there is 
no way for an out of range request unless someone were to add new code.
I can remove it. 

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
